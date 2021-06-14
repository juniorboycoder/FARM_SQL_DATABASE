/* PROJECT ON REAL-LIFE FARM MANAGEMENT DATABASE*/


/* CREATE FARM MANAGEMENT DATABASE*/
CREATE DATABASE  FARMMANAGEMENT;
USE FARMMANAGEMENT;







/* 1. TABLE , CONSTRAINTS AND KEYS */


/* create a farmer table */
CREATE TABLE Farmers
(

/* primary key */
farmerID int  NOT NULL PRIMARY KEY,
/*NOT NULL*/
farmerName varchar(8000) NOT NULL,
farmerShift varchar(8000),

/*UNIQUE Constraint, */
farmerPhoneNumber bigint UNIQUE NOT NULL ,
);





/* create a Harvester table */

CREATE TABLE Harvester
(
harvesterID int PRIMARY KEY,
harvesterName varchar(8000) NOT NULL,
harvesterPhoneNumber bigint NOT NULL 
);


/* create a Farmproduce table */

CREATE TABLE Farmproduce
(
harvesterID int,
FOREIGN KEY (harvesterID) REFERENCES Harvester (harvesterID),
farmproducename varchar(8000) NOT NULL PRIMARY KEY ,
farmproducebasketquantity int  NOT NULL ,

);


/* create a Farm tools table */

CREATE TABLE Farmtools
(
farmertoolsID int PRIMARY KEY,
farmerID Int
FOREIGN KEY (farmerID) REFERENCES Farmers (farmerID),
toolname varchar(8000) NOT NULL ,
toolquantity int  NOT NULL ,

);







/* 2. DDL COMMANDS */

/* 2.1 DDL COMMAND : ALTER TABLE */

/*add a column with alter*/
ALTER TABLE Farmers ADD Farmer_age varchar(8000);

ALTER TABLE Farmers ADD FarmerNationality varchar(8000)

ALTER TABLE Farmproduce ADD harvesterName varchar(8000)



/*drop a column with alter*/

ALTER TABLE Farmers DROP COLUMN Farmer_age

/*alter a column datatype with alter*/

ALTER TABLE  Farmers ALTER COLUMN  farmerNationality varchar(5000);


/*add a unique constraint column with alter */
ALTER TABLE Harvester ADD UNIQUE(harvesterPhonenumber)

/*add a default constraint column with alter */
ALTER TABLE Farmers 
ADD CONSTRAINT FarmerNationality
DEFAULT 'Nigeria' FOR FarmerNationality



/* 2.2 DDL COMMAND : DROP TABLE */

/* TO DROP A table*/
DROP TABLE farmtools

/* TO DROP A DATABASE*/

DROP DATABASE FARMMANAGEMENT



/* 3. DML COMMAND (INSERT, SELECT) */


/*SELECT */
Select * from Farmers
Select * from Harvester
Select * from Farmproduce
Select * from Farmtools

/*INSERT INTO Farmers TABLE */
INSERT INTO Farmers VALUES('1','Segun','Morning','08146640449','Nigeria')

INSERT INTO Farmers VALUES('2','david','Afternoon','08144640489','Nigeria')

INSERT INTO Farmers VALUES('3','john','Evening','07043610459','Nigeria')

INSERT INTO Farmers VALUES('4','Mary','Evening','+9135940312','India')
INSERT INTO Farmers VALUES('5','Eastwood','Morning','+6151690314','Australia')

/*INSERT INTO Harvester TABLE */

INSERT INTO Harvester VALUES('1','Ayo','080753452890')

INSERT INTO Harvester VALUES('2','Henry','081417319834')

/* OR */

INSERT INTO Harvester(harvesterID, harvesterName,harvesterPhoneNumber)
VALUES ('3','Yemi','07057215444');

/*INSERT INTO farmproduce TABLE */

INSERT INTO farmproduce VALUES('1','Apple','2')

INSERT INTO farmproduce VALUES('2','Mango','5')


/*INSERT INTO farmtool TABLE */

INSERT INTO farmtools VALUES('1','1','cutlass','4')

INSERT INTO farmtools VALUES('2','2','Spades','6')

INSERT INTO farmtools VALUES('3','3','Waterringcan','7')

/* 3.1 DML COMMAND ( SELECT) */

SELECT * FROM Farmers
/*OR */

SELECT farmerName,farmerID from Farmers

