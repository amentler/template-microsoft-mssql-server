/*use rightclick -> open with   to run as a notebook!
config notebook on sql notebook tab:
host: localhost
port: 1433
user: sa
database: master
driver: mssql
*/

SELECT name FROM sys.databases

use master

SELECT
  *
FROM
  master.INFORMATION_SCHEMA.TABLES;





select * from dbo.spt_values