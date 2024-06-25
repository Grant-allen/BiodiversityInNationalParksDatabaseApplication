--QUESTION 1

-- A tourist really likes bird watching and is visiting the Northwest Rockies. Which Park should they visit?
SELECT Parkname, Count(Category_) as UniqueBirdsSpecies
FROM PARKS JOIN OCCURRENCES ON parks.parkcode = occurrences.parkcode
JOIN Species ON species.speciesID = occurrences.speciesid
WHERE category_ = 'Bird'
GROUP BY Parkname;

--SUPPOSE THE TOURIST IS SPECIFICALLY INTERESTED IN RARE BIRD SPECIES NATIVE TO THE PARK THEY VISIT. WHAT PARK HAS THE HIGHEST COUNT OF THESE BIRDS?
SELECT ParkName, Count(Occurrences.SpeciesID) as NumSpecies
FROM Occurrences JOIN Species ON Occurrences.SpeciesID = Species.SpeciesID
JOIN Parks ON Occurrences.ParkCode = Parks.ParkCode
WHERE Category_ = 'Bird' and Nativeness = 'Native' and Abundance = 'Rare'
GROUP BY ParkName
ORDER BY ParkName asc;

--QUESTION 2

/*THE NATIONAL PARK CONSERVATIONISTS WANT TO KNOW HOW WELL THEY ARE DOING ON RECOVERING ENDANGERED SPECIES, WHAT SPECIES ARE IN RECOVERY IN EACH PARK */
SELECT DISTINCT SPECIES.SPECIESID, SCIENTIFICNAME, COMMONNAME, CONSERVATIONSTATUS, PARKCODE
FROM SPECIES 
JOIN COMMONNAMES 
ON SPECIES.SPECIESID=COMMONNAMES.SPECIESID
JOIN OCCURRENCES ON SPECIES.SPECIESID=OCCURRENCES.SPECIESID
WHERE CONSERVATIONSTATUS='In Recovery';

/* WHAT MAMMAL SPECIES DO THE CONSERVATIONISTS NEED TO BE CONSERNED WITH IN THE NAITONAL PARKS?*/
SELECT SPECIESID, SCIENTIFICNAME, CONSERVATIONSTATUS
FROM SPECIES 
WHERE CATEGORY_='Mammal' 
INTERSECT
SELECT SPECIESID, SCIENTIFICNAME, CONSERVATIONSTATUS
FROM SPECIES 
WHERE CONSERVATIONSTATUS='Species of Concern' OR CONSERVATIONSTATUS='Threatened' or CONSERVATIONSTATUS='In Recovery'
ORDER BY CONSERVATIONSTATUS ASC;

/*PARK MAP FOR APPLICATION*/
SELECT PARKNAME, ACRES, LATITUDE, LONGITUDE
FROM PARKS
ORDER BY ACRES ASC;

--QUESTION 3

--WE WANT TO KNOW WHICH NATIONAL PARK HAS THE MOST MIGRATION FOR ALL ITS SPECIES.
select parkcode as NationalPark, 
    sum(case when seasonality = 'Migratory' then 1 else 0 end) as TotalSpeciesMigration,
    (case 
    when sum(case when seasonality = 'Migratory' then 1 else 0 end) > 50 then 'Substantial Migration' 
    when sum(case when seasonality = 'Migratory' then 1 else 0 end) > 25 then 'Moderate Migration' 
    else 'Minimal Migration' 
    end) as MigrationLevel
from occurrences
group by parkcode;

--WHAT PARK HAS THE MOST UNCONFIRMED SPECIES OCCURRENCES?
SELECT ParkName, Count(Occurrence) as Occurrence
FROM Occurrences JOIN Parks ON Occurrences.ParkCode = Parks.ParkCode
WHERE Occurrence = 'Not Confirmed'
GROUP BY ParkName
ORDER BY Occurrence desc
;
