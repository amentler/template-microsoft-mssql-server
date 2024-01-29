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

CREATE DATABASE EinkaufHistorie;

Go

USE EinkaufHistorie;


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
VALUES 
('Milch', 1.99),
('Schokolade', 1.29),
('Spaghetti', 0.69)

/*markdown
# Korrektur der Produkte Tabelle
*/

ALTER TABLE Produkte 
ALTER COLUMN "Preis" DECIMAL(10,2)

/*markdown
Die ursprüngliche Präzision haben wir verloren. Diese stellen wir nun wieder mit dem Update Befehl her und ändern dadurch den bestehenden Preis der Milch zurück auf den präzisen Wert von Preis = 1,99€
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

alter table Kaufhistorie 
add ProduktId int
go
insert into kaufhistorie(Datum, Anzahl, ProduktId) 
values 
('1.2.23', 5, 2),
('1.1.23', 1, 1),
('1.1.23', 1, 4);

/*markdown
# Prüfen, obs erfolgreich war
*/

select *
from kaufhistorie

select *
from kaufhistorie k full outer join produkte p on p.id = k.produktid


/*markdown
# Spalte 'produktid' aus Tabelle Kaufhistorie umwandeln in Foreign Key
*/
delete from Kaufhistorie;

ALTER TABLE Kaufhistorie ADD CONSTRAINT
FK_kaufhistorie_produkte FOREIGN KEY
(
ProduktId
) REFERENCES Produkte
(
ID
) ON UPDATE  NO ACTION
 ON DELETE CASCADE;

/*markdown
# Testen, ob die Delete Kaskade korrekt funktioniert (funktioniert in sql notebook nicht richtig)
*/

begin transaction

delete from Produkte

DBCC CHECKIDENT ('produkte', RESEED, 0)
GO

insert into produkte(name, preis)
values ('test produkt 1', 1.99),
       ('test produkt 2', 2.99);
go

select * from produkte

insert into Kaufhistorie(Datum, Anzahl, ProduktId)
values ('2023-08-08', 5, 0), ('2023-08-08', 3, 1)

select * from Kaufhistorie;


delete from produkte where ID = 1;

select * from kaufhistorie;
rollback transaction

/*markdown
# Normalisierung bis 3. Normalform anschauen
*/



/*markdown
# Indizes anschauen und optimieren
*/


/*markdown
# Spieldaten
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vAdresseintrag](
	[objid] [bigint] NOT NULL,
	[modified] [datetime] NOT NULL,
	[typ] [varchar](255) NOT NULL,
	[firma_name] [varchar](255) NULL,
	[land] [varchar](255) NULL,
	[betreuer_id] [bigint] NULL,
	[Umsatz] [decimal](18, 2) NULL,
 CONSTRAINT [PK__vAdresse__FCBB05AA024E9107] PRIMARY KEY CLUSTERED 
(
	[objid] ASC,
	[modified] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (78727, CAST(N'2020-02-04T10:59:15.000' AS DateTime), N'Firma', N'Blubbhaus AG', N'Deutschland', 17590, CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (78727, CAST(N'2020-08-28T18:02:48.000' AS DateTime), N'Firma', N'Blubbhaus AG', N'Deutschland', 17590, CAST(40.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (78727, CAST(N'2021-04-28T10:18:00.000' AS DateTime), N'Firma', N'Blubbhaus AG', N'Deutschland', 17590, CAST(80.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (78727, CAST(N'2021-07-21T12:45:10.000' AS DateTime), N'Firma', N'Blubbhaus AG', N'Deutschland', 17590, CAST(100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (78727, CAST(N'2023-01-23T15:57:18.000' AS DateTime), N'Firma', N'Blubbhaus AG', N'Deutschland', 17590, CAST(200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (942539, CAST(N'2022-02-17T21:00:33.000' AS DateTime), N'Firma', N'Letraxis GmbH', N'Österreich', 922234, CAST(200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (942550, CAST(N'2022-02-17T21:00:33.000' AS DateTime), N'Firma', N'Moraxas e.V.', N'Österreich', 922234, CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (942561, CAST(N'2022-02-17T21:00:33.000' AS DateTime), N'Firma', N'Suquinix AG', N'Schweiz', 922234, CAST(300.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (942572, CAST(N'2022-02-17T21:00:33.000' AS DateTime), N'Firma', N'Bonux GmbH', N'Schweiz', 922234, CAST(400.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (942726, CAST(N'2022-02-17T21:00:33.000' AS DateTime), N'Firma', N'Detra GmbH', N'Polen', 922234, CAST(100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (943584, CAST(N'2022-02-17T21:00:33.000' AS DateTime), N'Firma', N'Samux AG', N'Österreich', 922234, CAST(50.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (943595, CAST(N'2021-10-26T13:58:35.000' AS DateTime), N'Kontakt', N'Brezel GmbH', N'Deutschland', 63818, NULL)
GO
INSERT [dbo].[vAdresseintrag] ([objid], [modified], [typ], [firma_name], [land], [betreuer_id], [Umsatz]) VALUES (943595, CAST(N'2022-02-17T21:00:33.000' AS DateTime), N'Kontakt', N'Gomux e.V.', N'Frankreich', 922234, NULL)
GO


/*markdown
# Aggregates
*/

select MIN(modified) from vAdresseintrag

select COUNT(1) from vAdresseintrag where typ='Firma'

select firma_name, COUNT(objid) from vAdresseintrag group by firma_name

select land from vAdresseintrag group by land having COUNT(land)>1


/*markdown
# Window Functions
*/
SELECT *, ROW_NUMBER() over (PARTITION BY objid ORDER BY modified DESC) as counter
FROM vAdresseintrag

SELECT *, lag(modified) over (PARTITION BY objid ORDER BY modified DESC) as lagmodified
FROM vAdresseintrag
