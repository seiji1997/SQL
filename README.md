## Explain the order of description and execution

No.|description order|execution order|
|:---:|:---:|:---:|
1|select|from|
2|aggregate functions|where|
3|from|group by|
4|where|aggregate functions|
5|group by|having|
6|having|select|
7|order by|order by|
8|limit|limit|