SELECT DISTINCT FarmerNationality from Farmers

SELECT * FROM Farmers ORDER BY farmerName DESC

/* 3.2 AGGREGRATE FUNCTIONS WITH SELECT */
/*COUNT*/ /*AND*/ /*GROUPBY*/
SELECT COUNT(farmerID),farmerShift   From Farmers GROUP BY farmerShift

/* 4 HAVING */
SELECT COUNT(farmerID), farmerShift from Farmers GROUP BY  farmerShift 
HAVING COUNT (farmerID) > 1

/* 5 BACKUP FOR FARMERS */
SELECT * INTO farmerBackup from Farmers

/* 6 CUBE */

SELECT farmerID, COUNT(farmerName) FROM Farmers GROUP BY CUBE (farmerID) ORDER BY farmerID


/* 7 ROLLUP */
SELECT farmerID, COUNT(farmerName) FROM Farmers GROUP BY ROLLUP (farmerID)

/*  8 DML COMMAND UPDATE */

UPDATE Farmers SET farmerName ='junior'
WHERE farmerID=1

Select * from Farmers

/* 9 DML COMMAND DELETE */

DELETE from Farmtools WHERE toolname='spades'

DELETE from Farmers

/* 10  MERGE Harvester and farmproduce tables */

MERGE farmproduce T
USING Harvester S ON T.harvesterid=S.harvesterid
WHEN MATCHED THEN
UPDATE SET harvesterName=S.harvesterName;

Select * from  farmproduce

/* OR */
/*  MERGE Harvester and farmproduce tables */
MERGE farmproduce T
USING Harvester S ON T.harvesterid=S.harvesterid
WHEN MATCHED AND T.harvesterid =2 THEN
DELETE 
WHEN MATCHED AND T.harvesterid =1 THEN
UPDATE SET harvesterName=S.harvesterName;

Select * from  farmproduce


/* 11. AVERAGE OF farmproducebasketquantity*/

Select harvesterid, AVG(farmproducebasketquantity) as Averagequantityofproduce
from farmproduce GROUP BY harvesterid



/* 12 OPERATORS */

Select 40 + 60

Select * from farmproduce WHERE farmproducebasketquantity >= '2' 
OR farmproducebasketquantity='7'

/* 12.1 USING LIKE */
SELECT * FROM Farmers where farmername LIKE 'j%'

/* 12.2 CONCAT */

SELECT (farmername + ',' + FarmerNationality) AS farmernameandcountry from Farmers

/* 12.3 UNION */
Select * from Harvester
UNION
Select * from Farmtools

/* 13 NESTED QUERIES */
Select farmername
from Farmers
where farmerPhoneNumber in ( SELECT farmerPhoneNumber  
from Farmers where farmerNationality ='Nigeria')

/* 14 JOIN */

SELECT Harvester.HarvesterID, Farmproduce.farmproducename
FROM Harvester
INNER JOIN Farmproduce ON Harvester.harvesterID= Farmproduce.harvesterID;


SELECT Harvester.HarvesterID, Farmproduce.farmproducename
FROM Harvester
RIGHT JOIN Farmproduce ON Harvester.harvesterID= Farmproduce.harvesterID;


/* 15. STOREDPROCEDURE */

CREATE PROCEDURE SelectAllFarmersindatabase
AS
SELECT * FROM Farmers
GO;

EXEC SelectAllFarmersindatabase;

/* 16. DCL Commands */

CREATE LOGIN USER3 WITH PASSWORD= 'Junior1234'

CREATE USER JUN FOR LOGIN USER3


/* GRANT */
GRANT Select on Farmers to JUN

/*REVOKE */
REVOKE SELECT ON Farmers to JUN

/* 17. TCL : COMMIT, ROLLBACK , SAVEPOINT*/

/*  TCL : COMMIT */
BEGIN TRANSACTION
INSERT INTO Harvester VALUES('7','precious','0907472511200')

COMMIT;

/*  TCL : ROLLBACK */
BEGIN TRANSACTION
ROLLBACK TRANSACTION
PRINT( 'Transaction succesful')

/*  TCL : SAVEPOINT OR SAVE */

SAVE TRANSACTION




/*  18 EXCEPTION HANDLING */

BEGIN TRY
Select farmerID + farmerID from Farmers
END TRY
BEGIN CATCH
PRINT 'NOT POSSIBLE'
END CATCH
 