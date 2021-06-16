-- Sarah Hellmann, Group 13
-- SQL Scripts
-- change to applicable database:
use group13_database;
-- DROP TABLE STATEMENTS:
DROP TABLE customer;
DROP TABLE restaurant;
DROP TABLE items;
DROP TABLE driver;
DROP TABLE delivery;
DROP TABLE orders;
DROP TABLE orderInfo;

-- CREATE TABLE STATEMENTS:
CREATE TABLE customer(
cID INT(10) NOT NULL,
cName VARCHAR(50),
cStreet VARCHAR(50),
cCity VARCHAR(20),
cState VARCHAR(20),
cZip INT(5),
cEmail VARCHAR(50),
cPassword VARCHAR(20),
cPhone VARCHAR(10),
PRIMARY KEY (cID)
);

CREATE TABLE restaurant(
rID INT(10) NOT NULL,
rName VARCHAR(50),
rStreet VARCHAR(50),
rCity VARCHAR(20),
rState VARCHAR(20),
rZip INT(5),
rEmail VARCHAR(50),
rPhone VARCHAR(10),
PRIMARY KEY (rID)
);

CREATE TABLE items(
itemID INT(10) NOT NULL,
itemPrice DECIMAL(5,2),
itemDescription VARCHAR(50),
rID INT(10) NOT NULL,
PRIMARY KEY (itemID),
CONSTRAINT fk_item_rID FOREIGN KEY (rID) REFERENCES restaurant(rID)
);

CREATE TABLE driver(
dID INT(10) NOT NULL,
dName VARCHAR(50),
dPhone VARCHAR(10),
dEmail VARCHAR(50),
dCar VARCHAR(20),
PRIMARY KEY (dID)
);

CREATE TABLE delivery(
deliveryID INT(5) NOT NULL,
deliveryFee DECIMAL(5,2),
driverWage DECIMAL(5,2),
dID INT(10) NOT NULL,
PRIMARY KEY (deliveryID),
CONSTRAINT fk_deliver_dID FOREIGN KEY (dID) REFERENCES driver(dID)
);

CREATE TABLE orders(
oID INT(10) NOT NULL,
placedDateTime DATETIME,
estimatedDateTime DATETIME,
readyDateTime DATETIME,
deliveredDateTime DATETIME,
cID INT(10) NOT NULL,
deliveryID INT(10) NOT NULL,
PRIMARY KEY (oID),
CONSTRAINT fk_orders_cID FOREIGN KEY (cID) REFERENCES customer(cID),
CONSTRAINT fk_orders_deliveryID FOREIGN KEY (deliveryID) REFERENCES delivery(deliveryID)
);

CREATE TABLE orderInfo(
oID INT(10) NOT NULL,
itemID INT(10) NOT NULL,
itemQuantity INT(5),
percentFee DECIMAL(5,2),
CONSTRAINT fk_orderInfo_oID FOREIGN KEY (oID) REFERENCES orders(oID),
PRIMARY KEY (oID, itemID)
);

-- INSERT SAMPLE DATA:

-- Populate the customer table:
INSERT INTO customer VALUES(0734589091, 'Sarah Hellmann', '40 Yearling Path', 'New Orleans', 'LA', 70118, 'shellmann@gmail.com', 'Password', '7326250153');
INSERT INTO customer VALUES(0734589092, 'Anthony Fauci', '123 Pfeizer Drive', 'New Orleans', 'LA', 70115, 'afauci@king.com', 'byeCovid', '7326250153');
INSERT INTO customer VALUES(0734589093, 'Gordon Ramsay', '100 St Charles Ave', 'New Orleans', 'LA', 70112, 'ramsay@chef.com', 'IDontCook', '7326250153');

