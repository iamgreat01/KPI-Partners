--CHANNEL
CREATE TABLE CHANNEL(
DATE_CREATED DATE,
IS_RECORD_INACTIVE CHAR,
LAST_MODIFIED_DATE DATE,
LIST_ID NUMBER(20),
LIST_ITEM_NAME VARCHAR(20)
);

ALTER TABLE CHANNEL ADD CONSTRAINT pk_LISTID PRIMARY KEY(LIST_ID); --Primary to CHANNEL TABLE

--TRANSACTIONS
 CREATE TABLE TRANSACTIONS(
TRANSACTION_ID NUMBER(20,0),
TRANID VARCHAR(30),
TRANSACTION_TYPE VARCHAR(50),
TRANDATE DATE,
CHANNEL_ID NUMBER(20,0)
);

delete from TRANSACTIONS 
where rowid not in (select max(rowid) from TRANSACTIONS group by transaction_id);

ALTER TABLE TRANSACTIONS ADD CONSTRAINT pk_TRANSACTIONID PRIMARY KEY(TRANSACTION_ID);

ALTER TABLE TRANSACTIONS  
ADD CONSTRAINT fk_CHANNELID
FOREIGN KEY (CHANNEL_ID) REFERENCES CHANNEL(LIST_ID);

--LOCATIONS
CREATE TABLE LOCATIONS(
LOCATION_ID NUMBER(20,0),
ADDRESS    VARCHAR(150),
CITY VARCHAR(50),
COUNTRY VARCHAR(50),
DATE_LAST_MODIFIED DATE,
FULL_NAME VARCHAR(60),
ISINACTIVE VARCHAR(5),
NAME VARCHAR(50)
);

ALTER TABLE LOCATIONS ADD CONSTRAINT pk_LOCATIONID PRIMARY KEY(LOCATION_ID);

--TRANSACTION_LINES
CREATE TABLE TRANSACTION_LINES(
TRANSACTION_ID NUMBER(20,0),
TRANSACTION_LINE_ID NUMBER(20,0),
LOCATION_ID NUMBER(20,0),
DEPARTMENT_ID NUMBER(20,0),
ITEM_ID  NUMBER(20,0),
AMOUNT NUMBER(8,2),
COST NUMBER(8,2),
UNITS NUMBER(5,0)
);

delete from TRANSACTION_LINES 
where rowid not in (select max(rowid) from TRANSACTION_LINES group by TRANSACTION_ID);

select   from transaction_lines;

ALTER TABLE TRANSACTION_LINES ADD CONSTRAINT pk_TRANSACTION_ID PRIMARY KEY(TRANSACTION_ID);

ALTER TABLE TRANSACTION_LINES 
ADD CONSTRAINT fk_TRANSACTIONID
FOREIGN KEY (TRANSACTION_ID) REFERENCES TRANSACTIONS(TRANSACTION_ID);

ALTER TABLE TRANSACTION_LINES 
ADD CONSTRAINT fk_LOCATIONID
FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS(LOCATION_ID);

ALTER TABLE TRANSACTION_LINES 
ADD CONSTRAINT fk_ITEMID
FOREIGN KEY (ITEM_ID) REFERENCES ITEMS(ITEM_ID);

DELETE FROM TRANSACTION_LINES 
WHERE item_id NOT IN (SELECT ITEM_ID FROM ITEMS);

SELECT COUNT() FROM TRANSACTION_LINES;

-- DEPARTMENTS
CREATE TABLE  DEPARTMENTS(
DATE_LAST_MODIFIED DATE,
DEPARTMENT_ID NUMBER(20,0),
ISINACTIVE VARCHAR(5),
NAME VARCHAR(20),
WS_DESCRIPTION VARCHAR(50)
);

ALTER TABLE DEPARTMENTS ADD CONSTRAINT pk_DEPARTMENTID PRIMARY KEY(DEPARTMENT_ID);

DELETE FROM TRANSACTION_LINES 
WHERE DEPARTMENT_ID NOT IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS);

ALTER TABLE TRANSACTION_LINES 
ADD CONSTRAINT fk_DEPARTMENTID
FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID);



--ITEMS
CREATE TABLE ITEMS(
ITEM_ID NUMBER(20,0),
SKU VARCHAR(100),
TYPE_NAME VARCHAR(30),
SALESDESCRIPTION VARCHAR(100),
CLASS_ID NUMBER(20,0),
WS_MERCHANDISE_DEPARTMENT_ID NUMBER(20,0),
WS_MERCHANDISE_COLLECTION_ID NUMBER(20,0),
WS_MERCHANDISE_CLASS_ID      NUMBER(20,0),
WS_MERCHANDISE_SUBCLASS_ID   NUMBER(20,0)
);

DELETE FROM ITEMS
WHERE rowid not in (select max(rowid) from ITEMS group by ITEM_ID);

ALTER TABLE ITEMS ADD CONSTRAINT pkITEM_ID PRIMARY KEY(ITEM_ID);

ALTER TABLE TRANSACTION_LINES 
ADD CONSTRAINT fk_ITEMID
FOREIGN KEY (ITEM_ID) REFERENCES ITEMS(ITEM_ID);

