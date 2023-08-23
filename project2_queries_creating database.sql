
CREATE TABLE Customer(
  customer_id int primary key,
  customer_name varchar(100) not null,
  phone varchar(20) not null,
  Email varchar(100) not null,
  product_id INT not null);


CREATE TABLE Customer_audit (
  customer_id int primary key,
  customer_name varchar(100) not null,
  phone varchar(20) not null,
  Email varchar(100) not null,
  product_id int not null);

CREATE TABLE Employee (
  Empl_id INT PRIMARY KEY,
  Empl_name VARCHAR(100) NOT NULL,
  field_id INT NOT NULL,
  Email VARCHAR(150)  NOT NULL,
  phone VARCHAR(20) not null
);
CREATE TABLE Product(Product_id INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL, 
Price_per_litre NUMERIC (100,2) NOT NULL,
Quantity_supplied_per_litre INT NOT NULL, 
Quantity_in_stock_per_litre INT NOT NULL,
Supplier_id INT NOT NULL);

CREATE TABLE vehicles(NUMBER_PLATE VARCHAR(50) NOT NULL,
Vehicle_name VARCHAR(100) NOT NULL,
Type VARCHAR(100) NOT NULL, Capacity INT NOT NULL,
fuel_id INT NOT NULL,
Vehicle_id INT PRIMARY KEY);
CREATE TABLE Product_suppliers (  
supplier_id int PRIMARY KEY,  
name VARCHAR(255) NOT NULL,
phone VARCHAR(20) NOT NULL,  
email VARCHAR(355) NOT NULL,  
address VARCHAR(255) NOT NULL);

CREATE TABLE Product_suppliers_audit (  
supplier_id int PRIMARY KEY,  
name VARCHAR(255) NOT NULL,
phone VARCHAR(20) NOT NULL,  
email VARCHAR(355) NOT NULL,  
address VARCHAR(255) NOT NULL);

CREATE TABLE Job_category(
Job_name VARCHAR(25) NOT NULL,
Job_id INT PRIMARY KEY,
Job_description VARCHAR(2000) NOT NULL,
Salary NUMERIC(100,2) NOT NULL);

CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Quantity INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Empl_ID INT NOT NULL,
    Supplier_ID INT NOT NULL,
    Vehicle_ID INT NOT NULL);
