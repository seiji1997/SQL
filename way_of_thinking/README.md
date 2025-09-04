# Snowflake × Crunchy / Databricks × Neon による“Postgresシフト”
**— 戦略／実装／示唆**  

---

## エグゼクティブサマリー
- **同時多発の動き**：2025年5–6月、**Databricks が Neon の買収合意**、**Snowflake が Crunchy Data の買収と “Snowflake Postgres” を発表**。加えて **Databricks “Lakebase”** の **Public Preview**。いずれも**運用(OLTP)×分析(OLAP)×AI**の一体運用を狙う。（参考: [1], [2], [3], [4], [5]）
- **共通のねらい**：①アナリティクス基盤でも**OLTP需要の取り込み**、②**HTAP/“Zero‑ETL”**の現実解（**同期**による即時分析）、③**データ/AIの業務埋め込み**。（参考: [1], [4], [6], [7], [8], [9]）
- **差分の本質**：**Snowflake × Crunchy**＝**Enterprise‑ready Postgres**を**AI Data Cloud**へ統合し、**Unistore/Hybrid Tables**と合わせ**単一ガバナンス**を強化。**Databricks × Neon**＝**サーバレス Postgres**を**ブランチング**等で開発速度に最適化し、**AIエージェント/データアプリ**に強い。（参考: [3], [4], [11], [12], [13], [14], [15]）
- **実務の要点**：“Zero‑ETL”は**ゼロ作業**ではない。**同期モード（Snapshot/Triggered/Continuous）**、**CDF(Change Data Feed)** 前提、**遅延・重複・順序**への対策、**再送SOP**と**SLO/KPI**の明確化が必要。（参考: [8], [9], [10], [6]）
- **未確定事項**：**Snowflake Postgres の詳細仕様**は今後の発表に依存。設計は**複数パス**（価格感度/移行段階/運用体制）で準備。（参考: [4]）

---

## 1. タイムライン（2025年）
- **05/14**：Databricks が **Neon 買収合意**を発表（サーバレス Postgres／分離アーキ／ブランチ）。（参考: [2], [3]）  
- **06/02**：Snowflake が **Crunchy Data 買収**と **“Snowflake Postgres”** を発表。（参考: [4], [5]）  
- **06/11**：**Lakebase Public Preview** 公開。（参考: [1], [7]）  

---

## 2. アーキテクチャ比較（要約）
**要旨**：Snowflake は **Hybrid Tables/Unistore** と **Snowflake Postgres** を**ガバナンス（Horizon）**と組み合わせて統合運用を志向。Databricks は **Lakebase（Postgres）** と **Synced Tables**、**Unity Catalog** を軸に**運用×分析×AI**の往復を低摩擦化。（参考: [1], [4], [11], [12], [13], [14]）

| 観点             | Snowflake Postgres（＋Crunchy）                                                     | Databricks Lakebase（＋Neon）                                                                |
|------------------|-------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| 中核の方向性     | **Enterprise‑ready Postgres** を Snowflake に統合。**Unistore/Hybrid Tables**を補完 | **サーバレス Postgres**で**新規アプリ/AIエージェント**に最適化                               |
| 同期/連携        | **Postgres → Iceberg** の**論理レプリケーション**（Crunchy DW）で分析側へ継続反映   | **Synced Tables**（**Snapshot/Triggered/Continuous**。Triggered/Continuous は **CDF** 必須） |
| ガバナンス       | **Snowflake Horizon**で**データ/アプリ/モデル**を一体管理                           | **Unity Catalog**で**データ/AI資産**を一元ガバナンス                                         |
| 代表ユースケース | 既存の**本番OLTP移行**と**ガバナンス統合**                                          | **高速ブランチ**で**多環境/多テナント**開発、**エージェント**実行基盤                        |
| 技術的特性       | **Hybrid Tables（Unistore）**でOLTP/OLAPを単一エンジンに                            | **ストレージ/コンピュート分離**、**COWブランチング**、**スケールtoゼロ**                     |
| 価格/提供        | **詳細未公表**（続報待ち）                                                          | Public Preview。Docsに**運用モード**を明記                                                   |

（参考: [4], [6], [11], [12], [13], [14], [8], [9], [15], [16]）

---

## 3. “Zero‑ETL”の現実：同期モードと運用設計
- **同期モード**：  
  - **Snapshot**＝定期スナップショット取り込み。  
  - **Triggered**＝Change Data Feed（CDF）を用いたトリガ駆動。  
  - **Continuous**＝CDFの連続適用（低遅延）。  
  （参考: [8], [9], [10]）
- **運用での落とし穴**：**遅延（p95/p99）**、**重複**、**順不同**を前提に**idempotency**・**再送SOP**・**リカバリ手順**を定義。Databricks **AUTO CDC** 等で順不同を吸収しても、**SLO/KPI**（遅延・再処理時間・重複率）を明文化。（参考: [8], [9], [10]）  
- **Crunchy の裏付け**：**Postgres→Iceberg**の**ネイティブ論理レプリケーション**で“分析すぐ使える”を実装。（参考: [6]）

