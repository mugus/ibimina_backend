const mysql = require("mysql");
// db connection
let db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "ibimina_db",
});

db.connect((err) => {
  if (err) throw err;
  console.log("Db is Connected successfully!");
});

module.exports = db;
