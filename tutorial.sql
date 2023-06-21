/*markdown
# Vorbereitung
1. Konfiguriere die Notebook Einstellungen links im SQL Notebook Tab und erstelle eine Datenbank Verbindung mit folgenden Einstellungen:  
Display Name: local  
Database Driver: mssql  
Databse Host: localhost  
Database Port: 1433  
Databse User: sa  
Database Password: TeSt1234  
Database: master  
2. Aktiviere anschließend noch die angelegte Verbindung!
3. Nutze rechtsklick auf diese Datei (aufgabe.sql) -> open with, um diese als notebook zu starten!
# Einrichtung der Datenbank mit Tabellen
Der folgende Code muss einmalig ausgeführt werden, um die Datenbank mit der Tabelle anzulegen.
*/

/*markdown
# Erzeugen einer neuen Datenbank
*/

CREATE DATABASE EinkaufHistorie

/*markdown
# Anlegen der Tabelle Produkte, Kaufhistorie
*/

CREATE Table Produkte (
    Name nvarchar(max),
    Preis DECIMAL    
);

CREATE Table Kaufhistorie (
    Datum date,
    Anzahl int   
);




/*markdown
# Prüfen des bisherigen Ergebnisses
*/

select * from Produkte;

/*markdown
# Anlegen mehrerer Produkte
*/

INSERT INTO Produkte (Name, Preis)
VALUES ('Milch', 1.99)

/*markdown
# Korrektur der Produkte Tabelle
*/

ALTER TABLE Produkte 
ALTER COLUMN "Preis" DECIMAL(10,2)


/*markdown
# Die ursprüngliche Präzision haben wir verloren. Diese stellen wir nun wieder mit dem Update Befehl her und ändern dadurch den bestehenden Preis der Milch zurück auf den präzisen Wert von Preis = 1,99€
*/

UPDATE Produkte
SET Preis = 1.99
WHERE Name='Milch';

/*markdown
# Verändern der Produkte und Kaufhistorie Tabelle
Die Produkte Tabelle erhält einen Primärschlüssel und die Kaufhistorie einen Fremdschlüssel zur Produkte Tabelle
*/

delete from Produkte

ALTER TABLE Produkte
ADD ID int IDENTITY(1,1)

ALTER TABLE Produkte 
ADD PRIMARY KEY (ID);

/*markdown
# Prüfen, obs erfolgreich war
*/

Select *
From Produkte

/*markdown
# Neu Anlegen der Tabelle Produkte mit den Spalten in der richtigen Reihenfolge
*/


begin transaction;

select *
into #tempTable
from Produkte; 

drop table produkte;

CREATE Table Produkte (
    ID int IDENTITY(1,1),
    Name nvarchar(max),
    "Preis" DECIMAL(10,2),
    PRIMARY KEY (ID)
);

SET IDENTITY_INSERT Produkte ON;

insert into Produkte(ID, Name, Preis)
select ID, Name, Preis
from #tempTable;

SET IDENTITY_INSERT Produkte OFF;

select * 
from produkte;

commit transaction;

/*markdown
# Prüfen, ob die TempTable auch weg ist
*/


select *
from #tempTable

/*markdown
# Prüfen, ob die Produkte Tabelle nun korrekt aussieht
*/

select *
from Produkte

/*markdown
# Anlegen geeigneter Datensätze
*/

/*markdown
# Prüfen, obs erfolgreich war
*/