---

## 4. ガバナンス統合
- **Snowflake**：**Horizon** により **カタログ／権限／監査／プライバシ／アプリ／モデル**を統合。**Hybrid Tables**や**Snowflake Postgres**と一体で**統治の単一窓口**を形成。（参考: [13], [11], [4]）  
- **Databricks**：**Unity Catalog** を基盤に、**データ・機能（DLT/Lakeflow/Apps）・AI資産**まで**ポリシー一元管理**（RLS/マスキング/ラインエージ）。（参考: [14]）

---

## 5. 導入ブループリント（90日）
**Day 0–30｜要件と設計**  
- 候補ワークロード選定（RPO/RTO/レイテンシ/更新頻度/容量）。  
- 同期方式の設計（Snapshot/Triggered/Continuous）。**CDF可用性**・**ソース特性**（ビュー等の制約）を確認。  
- ガバナンスポリシー（Horizon／Unity Catalog）初期設定。  
（参考: [9], [10], [11], [13], [14]）

**Day 31–60｜PoC/パイロット**  
- **Postgres→Lakehouse 同期**を実装（Crunchy 論理レプリケーション／Lakebase Synced Tables）。  
- **SLO/KPI**：データ遅延（p95）、重複率、順不同リカバリ時間／読み取りp95、更新スループット、**ブランチ作成時間（Neon）**。  
（参考: [6], [9], [15]）

**Day 61–90｜本番準備**  
- **再送SOP**・バックフィル・リトライ戦略の確定（CDF活用）。  
- **監査・ラインエージ・品質**監視の運用化（UC/Horizon）。  
- **切替計画**（段階移行／デュアルラン／ロールバック）。  
（参考: [9], [10], [13], [14]）

---

## 6. リスクと対応
- **“ゼロ作業”誤解**：同期は**運用**。**監視・再送・順序保証**のSOPを整備。（参考: [8], [9], [10]）  
- **CDF制約**：ソースの**ビュー**等は増分非対応 → **Snapshot＋インクリメンタル**で設計。（参考: [9], [10]）  
- **コールドスタート**：サーバレスDBの**スリープ復帰**は最適化進行中。**Neon**は短縮を報告。アプリ側は**接続プール/ウォームアップ**で吸収。（参考: [16], [15]）  
- **未確定要素**：**Snowflake Postgresの詳細**は続報待ち。価格設計は**感度分析**を含める。（参考: [4]）

---

## 7. 監視すべき動向（今後3–6か月）
1) **Snowflake Postgres** の仕様/価格/GА時期。（参考: [4]）  
2) **Lakebase** の同期スループット・レイテンシ改善、Apps 連携強化。（参考: [1], [8], [9]）  
3) **Crunchy DW** の Iceberg 連携と監視UI。（参考: [6]）  
4) **Neon** のブランチ/スケールtoゼロ体験の継続改善。（参考: [15], [16]）

---

## 8. TL;DR
- **両社の共通項**：OLTP×OLAP×AIの**一体運用**をPostgres軸で前進。（参考: [1], [4]）  
- **差分**：Snowflake は**既存本番移行＋統治の単一窓口**、Databricks は**サーバレス/ブランチ**で**開発速度とエージェント適性**。（参考: [3], [4], [11], [12], [13], [15]）  
- **実装**：**同期モード/CDF/CDC**の**現実運用**を前提に、**SLO・SOP**と**UC/Horizon**の**一元ガバナンス**を最初から設計。（参考: [8], [9], [10], [13], [14]）

---


# それぞれの“役割”

## Snowflake × Crunchy（Snowflake Postgres）
- **役割**：エンタープライズの既存本番 OLTP を、安全に Snowflake へ“持ち上げる”受け皿。  
- **強み**：可用性・予測可能な運用・監査/権限（Horizon）・データ共有・Unistore/Hybrid Tables との親和性。  
- **ねらい**：**統治一体化**（ガバナンス/監査/データ共有）を効かせつつ、分析やアプリ側と**同一平面**で回す。

## Databricks × Neon（Lakebase + Serverless Postgres）
- **役割**：新規アプリ/AI エージェント開発を“**サーバレス × ブランチング**”で**高速化**する実験と本番の土台。  
- **強み**：ブランチ（COW）での**環境複製**、**スケール to ゼロ**、**Synced Tables（Snapshot/Triggered/Continuous）**で**ほぼリアルタイム同期**、Apps/LLM 統合。  
- **ねらい**：**開発〜検証〜本番**の**短サイクル化**と、**AI を UI/業務動線に埋め込む**スピード最適化。

---

# それが達成されると、どんな世界観？

## 1) “運用 → 分析 → AI → 運用”が一枚の床で回る
- 取引（Postgres） → **数秒〜分**でレイクハウスへ同期 → 集計/特徴量/推論 → **結果が即アプリへ反映**。  
- ダッシュボードで終わらず、**レコメンドや AI エージェント**がそのまま**画面・業務に常駐**。

