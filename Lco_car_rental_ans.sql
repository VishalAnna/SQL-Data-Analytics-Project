
/*Visit our website at https://web.learncodeonline.in for more exciting courses.
________________________________________
Course: MySQL
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
changed his/her drop off location to 
1001 Henderson St,Fort Worth, TX, zip - 76102  and wants to extend the rental upto 4 more days. 
Update the record.*/

UPDATE RENTAL 
INNER JOIN CUSTOMER ON CUSTOMER.ID=RENTAL.ID 
SET RENTAL.drop_off_location_id=(SELECT LOCATION.ID FROM LOCATION WHERE LOCATION.ZIPCODE='76102'),
RENTAL.END_DATE = (SELECT END_DATE + INTERVAL 4 DAY)
WHERE CUSTOMER.driver_license_number="W045654959";

/* Q4) Fetch all rental details with their equipment type.*/
SELECT * FROM RENTAL R
INNER JOIN equipment_type E ON R.ID=E.ID;

/* Q5) Fetch all details of vehicles.*/

/* Q6) Get driving license of the customer with most rental insurances.*/

/* Q7) Insert a new equipment type with following details.
Name : Mini TV
Rental Value : 8.99 */

/* Q8) Insert a new equipment with following details:
Name : Garmin Mini TV
Equipment type : Mini TV
Current Location zip code : 60638 */

/* Q9) Fetch rental invoice for customer (email: smacias3@amazonaws.com). */

/* Q10) Insert the invoice for customer (driving license: ) with following details:-
Car Rent : 785.4
Equipment Rent : 114.65
Insurance Cost : 688.2
Tax : 26.2
Total: 1614.45
Discount : 213.25
Net Amount: 1401.2 */

/* Q11) Which rental has the most number of equipment.

/* Q12) Get driving license of a customer with least number of rental licenses.

/* Q13) Insert new location with following details.
Street address : 1460  Thomas Street
City : Burr Ridge , State : IL, Zip - 61257

/* Q14) Add the new vehicle with following details:-
Brand: Tata 
Model: Nexon
Model Year : 2020
Mileage: 17000
Color: Blue
Vehicle Type: Economy SUV 
Current Location Zip: 20011 

/* Q15) Insert new vehicle type Hatchback and rental value: 33.88.

/* Q16) Add new fuel option Pre-paid (refunded).

Q17) Assign the insurance : Cover My Belongings (PEP), Cover The Car (LDW) to the rental started on 25-08-2020 (created in Q2) by customer (Driving License:K59042656E).

/* Q18) Remove equipment_type :Satellite Radio from rental started on 2018-07-14 and ended on 2018-07-23.

/* Q19) Update phone to 510-624-4188 of customer (Driving License: K59042656E).

/* Q20) Increase the insurance cost of Cover The Car (LDW) by 5.65.

/* Q21) Increase the rental value of all equipment types by 11.25.

/* Q22) Increase the  cost of all rental insurances except Cover The Car (LDW) by twice the current cost.

/* Q23) Fetch the maximum net amount of invoice generated.

/* Q24) Update the dob of customer with driving license V435899293 to 1977-06-22.

Q25)  Insert new location with following details.
Street address : 468  Jett Lane
City : Gardena , State : CA, Zip - 90248

Q26) The new customer (Driving license: W045654959) wants to rent a car from 2020-09-15 to 2020-10-02. More details are as follows: 

Vehicle Type : Hatchback
Fuel Option : Pre-paid (refunded)
Pick Up location:  468  Jett Lane , Gardena , CA, zip- 90248
Drop Location: 5911 Blair Rd NW, Washington, DC, zip - 20011

Q27) Replace the driving license of the customer (Driving License: G055017319) with new one K16046265.

Q28) Calculated the total sum of all insurance costs of all rentals.

Q29) How much discount we gave to customers in total in the rental invoice?

Q30) The Nissan Versa has been repainted to black. Update the record.

