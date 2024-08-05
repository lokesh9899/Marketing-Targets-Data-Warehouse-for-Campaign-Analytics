

use finance_info

create table customer(
  customer_id int identity(1,1) primary key, 
  age int check (age > 0), 
  job varchar(50),
  marital varchar(20),
  education varchar(50),
  default_status varchar(50),
  balance numeric(10, 2), 
  housing varchar(50),
  loan varchar(50)
);


use finance_info
create table contact (
  contact_id int identity(1,1) primary key,  
  customer_id int , 
  contact_method varchar(50),  
  day int check (day > 0 and day <= 31),  
  month varchar(20) check (
    month in ('jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec')
  ),  
  duration int,  
  campaign varchar(50),
  foreign key (customer_id) references customer (customer_id)  
);

use finance_info
create table outcome (
  outcome_id int identity(1,1) primary key,  
  contact_id int,  
  poutcome varchar(50),  
  result varchar(50),  
  foreign key (contact_id) references contact (contact_id)  
);

 
  


use finance_info
insert into customer (age, job, marital, education, default_status, balance, housing, loan)
select age, job, marital, education, default_status, balance, housing, loan
from Finance_data;

use finance_info
insert into contact(customer_id, contact_method, day, month, duration, campaign)
select 
    cd.customer_id, 
    fd.contact,  
    cast(fd.day as int),  
    fd.month, 
    cast(fd.duration as int), 
    fd.campaign 
from Finance_data fd
inner join customer cd on fd.id = cd.customer_id;


use finance_info
insert into outcome (contact_id, poutcome, result)
select ci.contact_id, fd.poutcome, fd.y
from Finance_data fd
inner join contact ci on fd.id = ci.contact_id;

