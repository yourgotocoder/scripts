const fs = require('fs');
const csvToJson = require('convert-csv-to-json');
const jsonData = csvToJson
  .fieldDelimiter(",")
  .getJsonFromCsv(__dirname + "/student.csv");
console.log(jsonData);
for (let student of jsonData) {
  if (!fs.existsSync(__dirname + "/student.sql")) {
    fs.writeFileSync(
      __dirname + "/student.sql",
      `REVOKE ALL PRIVILEGES ON *.* FROM 'cse_${student.regno}'@'localhost';\nDROP DATABASE db_${student.regno};\nCREATE DATABASE db_${student.regno};\nGRANT ALL PRIVILEGES ON db_${student.regno}.* to 'cse_${student.regno}'@'localhost' with grant option;\n`
    );
  } else {
    fs.appendFileSync(
      __dirname + "/student.sql",
      `REVOKE ALL PRIVILEGES ON *.* FROM 'cse_${student.regno}'@'localhost';\nDROP DATABASE db_${student.regno};\nCREATE DATABASE db_${student.regno};\nGRANT ALL PRIVILEGES ON db_${student.regno}.* to 'cse_${student.regno}'@'localhost' with grant option;\n`
    );
  }
}


