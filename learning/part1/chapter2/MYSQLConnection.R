library(RMySQL)
mydb = dbConnect(MySQL(), user='root', password='Backontrack1!', dbname ='learning_r', host='localhost')
dbListTables(mydb)
dbSendQuery(mydb, "USe learning_r;")
dbSendQuery(mydb, "DROP TABLE IF EXISTS books,testTable")
dbSendQuery(mydb, "CREATE TABLE books(bookId INT, title VARCHAR(50), author VARCHAR(50))")
dbSendQuery(mydb, "INSERT INTO books VALUES(1,'My Book', 'I am author')")
df = fetch(dbSendQuery(mydb, "SELECT * FROM books"))
print(df)

dbWriteTable(mydb, name="testTable", value=df, append =TRUE)


