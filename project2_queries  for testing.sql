 1.	/*SQL query to retrive information on the emplooyes, their salaries
	and the category of job they are doing*/

	select Empl_name,Empl_id,job_name,job_description,salary
	from employee
	inner join job_category ON employee.field_id=job_category.job_id
	Order BY salary desc.

2      /*SQL to retrieve information on the  customers, the type of cars they use,
         the name of the employee that sold the fuel to them, 
         type of fuel the customer bought ,the time and date of purchase of the fuel*/

          select customer_name,vehicle_name,number_plate,product.name,
           empl_name,amount,date,time
           from transactions
          inner join customer on customer.customer_id=transactions.customer_id
          inner join employee on employee.empl_id=transactions.empl_id
          inner join vehicles on vehicles.vehicle_id=transactions.vehicle_id
          inner join product on product.product_id=vehicles.fuel_id

3.     /*SQL query to retrieve informantion on the names of vehicles, the capacity, type
          and the type of fuel it consumes */

         SELECT vehicle_name,type,capacity,name
         FROM vehicles
         INNER JOIN product ON 
         vehicles.fuel_id=product.product_id
         ORDER BY capacity ASC
        
4.     /*SQL query to retrieve information of the product suppliers, their names
        type of product/fuel they supply and the quantity they supplied*/
       
       SELECT product.name,product_suppliers.name, quantity_supplied_per_litre
       FROM product
       INNER JOIN product_suppliers ON
       product_suppliers.supplier_id=product.supplier_id
       ORDER BY product_id ASC

5.    /*SQL query to retrieve all information on product*/
      SELECT*
      FROM product

6     /*SQL query to retrieve all information about the employee*/
      SELECT*
      FROM employee


7     /*SQL query to retrieve all information on vehicles*/
      SELECT*
      FROM vehicles

8      /*SQL query to retrieve all information on transactions*/

      SELECT*
      FROM transactions

9     /*SQL query to retrieve all information on customer*/

      SELECT*
      FROM customer

10    /*SQL query to retrieve all information on product_suppliers*/
      SELECT*
      FROM product_suppliers










 	