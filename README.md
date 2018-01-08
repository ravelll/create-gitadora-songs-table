### Usage

```
$ mysql -uroot -e 'create database gitadora'
$ mysql -uroot gitadora

mysql> create table songs (
  id int(255) primary key auto_increment,
  name varchar(255) not null unique,
  bpm int(4),
  level_d_b float(3, 2),
  level_d_a float(3, 2),
  level_d_e float(3, 2),
  level_d_m float(3, 2),
  level_g_b float(3, 2),
  level_g_a float(3, 2),
  level_g_e float(3, 2),
  level_g_m float(3, 2),
  level_b_b float(3, 2),
  level_b_a float(3, 2),
  level_b_e float(3, 2),
  level_b_m float(3, 2)
);

$ bundle install --path vendor/bundle
$ bundle exec ruby create.rb
```
