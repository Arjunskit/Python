#pip install mysql-connector-python

import mysql.connector

try:
    connection = mysql.connector.connect(
        host= "localhost",
        user= "root",
        password= "1234",
        database= "airlineDB"
    )

    print("Connected Successfully!")

    cursor = connection.cursor()

    query = ""
    cursor.execute(query)

    rows = cursor.fetchall()

    for row in rows:
        print(row)

except mysql.connector.Error as err:
    print("Error: ", err)

finally:
    if 'connection' in locals() and connection.is_connected():
        connection.close()
        print("Connection Closed!")
