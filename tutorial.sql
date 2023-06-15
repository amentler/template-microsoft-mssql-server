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

/*markdown
# Prüfen, obs erfolgreich war
*/

/*markdown
# Anlegen geeigneter Datensätze
*/

/*markdown
# Prüfen, obs erfolgreich war
*/