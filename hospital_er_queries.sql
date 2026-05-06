create table patients(
patient_id int GENERATED ALWAYS AS IDENTITY primary key,
patient_name varchar(150) not null,
patient_email varchar(150) not null,
patient_phone varchar(50));

create table doctors(
doctor_id int GENERATED ALWAYS AS IDENTITY primary key,
doctor_name varchar(150) not null,
doctor_email varchar(150) not null,
doctor_phone varchar(50),
department_id int);

create table departmentss(
department_id int GENERATED ALWAYS AS IDENTITY primary key,
department_name varchar(150) not null);

create table appointment(
appointment_id int GENERATED ALWAYS AS IDENTITY primary key,
patient_id int,
doctor_id int,
status varchar(50),
appointment date);

create table visit(
visit_id int GENERATED ALWAYS AS IDENTITY primary key,
appointment_id int,
reason varchar(150));

create table medicalRecord (
record_id int GENERATED ALWAYS AS IDENTITY primary key,
patient_id int,
past_diseases varchar(150) not null);

create table room(
room_id int GENERATED ALWAYS AS IDENTITY primary key,
bed_number int,
status varchar(150) not null);

create table payment(
payment_id int GENERATED ALWAYS AS IDENTITY primary key,
appointment_id int,
payment_date date,
amount number);

drop table payment;
--1
alter table doctors
add constraint fk_doctors_departments
foreign key (department_id)
references departmentss(department_id);

--2
alter table appointment
add constraint fk_appointment_patient
foreign key (patient_id)
references patients(patient_id);

--3
alter table appointment
add constraint fk_appointment_doctor
foreign key (doctor_id)
references doctors(doctor_id);

--4
alter table visit
add constraint fk_visit_appointment
foreign key (appointment_id)
references appointment(appointment_id);

--5
alter table medicalRecord
add constraint fk_medicalrecord_patient
foreign key (patient_id)
references patients(patient_id);

--6
alter table payment
add constraint fk_payment_appointment
foreign key (appointment_id)
references appointment(appointment_id);

insert into patients (patient_name, patient_email, patient_phone)
values ('Mochi BayNurov', 'mochi.baynurov@gmail.com', '0501234567');

insert into doctors (doctor_name, doctor_email, doctor_phone, department_id)
values ('Lala Nuraliyeva', 'lalosh.galosh@gmail.com', '0515830651',1 );

select * from doctors;
insert into departmentss (department_name)
values ('Baytarliq');

insert into appointment (patient_id, doctor_id, status, appointment)
values ( 1, 1, 'ongoing', sysdate);

insert into visit (appointment_id, reason)
values ( 1, 'chek-up');

insert into medicalRecord (patient_id, past_diseases)
values ( 1, '-');

insert into room (bed_number, status)
values ( 10, 'empty');

insert into payment (appointment_id, payment_date, amount)
values ( 1, '18-MAR-2026', 100);


insert into payment (appointment_id, payment_date, amount)
values ( 1, '18-MAR-2026', 50.4);
--1,2 join
select p.patient_name,d.doctor_name,a.appointment,a.status
from appointment a
join patients p
on a.patient_id = p.patient_id
join doctors d
on a.doctor_id = d.doctor_id;

select p.patient_name,d.doctor_name, d2.department_name,a.appointment,a.status
from appointment a
join patients p
on a.patient_id = p.patient_id
join doctors d
on a.doctor_id = d.doctor_id
join departmentss d2
on d.department_id = d2.department_id;

--count
select d.doctor_name,count(a.appointment_id)
from doctors d
left join appointment a
on d.doctor_id = a.doctor_id
group by d.doctor_name;

insert into appointment (patient_id, doctor_id, status, appointment)
values ( 1, 1, 'closed', sysdate-100);
insert into appointment (patient_id, doctor_id, status, appointment)
values ( 1, 1, 'waiting', sysdate+30);
--sum
select sum(amount)from payment;

--cte
with avge as(
select avg(amount)as avg_amount from payment)

select avg_amount from avge;

--view
create view patient_appointments as
select p.patient_name,a.appointment,a.status
from appointment a
join patients p
on a.patient_id = p.patient_id;

select * from patient_appointments;