CREATE TABLE Transactions_audit (
    Transaction_ID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Quantity INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Empl_ID INT NOT NULL,
    Supplier_ID INT NOT NULL,
    Vehicle_ID INT NOT NULL,
     
    FOREIGN KEY (Product_ID) REFERENCES Product (Product_ID),
    FOREIGN KEY (Empl_ID) REFERENCES Employee (Empl_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Product_suppliers (Supplier_ID),
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicles (Vehicle_ID)
);
INSERT INTO Transactions (Transaction_ID, Date, Time, Quantity, Amount, Customer_ID, Product_ID, Empl_ID, Supplier_ID, Vehicle_ID)
VALUES 
 (1, '2022-01-01', '10:00:00', 2, 150.00, 1, 1, 1095, 1, 1),
 (2, '2022-01-02', '11:30:00', 1, 70.50, 2, 2, 1096, 1, 2),
 (3, '2022-01-03', '12:45:00', 5, 170.50, 3, 3, 1097, 1, 3),
 (4, '2022-01-04', '14:15:00', 3, 202.50, 4, 4, 1098, 1, 4),
 (5, '2022-01-05', '15:30:00', 2, 100.00, 5, 5, 1099, 5, 5),
 (6, '2022-01-06', '16:45:00', 1, 50.00, 6, 6, 1700, 6, 6),
 (7, '2022-01-07', '17:30:00', 2, 150.00, 7, 7, 1096, 7, 7),
(8, '2022-01-08', '18:15:00', 4, 30.00, 8, 8, 1700, 8, 8),
(9, '2022-01-09', '19:00:00', 3, 200.50, 9, 9, 1095, 9, 9),
 (10,'2022-01-10', '20:30:00', 2, 150.00, 10, 10, 1096, 10, 10);

;
CREATE TABLE Employee_audit (
  Empl_id INT PRIMARY KEY,
  Empl_name VARCHAR(50) NOT NULL,
  field_id INT NOT NULL,
  Email VARCHAR(150) NOT NULL,
  phone NUMERIC NOT NULL
);

CREATE Table check_stock_level(
Product_id int not null primary key,
Name varchar(50) not null, 
Price_per_liter numeric(10,2) not null,
Quantity_supplied_per_litre int not null, 
Quantity_in_stock_per_litre int not null
);


CREATE OR REPLACE FUNCTION check_stock_level()
RETURNS TRIGGER
AS $$
DECLARE
    threshold INTEGER := 1000;
    product_name VARCHAR(50);
    stock_level INTEGER;
BEGIN
    IF TG_OP = 'UPDATE' THEN
        SELECT Name, Quantity_in_stock_per_liter INTO product_name, stock_level
        FROM Product
        WHERE Product_id = NEW.Product_id;
        IF stock_level < threshold THEN
           
            RAISE NOTICE 'Stock level for % is below threshold (% liters)', product_name, stock_level;
           
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_stock_trigger
AFTER UPDATE ON Product
FOR EACH ROW
EXECUTE procedure check_stock_level();








/*INSERTING VALUES INTO THE VAROIUS TABLES*/

INSERT INTO Employee(Empl_name,Empl_id,field_id,Email,phone)
VAlUES
('DANIEL MANSO', 1093, 1, 'dmanso@gmail.com', '027078234'),
('JESSICA LEE', 1094, 1, 'jlee@gmail.com', '052345678'),
('ERIC WANG', 1095, 2, 'ewang@gmail.com', '028765432'),
('KATE WU', 1096, 2, 'kwu@gmail.com', '052345678'),
('JOHN SMITH', 1097, 2, 'jsmith@gmail.com', '058765432'),
('JANE DOE', 1098, 2, 'jdoe@gmail.com', '054345678'),
('DAVID KIM', 1099, 2, 'dkim@gmail.com', '058765432'),
('SARAH PARK', 1700, 2, 'spark@gmail.com', '012345678'),
('RYAN LEE', 1101, 3, 'rlee@gmail.com', '058765432'),
('CHRIS KIM', 1102, 3, 'ckim@gmail.com', '052345678'),
('HANNAH DOE', 1293, 3, 'hdoe@gmail.com', '027077234'),
('JANET ASARE', 1294, 3, 'jasare@gmail.com', '054867678'),
('ERIC ANSAH', 1295, 4, 'eansah@gmail.com', '058565432'),
('KOFI MANSO', 1296, 4, 'kmanso@gmail.com', '055375678'),
('JOANA DANSO', 1297, 5, 'jdanso@gmail.com', '054675432'),
('JANET DUAH', 1298, 5, 'jduah@gmail.com', '027445678'),
('DAVID OFORI', 1299, 5, 'dofori@gmail.com', '0546865432'),
('SARAH OKAI', 1100, 6, 'sokai@gmail.com', '02612345678'),
('OSCAR DAZI', 1112, 6, 'Odazi@gmail.com', '054765432'),
('PATRICK KIM', 1132, 6, 'pkim@gmail.com', '05666678');

INSERT INTO Customer (customer_name, customer_id, phone, Email,Product_id )
VALUES 
('JONATHAN MENSAH',1,055476580,'jmensah@gmail.com',1),
('JOHN DOE',2,023456789,'johndoe@gmail.com',1),
('JANE DOE',3,054765432,'janedoe@gmail.com',2),
('BOB SMITH',4,0545555555,'bobsmith@gmail.com',2),
('SARA LEE',5,0547476311,'saralee@gmail.com',2),
('MIKE JONES',6,02422222,'mikejones@gmail.com',2),
('JIMMY SMITH',7,0247333333,'jimmysmith@gmail.com',3),
('AMY LEE',8,054440044,'amylee@gmail.com',3),
('PETER PARKER',9,023665666,'peterparker@gmail.com',2),
('MARY JANE',10,024777777,'maryjane@gmail.com',4),
('TONY STARK',11,0275388888,'tonystark@gmail.com',1),
('NATASHA ROMANOFF',12,0278612999,'natasharomanoff@gmail.com',4),
('BRUCE BANNER',13,0272121212,'brucebanner@gmail.com',1),
('CLINT BARTON',14,024343434,'clintbarton@gmail.com',1),
('WANDA MAXIMOFF',15,056565656,'wandamaximoff@gmail.com',3),
('VISION',16,0576787878,'vision@gmail.com',3),
('SAM WILSON',17,0232323723,'samwilson@gmail.com',3),
('BUCKY BARNES',18,0545454545,'buckybarnes@gmail.com',3),
('T CHALLA',19,0547676767,'tchalla@gmail.com',2),
('OKOYE',20,0279898989,'okoye@gmail.com',2),
('STEPHEN STRANGE',21,0542345211,'stephenstrange@gmail.com',1),
('WONG',22,0271865222,'wong@gmail.com',1),
('PETER QUILL',23,05973333333,'peterquill@gmail.com',1),
('GAMORA',24,024744444,'gamora@gmail.com',2),
('DRAX THE DESTROYER',25,055555555,'draxthedestroyer@gmail.com',3),
('ROCKET RACCOON',26,0576666666,'rocketraccoon@gmail.com',4),
('GROOT',27,054777777,'groot@gmail.com',4),
('NEBULA',28,0548888888,'nebula@gmail.com',3),
('CAROL DANVERS',29,0249999999,'caroldanvers@gmail.com',4),
('NICK FURY',30,0231231231,'nickfury@gmail.com',4);

INSERT INTO Job_category(Job_name,Job_id,Job_description,Salary)
VALUES
('Station Manager',1,'Manages the day to day activities of the filling station',5000.00),
('Pump Attendant',2,'Responsible for dispensing fuel and providing other basic services to customers',2500.00),
('Cashier',3,'Responsible for handling customer payments, maintaining accurate records of transactions, and reconciling cash at the end of the day',2000.00),
('mechanics',4,'Responsible for performing minor vehicle repairs and maintenance services such as oil changes, filter replacements, and brake repairs',1500.00),
('cleaning staff',5,'Responsible for maintaining a clean and hygienic environment at the filling station, including cleaning the bathrooms, floors, and other public areas',900.00),
('Security personnel',6, 'Responsible for ensuring the safety of the filling station and its customers and responding to any incidents or emergencies that may arise',1000.00);


INSERT INTO Product(Product_id,Name, price_per_litre,Quantity_supplied_per_litre, Quantity_in_stock_per_litre, Supplier_id)
VALUES(2,'Diesel',15.00,340000,170004,1001),
       (1,'Petrol',10.00,234000,1345000,2002),
       (3,'V-Power',20.00,34300,19000,3003),
       (4,'Super',24.00,34300,19000,3003);




INSERT INTO Product_suppliers(supplier_id, name,phone,email,address)
VALUES(1001,'Goil Company Ltd.', '+233567890123', 'goilco@gmail.com', '369 Elm Street, Accra, Ghana'),
(2002,'Total Petroleum Ghana Ltd.', '+233567825610', 'totalco@yahoo.com', 'Accra, Ghana'),
(3003,'Fuel Trade Ltd.', '+233765825610', 'fueltrade@yahoo.com', 'Accra, Ghana');


INSERT INTO Vehicles(NUMBER_PLATE, Vehicle_name, Type, Capacity, fuel_id,Vehicle_id) 
VALUES 
('GR-123-20', 'Honda Civic', 'private', 5,1,1),
('GR-0201-19', 'Ford F-150', 'pickup', 3,2,2),
('GW-151-20', 'Chevrolet Camaro', 'sports',2,3,3),
('Ge-124-22', 'KIA Bongo', 'pickup',3,1,4),
('WR-838-18', 'Toyota Sienna', 'van', 8,1,5),
('BA-161-18', 'Jeep Wrangler', 'SUV', 4,2,6),
('GA-123-23', 'BMW 3 Series', 'luxury', 5,2,7),
('AS-002-22', 'Dodge Charger', 'sedan', 5,1,8),
('WR-543-17', 'GMC Sierra', 'pickup', 6,1,9),
('UE-997-08', 'Nissan Altima', 'sedan', 5,3,10),
('BA-674-21', 'Subaru Outback', 'wagon', 5,2,11),
('NR-A27-15', 'Honda Odyssey', 'van', 7,1,12),
('GR-254-20', 'Ford Mustang', 'sports', 2,2,13),
('NR-576-21', 'Chevrolet Silverado', 'pickup',6,2,14),
('NR-5762-18', 'Toyota Prius', 'hybrid', 5,3,15),
('GR-234-21', 'Ford Explorer', 'SUV', 7,2,16),
('NR-E75-20', 'Volkswagen Jetta', 'sedan', 5,4,17),
('GR-A453-18', 'Mercedes-Benz E-Class', 'luxury',5,4,18),
('NR-375-09', 'Honda CR-V', 'SUV',5,1,19),
('ER-5675-19', 'GMC Yukon', 'SUV', 8,2,20),
('GR-1615-22', 'Toyota Tundra', 'pickup', 6,2,21),
('WR-758-20', 'Nissan Rogue', 'SUV',5,1,22),
('GR-4890-23', 'Ford Escape', 'SUV',5,4,23);


/*CREATING TRIGGER FUNCTIONS FOR THE VARIOUS AUDIT TABLES*/

CREATE OR REPLACE FUNCTION employee_audit_function() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO employee_audit ( empl_id, empl_name, empl_field, email, phone)
        VALUES ('D', NOW(), OLD.empl_id, OLD.empl_name, OLD.empl_field, OLD.email, OLD.phone);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO employee_audit (empl_id, empl_name, empl_field, email, phone)
        VALUES ('U', NOW(), NEW.empl_id, NEW.empl_name, NEW.empl_field, NEW.email, NEW.phone);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO employee_audit (empl_id, empl_name,field_id, email, phone)
        VALUES ('I', NOW(), NEW.empl_id, NEW.empl_name, NEW.field_id, NEW.email, NEW.phone);
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER employee_audit_trigger
AFTER INSERT OR UPDATE OR DELETE
ON employee
FOR EACH ROW
EXECUTE procedure employee_audit_function();




CREATE OR REPLACE FUNCTION product_suppliers_audit() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO product_supplier_audit (supplier_id, name, phone, email, address)
        VALUES ('D', NOW(), OLD.supplier_id, OLD.name, OLD.phone, OLD.email, OLD.address);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO product_supplier_audit (supplier_id, name, phone, email, address)
        VALUES ('U', NOW(), NEW.supplier_id, NEW.name, NEW.phone, NEW.email, NEW.address);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO product_suppliers_audit ( supplier_id, name, phone, email, address)
        VALUES ('I', NOW(), NEW.supplier_id, NEW.name, NEW.phone, NEW.email, NEW.address);
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER product_supplier_audit_trigger
AFTER INSERT OR UPDATE OR DELETE
ON product_suppliers
FOR EACH ROW
EXECUTE  procedure product_suppliers_audit();


CREATE OR REPLACE FUNCTION customer_audit() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO customer_audit ( customer_id,customer_name, email,phone,product_id)
        VALUES ('D', NOW(), OLD.customer_id, OLD.customer_name, OLD.email, OLD.phone,OLD.product_id);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO customer_audit (customer_id, customer_name,email,phone)
        VALUES ('U', NOW(), NEW.customer_id, NEW.customer_name, NEW.email, NEW.phone,NEW.product_id);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO customer_audit (customer_id, customer_name,Email,phone)
        VALUES ('I', NOW(),NEW.customer_id, NEW.customer_name, NEW.Email, NEW.phone,NEW.product_id);
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER customer_audit_trigger
 AFTER INSERT OR UPDATE OR DELETE
ON customer
FOR EACH ROW
EXECUTE PROCEDURE customer_audit();


CREATE OR REPLACE FUNCTION transactions_audit_trigger()
RETURNS TRIGGER AS $$
BEGIN
    NEW.Amount := NEW.Quantity * (SELECT Price FROM Products WHERE Product_ID = NEW.Product_ID);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_transactions_audit_amount
BEFORE INSERT OR UPDATE OF Quantity, Product_ID
ON Transactions_audit
FOR EACH ROW
EXECUTE  procedure transactions_audit_trigger();