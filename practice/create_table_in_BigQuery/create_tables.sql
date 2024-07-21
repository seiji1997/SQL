-- Sequence: population_id_seq is not directly supported in BigQuery, using AUTO_INCREMENT instead

-- Table: categories
drop table if exists `project.dataset.categories`;

create table `project.dataset.categories`
(
  id int64 not null,
  name string not null,
  constraint categories_pkey primary key (id)
);

-- Table: items
drop table if exists `project.dataset.items`;

create table `project.dataset.items`
(
  id int64 not null,
  category_id int64 not null,
  name string not null,
  price int64 not null,
  constraint items_pkey primary key (id),
  constraint item_category_fkey foreign key (category_id)
    references `project.dataset.categories` (id)
);

-- Table: employees
drop table if exists `project.dataset.employees`;

create table `project.dataset.employees`
(
  id int64 not null auto_increment,
  name string not null,
  email string not null,
  start_date date not null,
  end_date date,
  constraint employees_pkey primary key (id)
);

-- Table: regions
drop table if exists `project.dataset.regions`;

create table `project.dataset.regions`
(
  code string(2) not null,
  name string,
  constraint regions_pkey primary key (code)
);

-- Table: prefectures
drop table if exists `project.dataset.prefectures`;

create table `project.dataset.prefectures`
(
  code string(2) not null,
  region_code string(2),
  name string not null,
  acreage float64,
  constraint prefectures_pkey primary key (code),
  constraint prefectures_regions_fkey foreign key (region_code)
    references `project.dataset.regions` (code)
);

-- Table: genders
drop table if exists `project.dataset.genders`;

create table `project.dataset.genders`
(
  code string(1) not null,
  name string(1),
  constraint gender_pkey primary key (code)
);

-- Table: generations
drop table if exists `project.dataset.generations`;

create table `project.dataset.generations`
(
  code string(1) not null,
  label string,
  constraint generation_pkey primary key (code)
);

-- Table: populations
drop table if exists `project.dataset.populations`;

create table `project.dataset.populations`
(
  id int64 not null auto_increment,
  prefecture_code string(2),
  generation_code string(1),
  gender_code string(1),
  population int64,
  constraint population_pkey primary key (id),
  constraint populations_generations_fkey foreign key (generation_code)
    references `project.dataset.generations` (code),
  constraint populations_prefectures_fkey foreign key (prefecture_code)
    references `project.dataset.prefectures` (code),
  constraint populations_genders_fkey foreign key (gender_code)
    references `project.dataset.genders` (code)
);