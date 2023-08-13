

/*Visit our website at https://web.learncodeonline.in for more exciting courses.
________________________________________
Course: MySQL Basic To advanced 
Difficulty: Intense
Instruction: Import the given lco_car_rentals.sql file in phpmyadmin and then 
answer the following questions with mySQL queries. */

/* Q1) Insert the details of new customer:-
First name : Nancy
Last Name: Perry
Dob : 1988-05-16
License Number: K59042656E
Email : nancy@gmail.com */

insert into customer(first_name,Last_name,dob,driver_license_number,email)
               values('Nancy','Perry','1988-05-16','K59042656E','nancy@gmail.com' );

/* Q2) The new customer (inserted above) wants to rent a car from 2020-08-25 to 2020-08-30.
 More details are as follows:
Vehicle Type : Economy SUV
Fuel Option : Market
Pick Up location: 5150 W 55th St , Chicago, IL, zip- 60638
Drop Location: 9217 Airport Blvd, Los Angeles, CA, zip - 90045 */

INSERT INTO RENTAL(START_DATE,
END_DATE,
customer_id ,
vehicle_type_id, 
fuel_option_id , 
pickup_location_id,  
drop_off_location_id)
VALUES('2020-08-25 ','2020-08-30',
(SELECT CUSTOMER.ID FROM CUSTOMER WHERE CUSTOMER.driver_license_number="K59042656E"),
(SELECT V.ID FROM VEHICLE_TYPE V WHERE V.NAME="Economy SUV"),
(SELECT F.ID FROM FUEL_OPTION F WHERE F.NAME="mARKET"),
(SELECT P.ID FROM LOCATION P WHERE P.ZIPCODE="60638"),
(SELECT D.ID FROM LOCATION D WHERE D.ZIPCODE="90045")) ;

SELECT * FROM RENTAL;

/* Q3) The customer with the driving license W045654959 
changed his/her drop-off location to 
1001 Henderson St, Fort Worth, TX, zip - 76102,  and wants to extend the rental upto 4 more days. 
Update the record.*/

UPDATE RENTAL 
INNER JOIN CUSTOMER ON CUSTOMER.ID=RENTAL.ID 
SET RENTAL.drop_off_location_id=(SELECT LOCATION.ID FROM LOCATION WHERE LOCATION.ZIPCODE='76102'),
RENTAL.END_DATE = (SELECT END_DATE + INTERVAL 4 DAY)
WHERE CUSTOMER.driver_license_number="W045654959";

/* Q4) Fetch all rental details with their equipment type.*/

SELECT concat(customer.first_name," ",customer.last_name) as Full_Name,customer.driver_license_number,
rental.start_date,rental.end_date,
concat(location.street_address," ", location.city," ",location.state," ",location.zipcode) as pickup_location,
concat(location_drop.street_address," ", location_drop.city," ",location_drop.state," ",location_drop.zipcode) as drop_off_location,
equipment.name as equipment_type
from rental 
inner join customer on customer.id=rental.id
inner join location on rental.pickup_location_id=location.id
inner join location location_drop on rental.drop_off_location_id=location_drop.id
inner join equipment on customer.id=equipment.id;

/* Q5) Fetch all details of vehicles.*/

select v.id,v.brand,v.model,v.model_year,v.mileage,v.color,
vt.name as vehicle_type,vt.rental_value,
concat(l.street_address," ",l.city," ",l.state," ",l.zipcode) as Current_Location
from vehicle v
left join vehicle_type vt on v.vehicle_type_id=vt.id
inner join location l on l.id=v.id;

/* Q6) Get a driving license of the customer with most rental insurances.*/

select count(rental_has_insurance.rental_id) as Number_of_insurance ,customer.driver_license_number
from rental_has_insurance 
inner join customer on rental_has_insurance.rental_id=customer.id
group by rental_has_insurance.rental_id 
order by count(rental_has_insurance.rental_id) desc limit 1;

/* Q7) Insert a new equipment type with the following details.
Name: Mini TV
Rental Value : 8.99 */

insert into equipment_type(name,rental_value)
values("Mini TV",8.99);


/* Q8) Insert a new equipment with following details:
Name: Garmin Mini TV
Equipment type : Mini TV
Current Location zip code : 60638 */

nsert into equipment( name,equipment_type_id,current_location_id)
values("Garmin mini Tv",
(select id from equipment_type where name="Mini tv"),
(Select id from location where zipcode=60638));

/* Q9) Fetch rental invoice for customer (email: smacias3@amazonaws.com). */

select *
from rental_invoice 
where id=(select id from customer where email="smacias3@amazonaws.com");

/* Q10) Insert the invoice for customer (driving license:"K59042656E" ) with following details:-
Car Rent : 785.4
Equipment Rent : 114.65
Insurance Cost : 688.2
Tax : 26.2
Total: 1614.45
Discount : 213.25
Net Amount: 1401.2 */

insert into rental_invoice(car_rent,equipment_rent_total,insurance_cost_total,
tax_surcharges_and_fees,total_amount_payable,discount_amount,net_amount_payable,rental_id)
values(785.4,114.65,688.2,26.2,1614.45,213.25,1401.2,
(select id from customer where driver_license_number="K59042656E"));

/* Q11) Which rental has the most number of equipment.*/

select rental_id,count(rental_id) as No_of_equipment
from rental_has_equipment_type 
group by rental_id
order by count(rental_id) desc limit 1;

/* Q12) Get driving license of a customer with least number of rental licenses.*/