-- Populate restaurant table:
INSERT INTO restaurant VALUES(0011236705, 'Green Olives', '7724 Maple St', 'New Orleans', 'Louisiana', 70118, 'olives@greenolives.com', '5045339167');
INSERT INTO restaurant VALUES(0011236706, 'Ba Chi Canteen', '7900 Maple St', 'New Orleans', 'Louisiana', 70118, 'baco@bachi.com', '5043735628');
INSERT INTO restaurant VALUES(0011236707, 'Superior Seafood', '4338 St Charles Ave', 'New Orleans', 'Louisiana', 70115, 'oysters@superior.com', '5042933474');
INSERT INTO restaurant VALUES(0011236708, 'McDonalds', '3321 St Charles Ave', 'New Orleans', 'Louisiana', 70115, 'ronald@mcdonald.com', '5048918323');

-- Populate the items table:
INSERT INTO items VALUES(000000789, 9.99, 'Falafel Wrap', 0011236705);
INSERT INTO items VALUES(000000790, 8.95,'Lemongrass Chicken Pho', 0011236706);
INSERT INTO items VALUES(000000791, 3.25,'Honey Ponzu Chicken Baco', 0011236706);
INSERT INTO items VALUES(000000792, 24.00, 'Shrimp and Grits', 0011236707);
INSERT INTO items VALUES(000000793, 3.99, 'Big Mac', 0011236708);

-- Populate the driver table:
INSERT INTO driver VALUES(0001112223, 'Paris Hilton', '1234567890', 'paris@thatshot.com', 'kia soul');
INSERT INTO driver VALUES(0001112224, 'McLovin', '9082146615', 'mclovin@hawaii.com', 'tesla');
INSERT INTO driver VALUES(0001112225, 'Jeff Bezos', '5042146615', 'trillion@amazon.com', 'toyota prius');

-- Populate the delivery table:
INSERT INTO delivery VALUES(0323458082, 5.99, 8.00, 0001112223);
INSERT INTO delivery VALUES(0323458083, 6.99, 8.00, 0001112224);
INSERT INTO delivery VALUES(0323458084, 6.99, 8.00, 0001112223);
INSERT INTO delivery VALUES(0323458085, 6.99, 8.00, 0001112223);
INSERT INTO delivery VALUES(0323458086, 6.99, 8.00, 0001112225);
INSERT INTO delivery VALUES(0323458087, 6.99, 8.00, 0001112225);

-- Populate the orders table (datetime = YYYY-MM-DD HH:MI:SS):
INSERT INTO orders VALUES(1000000000, '2021-04-22 11:11:11', '2021-04-22 11:21:11', '2021-04-22 11:21:11', '2021-04-22 11:41:11', 0734589091, 0323458082);
INSERT INTO orders VALUES(1000000001, '2021-04-22 12:23:30', '2021-04-22 12:43:30', '2021-04-22 12:45:30', '2021-04-22 1:15:20', 0734589092, 0323458083);
INSERT INTO orders VALUES(1000000002, '2021-04-22 5:30:33', '2021-04-22 5:40:00', '2021-04-22 5:46:20', '2021-04-22 6:05:14', 0734589092, 0323458084);
INSERT INTO orders VALUES(1000000003, '2021-04-22 9:15:47', '2021-04-22 9:45:47', '2021-04-22 9:45:57', '2021-04-22 10:17:01', 0734589092, 0323458085);
INSERT INTO orders VALUES(1000000004, '2021-04-22 9:40:34', '2021-04-22 9:55:34', '2021-04-22 9:55:37', '2021-04-22 10:07:09', 0734589093, 0323458086);
INSERT INTO orders VALUES(1000000005, '2021-04-22 11:03:08', '2021-04-22 11:10:00', '2021-04-22 11:14:21', '2021-04-22 11:20:46', 0734589092, 0323458087);

-- Populate the orderInfo table:
INSERT INTO orderInfo VALUES(1000000000, 000000789, 2, 0.20);
INSERT INTO orderInfo VALUES(1000000001, 000000790, 7, 0.20);
INSERT INTO orderInfo VALUES(1000000002, 000000792, 1, 0.20);
INSERT INTO orderInfo VALUES(1000000003, 000000789, 1, 0.20);
INSERT INTO orderInfo VALUES(1000000004, 000000791, 23, 0.20);
INSERT INTO orderInfo VALUES(1000000005, 000000793, 5, 0.20);

