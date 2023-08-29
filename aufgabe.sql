/*markdown
# Vorbereitung
1. Konfiguriere die Notebook Einstellungen links im SQL Notebook Tab und erstelle eine Datenbank Verbindung mit folgenden Einstellungen:  
Display Name: local  
Database Driver: mssql
Databse Host: localhost  
Database Port: 1433  
Databse User: sa  
Database Password: TeSt1234  
Database Name: master  
2. Aktiviere anschließend noch die angelegte Verbindung!
3. Nutze rechtsklick auf diese Datei (aufgabe.sql) -> open with, um diese als notebook zu starten!
# Einrichtung der Datenbank mit Tabellen
Der folgende Code muss einmalig ausgeführt werden, um die Datenbank mit der Tabelle anzulegen.
*/

CREATE TABLE historic_table (
    ENTRY_ID int,
    SOME_VALUE_STRING NVARCHAR(1000) NULL,
    SOME_VALUE_INT int NULL,
    CREATED_ON DATETIME2
)

/*markdown
# Generierung von Testzeilen
In folgendem Abschnitt werden Testzeilen in der Tabelle angelegt, die für die Bearbeitung der weiteren Aufgaben genutzt werden sollen.
*/

TRUNCATE TABLE historic_table;

INSERT INTO historic_table (ENTRY_ID, SOME_VALUE_STRING, SOME_VALUE_INT, CREATED_ON) VALUES
(1, 'Startwert', 123, '2023-01-01 00:00:00'),
(1, 'Wert am 02.01.', 123, '2023-01-02 00:00:00'),
(1, 'Wert am 03.01.', 123, '2023-01-03 00:00:00'),
(1, 'jetzt auch mit neuem int', 234, '2023-01-04 00:00:00'),
(1, 'Wert', 12, '2023-01-05 00:00:00'),
(1, 'Wert', 2000, '2023-01-06 00:00:00'),
(1, 'Wert', 11, '2023-01-07 00:00:00'),
(2, 'Zweiter Eintrag', 555, '2023-01-02 00:00:00'),
(2, 'Zweiter Eintrag Änderung', 555, '2023-01-04 00:00:00'),
(2, 'Zweiter Eintrag weitere Änderung', 234, '2023-01-07 00:00:00'),
(3, 'Dritter Eintrag', 9876, '2023-01-01 00:00:00'),
(4, 'Vierter Eintrag', 234, '2023-01-01 00:00:00')

/*markdown
# Szenario
In einem Datawarehouse existiert die oben erstellte Tabelle mit Inhalten aus einem Anwendungssystem, die historisch gespeichert wurden.
Für einige Einträge existieren verschiedene Versionen im Zeitverlauf.
*/

/*markdown
# Aufgabe 1 - Aktuelle Einträge abfragen
Ein häufiger Use-Case für die Verwendung historischer Daten in einem Datawarehouse ist die Abfrage des aktuellen Datenbestandes ohne Historie.
Die erste Aufgabe besteht darin, aus der Liste aller Einträge der historischen Tabelle eine Auflistung der aktuellen Einträge auszugeben. Das Ergebnis soll für die gegebenen Daten bspw. wie in folgendem Beispiel aussehen:
| ENTRY_ID | SOME_VALUE_STRING                | SOME_VALUE_INT | CREATED_ON                 |
|----------|----------------------------------|----------------|----------------------------|
| 1        | Wert                             |   11           | "2023-01-07T00:00:00.000Z" |
| 2        | Zweiter Eintrag weitere Änderung |  234           | "2023-01-07T00:00:00.000Z" |
| 3        | Dritter Eintrag                  | 9876           | "2023-01-01T00:00:00.000Z" |
| 4        | Vierter Eintrag                  |  234           | "2023-01-01T00:00:00.000Z" |
*/

-- todo

/*markdown
# Aufgabe 2 - Vollständige Historie aufbauen
Für die Verwendung der historischen Daten ist häufig die Bestimmung von Gültigkeitszeiträumen sinnvoll, um weitere Abfragen für die Analyse der Daten zu vereinfachen.
Hierfür sind für jeden Eintrag die Spalten `GueltigVon` und `GueltigBis` zu bestimmen.
`GueltigBis` ist immer der Beginn der Gültigkeit des Nachfolgers.
Gibt es keinen Nachfolger, der Eintrag ist also der aktuellste, kann das Datum bspw. auf unendlich bzw. `9999-12-31 00:00:00` gesetzt werden.
Das ist ein Beispiel der vollständigen Historie für Einträge der `ENTRY_ID` 2:
| ENTRY_ID | SOME_VALUE_STRING                | SOME_VALUE_INT | CREATED_ON                 | GueltigVon                 | GueltigBis                 |
|----------|----------------------------------|----------------|----------------------------|----------------------------|----------------------------|
| 2        | Zweiter Eintrag                  | 555            | "2023-01-02T00:00:00.000Z" | "2023-01-02T00:00:00.000Z" | "2023-01-04T00:00:00.000Z" |
| 2        | Zweiter Eintrag Änderung         | 555            | "2023-01-04T00:00:00.000Z" | "2023-01-04T00:00:00.000Z" | "2023-01-07T00:00:00.000Z" |
| 2        | Zweiter Eintrag weitere Änderung | 234            | "2023-01-07T00:00:00.000Z" | "2023-01-07T00:00:00.000Z" | "9999-12-31T00:00:00.000Z" |
*/

-- hier muss nicht zwingend eine Änderung an den Quelldaten vorgenommen werden.

/*markdown
## Zusatzaufgabe
Aus welchem Grund könnte die Verwendung eines Datums in der Zukunft (bspw. 31.12.9999) als Ende des Gültigkeitszeitraums von aktuellen Einträgen sinnvoll sein, statt dieses einfach auf `NULL` zu belassen? 
*/

/*markdown
# Aufgabe 3 - Veränderungen ermitteln
Für jeden Eintrag in der Historie sollen jetzt die relativen Änderungen der Spalte `SOME_VALUE_INT` ermittelt werden. Es soll also die Differenz der Werte zu ihren Vorgängern berechnet werden.
Für die `ENTRY_ID` 2 könnte das Ergebnis etwa so aussehen:
| ENTRY_ID | SOME_VALUE_STRING                | SOME_VALUE_INT | CREATED_ON                 | Veraenderung |
|----------|----------------------------------|----------------|----------------------------|--------------|
| 2        | Zweiter Eintrag                  | 555            | "2023-01-02T00:00:00.000Z" | null         |
| 2        | Zweiter Eintrag Änderung         | 555            | "2023-01-04T00:00:00.000Z" | 0            |
| 2        | Zweiter Eintrag weitere Änderung | 234            | "2023-01-07T00:00:00.000Z" | -321         |
*/

-- todo

/*markdown
# Aufgabe 4 - Abfrage des Datenbestandes zu einem bestimmten Zeitpunkt
Der wichtigste Use-Case für die Verwendung einer historischen Tabelle ist die Analyse von Daten in der Vergangenheit. Hierzu ist beispielsweise die Abfrage der Daten zu einem bestimmten Zeitpunkt notwendig. Daher soll im Folgenden der Datenbestand der am `03.01.2023` gueltig war ausgegeben werden.
*/

-- todo