## 2) “移行の安心”と“開発の速さ”を両立
- 既存のミッションクリティカル系は **Snowflake Postgres** 側で**ガバナンス一体運用**。  
- 新規/実験的機能は **Neon のブランチ**で即席の環境を切って試し、良ければ本線にマージ。

## 3) チームの働き方が変わる
- **データエンジニア**：ETL の配線作業が減り、**同期モードと再送 SOP** の設計に注力。  
- **アプリ/ML エンジニア**：**ブランチ単位**で機能＋特徴量＋DB を**丸ごと複製**して検証。  
- **セキュリティ/ガバナンス**：**Horizon / Unity Catalog** により**権限・監査・リネージ**を一元管理。

---

# Before / After（サマリ）

| 観点 | いま（Before） | 達成後（After） |
|---|---|---|
| データ連携 | バッチ ETL 中心・待ち時間長い | **Triggered/Continuous 同期**でほぼリアルタイム |
| 開発速度 | DB/分析/AI が縦割り | **サーバレス × ブランチ**で数分〜数時間単位の検証 |
| ガバナンス | システムごと分散 | **Horizon / Unity Catalog** で一元化 |
| 本番移行 | 移行コスト・リスク高 | **Snowflake Postgres** で**段階移行＋統治一体化** |
| AI の埋め込み | POC 止まり | **常時稼働のエージェント/レコメンド**として運用 |

---

# どう使い分ける？（超シンプル指針）
- **既存本番の信頼性・統治・共有が最優先** → **Snowflake Postgres（＋Unistore/Hybrid Tables）** を主軸に。  
- **新機能/AI エージェントを高速反復** → **Neon ＋ Lakebase（Synced Tables）** を主軸に。  
- 実務では**両方を併走**：**基幹は Snowflake、攻めは Databricks、同期で循環**させるのが現実解。

---

# 成果を測る KPI（例）
- **データ遅延 p95**（運用 → 分析 → 反映まで）  
- **実験〜本番のリードタイム**（ブランチ作成 → マージ）  
- **重複/順不同の再処理時間**、**権限違反ゼロ件継続日数**  
- **新機能リリース頻度**、**AI 機能の採用率/CTR/収益貢献**

---

# 一文で
> **Snowflake は“安心して載せる基幹の土台”、Databricks は“速く作って回す加速装置”。** 両者が**同期でつながる**と、**データ → AI → アプリ反映**が**同じ床**で回る世界になります。

-----

## 参考文献（番号順）
1. Databricks: *Announcing Lakebase Public Preview* (2025-06-11) — https://www.databricks.com/blog/announcing-lakebase-public-preview  
2. Databricks Press: *Databricks Agrees to Acquire Neon* (2025-05-14) — https://www.databricks.com/company/newsroom/press-releases/databricks-agrees-acquire-neon-help-developers-deliver-ai-systems  
3. Databricks Blog: *Databricks + Neon* (2025-05-14) — https://www.databricks.com/blog/databricks-neon  
4. Snowflake Blog: *Delivering the Most Enterprise‑Ready Postgres* (2025-06-02) — https://www.snowflake.com/en/blog/snowflake-postgres-enterprise-ai-database/  
5. Crunchy Data Blog: *Crunchy Data Joins Snowflake* (2025-06-02) — https://www.crunchydata.com/blog/crunchy-data-joins-snowflake  
6. Crunchy Data Blog: *Logical replication from Postgres to Iceberg* (2025-04-22) — https://www.crunchydata.com/blog/logical-replication-from-postgres-to-iceberg  
7. Databricks Blog: *What Is a Lakebase?* (2025-06-11) — https://www.databricks.com/blog/what-is-a-lakebase  
8. Databricks Blog: *How to use Lakebase as a transactional data layer* (2025-08-28) — https://www.databricks.com/blog/how-use-lakebase-transactional-data-layer-databricks-apps  
9. Databricks Docs: *Sync data from Unity Catalog tables to a database instance* (2025-08-27) — https://docs.databricks.com/aws/en/oltp/sync-data/sync-table  
10. Databricks Docs: *Use Delta Lake change data feed (CDF) on Databricks* (2025-03-28) — https://docs.databricks.com/aws/en/delta/delta-change-data-feed  
11. Snowflake Docs: *Hybrid Tables* — https://docs.snowflake.com/en/user-guide/tables-hybrid  
12. Snowflake Blog: *Unistore GA—Hybrid Tables* (2024-11-12) — https://www.snowflake.com/en/blog/unistore-general-availability/  
13. Snowflake Blog: *Horizon: Leading Governance & Data Discovery* (2024-06-05) — https://www.snowflake.com/en/blog/horizon-leading-governance-data-discovery/  
14. Databricks Docs: *What is Unity Catalog?* — https://docs.databricks.com/aws/en/data-governance/unity-catalog/  
15. Neon Docs: *Branching* — https://neon.com/docs/introduction/branching  
16. Neon Blog: *Cold starts just got hot* (2023-07-25) — https://neon.com/blog/cold-starts-just-got-hot  

> 参考：元の考察記事（背景理解）— Zenn: https://zenn.dev/yohei/articles/2025-06-14-postgres-snowflake-databricks
