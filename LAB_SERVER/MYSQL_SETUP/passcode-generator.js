const parser = require("simple-excel-to-json");
const generatePassword = require("generate-password");
const json2xls = require("json2xls");
const fs = require("fs");

const data = parser.parseXls2Json(__dirname + "/4thRegno.xlsx")[0];

const regnoOnly = data.map((studentData) => ({
  REGNO: studentData.Regno,
  PASSCODE: generatePassword.generate({
    length: 6,
    excludeSimilarCharacters: true,
  }),
}));

const xlsData = json2xls(regnoOnly);

fs.writeFileSync("4thSemPasscode.xlsx", xlsData, "binary");
