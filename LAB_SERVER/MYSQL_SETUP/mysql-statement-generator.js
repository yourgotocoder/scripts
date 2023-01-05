const parser = require("simple-excel-to-json");
const fs = require("fs");

const data = parser.parseXls2Json(__dirname + "/4thSemPasscode.xlsx")[0];

for (let student of data) {
  fs.appendFileSync(
    __dirname + "/student.sql",
    `CREATE DATABASE db_${student.REGNO};
    GRANT ALL PRIVILEGES ON db_${student.REGNO}.* to 'cse_${student.REGNO}'@'localhost' with grant option;`
  );
}
