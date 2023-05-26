import pyodbc 

cnxn = pyodbc.connect("DRIVER={ODBC Driver 18 for SQL Server};SERVER=localhost;DATABASE=master;ENCRYPT=yes;UID=sa;PWD=TeSt1234;TrustServerCertificate=yes;")
cursor = cnxn.cursor()

cursor.execute("SELECT name FROM sys.databases")
result = cursor.fetchall()
print(result)