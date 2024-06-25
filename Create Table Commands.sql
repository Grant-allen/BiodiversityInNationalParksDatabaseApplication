--Drop table commands 
DROP TABLE SPECIES
DROP TABLE PARKS
DROP TABLE OCCURRENCES 
DROP TABLE COMMONNAMES
DROP TABLE STATES 

--Species Table
CREATE TABLE SPECIES (
    SpeciesID VARCHAR2(3) NOT NULL,
    Category_ VARCHAR2(40) NOT NULL,
    Order_ VARCHAR2(40) NOT NULL,
    Family_ VARCHAR2(40) NOT NULL,
    ScientificName VARCHAR2(40) NOT NULL,
    ConservationStatus VARCHAR2(25),
    CONSTRAINT Species_PK PRIMARY KEY (SpeciesID)
);

--Parks Table
CREATE TABLE PARKS (
    ParkCode VARCHAR2(10) NOT NULL,
    ParkName VARCHAR2(25) NOT NULL,
    Acres NUMBER(8) NOT NULL,
    Latitude NUMBER(5,2) NOT NULL,
    Longitude NUMBER(5,2) NOT NULL,
    CONSTRAINT Parks_PK PRIMARY KEY (ParkCode)
);

--Occurences Table
CREATE TABLE OCCURRENCES (
    SpeciesID VARCHAR2(3) NOT NULL,
    ParkCode VARCHAR2(10) NOT NULL,
    Occurrence VARCHAR2(25) NOT NULL,
    Nativeness VARCHAR2(20) NOT NULL,
    Abundance VARCHAR2(25),
    Seasonality VARCHAR2(25),
    CONSTRAINT Occurrences_PK PRIMARY KEY (SpeciesID, ParkCode),
    CONSTRAINT Occurrences_FK FOREIGN KEY (SpeciesID) REFERENCES Species (SpeciesID)
);

--Common Names Table
CREATE TABLE COMMONNAMES (
    SpeciesID VARCHAR2(3) NOT NULL,
    CommonName VARCHAR2(40),
    CONSTRAINT CommonNames_PK PRIMARY KEY (SpeciesID, CommonName),
    CONSTRAINT CommonNames_FK FOREIGN KEY (SpeciesID) REFERENCES SPECIES (SpeciesID)
);

--States Table
CREATE TABLE STATES (
    ParkCode VARCHAR2(10) NOT NULL,
    State VARCHAR2(2) NOT NULL,
    CONSTRAINT States_PK PRIMARY KEY (ParkCode, State),
    CONSTRAINT States_FK FOREIGN KEY (ParkCode) REFERENCES PARKS (ParkCode)
);