SELECT customer.driver_license_number, COUNT(rental_has_insurance.rental_id) AS number_of_insurance
FROM customer LEFT JOIN rental ON rental.customer_id = customer.id
LEFT JOIN rental_has_insurance ON rental_has_insurance.rental_id = rental.id
GROUP BY rental_has_insurance.rental_id ORDER BY COUNT(rental_has_insurance.rental_id) asc LIMIT 1;

/* Q13) Insert new location with following details.
Street address : 1460  Thomas Street
City : Burr Ridge ,
 State : IL, 
 Zip - 61257*/

insert into location(street_address,city,state,zipcode)
 values("1460 Thomas Street","Burr Ridge","IL",61257);


/* Q14) Add the new vehicle with following details:-
Brand: Tata 
Model: Nexon
Model Year : 2020
Mileage: 17000
Color: Blue
Vehicle Type: Economy SUV 
Current Location Zip: 20011 */

insert into vehicle(brand,model,model_year,mileage,color,vehicle_type_id,current_location_id)
values("Tata","Nexon",2020,17000,"Blue",(select id from vehicle_type where name="Economy SUV"),
(Select id from location where zipcode="20011"));

/* Q15) Insert new vehicle type Hatchback and rental value: 33.88.*/

insert into vehicle_type (name,rental_value)
values("Hatchback",33.88);

/* Q16) Add new fuel option Pre-paid (refunded).*/

insert into fuel_option(name,description)
values("Pre-paid(refunded)",
"Customer buy a tank of fuel at pick-up and get refunded the amount customer don’t use.");

/* Q17) Assign the insurance : Cover My Belongings (PEP), Cover The Car (LDW) 
to the rental started on 25-08-2020 (created in Q2) 
by customer (Driving License:K59042656E).*/

insert into rental_has_insurance(rental_id,insurance_id)
values((select id from rental where start_date ='2020-08-25'),
(select id from insurance where name= 'Cover My Belongings (PEP)')),
((select id from rental where start_date ='2020-08-25'),
(select id from insurance where name= 'Cover The Car (LDW)'));

/* Q18) Remove equipment_type :Satellite Radio from rental started on 2018-07-14 and ended on 2018-07-23.*/

delete from rental_has_equipment_type
where equipment_type_id=(select id from equipment_type where name='Satellite Radio')
 and rental_id=(select id from rental where start_date ='2018-07-14' and end_date='2018-07-23');

/* Q19) Update phone to 510-624-4188 of customer (Driving License: K59042656E).*/

update customer 
set phone='510-624-4188' where driver_license_number='K59042656E';

/* Q20) Increase the insurance cost of Cover The Car (LDW) by 5.65.*/
update insurance
set cost= (select cost + 5.65) where name='Cover The Car (LDW)';

/* Q21) Increase the rental value of all equipment types by 11.25.*/
update equipment_type
set rental_value=(select rental_value + 11.25);

/* Q22) Increase the  cost of all rental insurances except Cover The Car (LDW) by twice the current cost.*/

update insurance
set cost=(select cost * 2) where insurance.name!="Cover The Car (LDW)";

/* Q23) Fetch the maximum net amount of invoice generated.*/

SELECT MAX(net_amount_payable)as maximum_net_amount FROM `rental_invoice`;

/* Q24) Update the dob of customer with driving license V435899293 to 1977-06-22.*/

update customer
set dob='1977-06-22' where driver_license_number="V435899293";

/*Q25)  Insert new location with following details.
Street address : 468  Jett Lane
City : Gardena , State : CA, Zip - 90248*/

insert into location(street_address,city,state,zipcode)
values("468  Jett Lane","gardena","CA",90248);


/*Q26) The new customer (Driving license: W045654959) 
wants to rent a car from 2020-09-15 to 2020-10-02. More details are as follows: 

Vehicle Type : Hatchback
Fuel Option : Pre-paid (refunded)
Pick Up location:  468  Jett Lane , Gardena , CA, zip- 90248
Drop Location: 5911 Blair Rd NW, Washington, DC, zip - 20011*/

INSERT INTO `rental`(`start_date`, `end_date`, `customer_id`, `vehicle_type_id`,
 `fuel_option_id`, `pickup_location_id`, `drop_off_location_id`) 
VALUES ("2020-09-15", "2020-10-02", (SELECT customer.id FROM customer WHERE customer.driver_license_number="W045654959"), 
(SELECT vehicle_type.id FROM vehicle_type WHERE vehicle_type.name="Hatchback"), 
(SELECT fuel_option.id FROM fuel_option WHERE fuel_option.name="Pre-paid(refunded)"), 
(SELECT location.id FROM location WHERE location.zipcode=90248),
(SELECT location.id FROM location WHERE location.zipcode=20011));

/*Q27) Replace the driving license of the customer (Driving License: G055017319) with new one K16046265.*/

update customer 
set driver_license_number="K16046265" where driver_license_number="G055017319";

/*Q28) Calculated the total sum of all insurance costs of all rentals.*/

SELECT SUM(insurance.cost) as Total_cost
FROM `rental_has_insurance` 
INNER JOIN insurance ON insurance.id= rental_has_insurance.insurance_id;

/*Q29) How much discount we gave to customers in total in the rental invoice?*/

SELECT SUM(discount_amount) as total_discount FROM rental_invoice;

/*Q30) The Nissan Versa has been repainted to black. Update the record.*/

update vehicle 
set color ="Black" where brand="Nissan" and model="Versa";
