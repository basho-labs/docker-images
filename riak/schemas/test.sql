create table test (
  family varchar not null,
  series varchar not null,
  time timestamp not null,
  primary key ((family, series, quantum(time, 15, 'm')), family, series, time)
)