-- Verify cardinality/view of each table:
SELECT * FROM customer;
SELECT * FROM restaurant;
SELECT * FROM items;
SELECT * FROM driver;
SELECT * FROM delivery;
SELECT * FROM orders;
SELECT * FROM orderInfo;

-- BUSINESS QUESTIONS:

-- OPERATIONAL:
-- 1. Number of total drivers employed by d'Livery Nola?
SELECT COUNT(dID) AS 'Total Num of Drivers'
FROM driver;

-- 2. Number of deliveries made by each driver?
SELECT d.dID, d.dName, COUNT(de.deliveryID) AS 'NumOFDeliveries'
FROM driver d JOIN delivery de ON d.dID = de.dID
GROUP BY d.dID, d.dName;

-- 3. What restaurants are signed up for d'Livery Nola?
SELECT r.rID, r.rName
FROM restaurant r;

-- ANALYTICAL:
-- 4. What are the profits from each order thus far?
SELECT o.oID
		, (oi.percentFee*(i.itemPrice * oi.itemQuantity)) AS 'Service Fee Per Order'
		, d.deliveryFee AS 'Delivery Fee per Order'
        , d.driverWage AS 'Driver Wage per Order'
        , ((oi.percentFee*(i.itemPrice * oi.itemQuantity)) + d.deliveryFee - d.driverWage) AS 'Profit per Order'
FROM orders o JOIN delivery d ON o.deliveryID = d.deliveryID
			  JOIN orderInfo oi ON o.oID = oi.oID
              JOIN items i ON oi.itemID = i.itemID
GROUP BY o.oID;

-- 5. Which restaurants have completed more than 1 order?
SELECT r.rName, COUNT(oi.oID) AS 'NumOfOrders'
FROM items i JOIN orderInfo oi ON i.itemID = oi.itemID
			 JOIN restaurant r ON i.rID = r.rID
GROUP BY r.rName
HAVING COUNT(oi.oID) > 1;

-- 6. What customers has Paris Hilton delivered to and how many times?
SELECT c.cName, COUNT(de.deliveryID) AS 'Num of Times Delivered'
FROM orders o JOIN customer c ON o.cID = c.cID
			  JOIN delivery de ON o.deliveryID = de.deliveryID
			  JOIN driver d ON de.dID = d.dID
WHERE d.dName = 'Paris Hilton'
GROUP BY c.cName;

-- 7. List the count of items ordered in descending order and the restaurant they are from
SELECT i.itemID
	  , i.itemDescription AS 'Item'
      , r.rName AS 'Restaurant'
      , COUNT(oi.oID) AS 'Number of Times Ordered'
FROM items i JOIN restaurant r ON i.rID = r.rID
			 JOIN orderInfo oi ON i.itemID = oi.itemID
GROUP BY i.itemID, i.itemDescription, r.rName
ORDER BY COUNT(oi.oID) DESC;

-- 8. What is the average delivery time?
SELECT AVG(TIMEDIFF(o.readyDateTime, o.deliveredDateTime)) AS 'Avg delivery time in mins'
FROM orders o;

-- 9. What restaurants take the longest to make the food?
SELECT r.rName, AVG(TIMEDIFF(o.placedDateTime, o.readyDateTime)) AS 'Avg Time to Make Order'
FROM orderInfo oi JOIN orders o ON oi.oID = o.oID
				  JOIN items i ON oi.itemID = i.itemID
                  JOIN restaurant r ON i.rID = r.rID
GROUP BY r.rID, r.rName
ORDER BY TIMEDIFF(o.placedDateTime, o.readyDateTime) DESC;

-- 10. What is the most popular item ordered at Ba Chi?
SELECT i.itemDescription, COUNT(oi.itemID) AS 'Num of Times Ordered'
FROM orderInfo oi JOIN items i ON oi.itemID = i.itemID
				  JOIN restaurant r ON i.rID = r.rID
WHERE r.rName = 'Ba Chi Canteen'
GROUP BY i.itemID, i.itemDescription
ORDER BY i.itemDescription DESC;







COMMIT;
