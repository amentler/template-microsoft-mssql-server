import pyodbc 

server = 'tcp:localhost' 
database = 'master' 
username = 'sa' 
password = 'TeSt1234' 
# ENCRYPT defaults to yes starting in ODBC Driver 18. It's good to always specify ENCRYPT=yes on the client side to avoid MITM attacks.
cnxn = pyodbc.connect('DRIVER={ODBC Driver 18 for SQL Server};SERVER='+server+';DATABASE='+database+';ENCRYPT=yes;UID='+username+';PWD='+ password+";TrustServerCertificate=yes;")
cursor = cnxn.cursor()

cursor.execute("SELECT name FROM sys. databases")
result = cursor.fetchall()
print(result)