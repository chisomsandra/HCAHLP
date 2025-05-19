select *
from hcahpsnationals;

create table hcaphstagging
like hcahpsnationals;

insert hcaphstagging
select *
from hcahpsnationals;

select *
from hcaphstagging;

select *,
row_number() over(
partition by `hcahps measure ID`, `hcahps Question`, `HCAHPS Answer percent`,`HCAHPS Answer Description`, `Start date`,`End Date`
) as row_num
from hcaphstagging;

with duplicate_cte as (
select *,
row_number() over(
partition by `HCAHPS Measure ID`, `hcahps Question`, `HCAHPS Answer Description`,`HCAHPS Answer percent`, `Start date`,`End Date`) as row_num
from hcaphstagging)


select *
from hcaphstagging
where `HCAHPS Measure ID` = 'h_bath_help_A_P';

CREATE TABLE `hcaphstagging2` (
  `HCAHPS Measure ID` text,
  `HCAHPS Question` text,
  `HCAHPS Answer Description` text,
  `HCAHPS Answer Percent` int DEFAULT NULL,
  `Footnote` text,
  `Start Date` text,
  `End Date` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from hcaphstagging2;

insert into hcaphstagging2
select *,
row_number() over(
partition by `HCAHPS Measure ID`, `hcahps Question`, `HCAHPS Answer Description`,`HCAHPS Answer percent`, `Start date`,`End Date`) as row_num
from hcaphstagging;

select *
from duplicate_cte
where row_num > 1;

select *
from hcaphstagging2
where row_num > 1;

 delete
from hcaphstagging2
where row_num > 1;

select *
from hcaphstagging2;

-- standardizing data

select  `hcahps measure ID`,trim(`hcahps measure ID`)
FROM hcaphstagging2;

Update hcaphstagging2
set `hcaphs measure ID` = trim(`hcahps measure ID`);

select *
from hcaphstagging2;


select `hcahps Question`, `hcahps Answer Description` ,
 round( avg( `hcahps Answer percent`), 2)  as avg_percent 
  from hcaphstagging2
  group by `hcahps Question` , `hcahps Answer Description`   
  limit 5;
  
-- trend over time

select `HCAHPS Measure ID`, `HCAHPS Question`,`Start Date`, `End Date`,
 avg(`HCAHPS Answer Percent`) 
 from hcaphstagging2
 group by `HCAHPS Measure ID`, `HCAHPS Question`, `Start Date`, `End Date`;
  
  


  
  
  
  