--CLASSES
CREATE TABLE CLASSES(
CLASS_ID NUMBER(20,0),
DATE_LAST_MODIFIED DATE,
FULL_NAME VARCHAR(30),
ISINACTIVE VARCHAR(5),
NAME       VARCHAR(5)
);

SELECT  FROM CLASSES;
ALTER TABLE CLASSES ADD CONSTRAINT pk_CLASSID PRIMARY KEY (CLASS_ID);

ALTER TABLE ITEMS
ADD CONSTRAINT fk_WS_MERCHANDISECLASSID
FOREIGN KEY (CLASS_ID) REFERENCES CLASSES(CLASS_ID);

--ITEM_MERCHANDISE_DEPTARMENT
CREATE TABLE ITEM_MERCHANDISE_DEPTARMENT(
ITEM_MERCHANDISE_DEPARTMENT_ID NUMBER(20,0),
DESCRIPTION VARCHAR(50),
ITEM_MERCHANDISE_DEPARTMENT_NA VARCHAR(10)
);

ALTER TABLE ITEM_MERCHANDISE_DEPTARMENT  ADD CONSTRAINT pk_ITEMMERCHANDISEDEPARTMENTID PRIMARY KEY (ITEM_MERCHANDISE_DEPARTMENT_ID);

ALTER TABLE ITEMS
ADD CONSTRAINT fk_MERCHANDISEDEPARTMENTID
FOREIGN KEY (WS_MERCHANDISE_DEPARTMENT_ID) REFERENCES ITEM_MERCHANDISE_DEPTARMENT(ITEM_MERCHANDISE_DEPARTMENT_ID);

--ITEM_MERCHANDISE_COLLECTION
CREATE TABLE ITEM_MERCHANDISE_COLLECTION(
ITEM_MERCHANDISE_COLLECTION_ID NUMBER(20,0),
DESCRIPTION VARCHAR(50),
ITEM_MERCHANDISE_COLLECTION_NA VARCHAR(50)
);

ALTER TABLE ITEM_MERCHANDISE_COLLECTION  ADD CONSTRAINT pk_ITEMMERCHANDISECOLLECTIONID PRIMARY KEY (ITEM_MERCHANDISE_COLLECTION_ID);

desc ITEM_MERCHANDISE_COLLECTION;

ALTER TABLE ITEMS
ADD CONSTRAINT fk_MERCHANDISECOLLECTIONID
FOREIGN KEY (WS_MERCHANDISE_COLLECTION_ID) REFERENCES ITEM_MERCHANDISE_COLLECTION(ITEM_MERCHANDISE_COLLECTION_ID);

DELETE FROM ITEMS
WHERE ws_merchandise_collection_id NOT IN (SELECT ITEM_MERCHANDISE_COLLECTION_ID FROM item_merchandise_collection);

--ITEM_MERCHANDISE_CLASS
CREATE TABLE ITEM_MERCHANDISE_CLASS(
ITEM_MERCHANDISE_CLASS_ID NUMBER(20,0),
DESCRIPTION VARCHAR(50),
ITEM_MERCHANDISE_CLASS_NAME VARCHAR(5)
);
ALTER TABLE ITEM_MERCHANDISE_CLASS  ADD CONSTRAINT pk_ITEMMERCHANDISECLASSID PRIMARY KEY (ITEM_MERCHANDISE_CLASS_ID);

ALTER TABLE ITEMS
ADD CONSTRAINT fk_MERCHANDISECOLLECTION_ID
FOREIGN KEY (WS_MERCHANDISE_CLASS_ID) REFERENCES ITEM_MERCHANDISE_CLASS (ITEM_MERCHANDISE_CLASS_ID);


DELETE FROM ITEMS
WHERE ws_merchandise_class_id NOT IN (SELECT ITEM_MERCHANDISE_CLASS_ID FROM item_merchandise_class);

--ITEM_MERCHANDISE_SUBCLASS
CREATE TABLE ITEM_MERCHANDISE_SUBCLASS(
ITEM_MERCHANDISE_SUBCLASS_ID NUMBER(20,0),
DESCRIPTION VARCHAR(50),
ITEM_MERCHANDISE_SUBCLASS_NAME VARCHAR(10)
);

ALTER TABLE ITEM_MERCHANDISE_SUBCLASS  ADD CONSTRAINT pk_ITEMMERCHANDISESUBCLASSID PRIMARY KEY (ITEM_MERCHANDISE_SUBCLASS_ID);

ALTER TABLE ITEMS
ADD CONSTRAINT fk_WSMERCHANDISESUBCLASSID
FOREIGN KEY (WS_MERCHANDISE_SUBCLASS_ID) REFERENCES ITEM_MERCHANDISE_SUBCLASS (ITEM_MERCHANDISE_SUBCLASS_ID);

DELETE FROM ITEMS
WHERE ws_merchandise_subclass_id NOT IN (SELECT ITEM_MERCHANDISE_SUBCLASS_ID FROM ITEM_MERCHANDISE_SUBCLASS);
