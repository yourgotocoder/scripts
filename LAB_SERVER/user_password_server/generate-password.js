const password = require("generate-password");
const excelParser = require("simple-excel-to-json");
const fs = require("fs");

const data = excelParser.parseXls2Json(__dirname + "/CSE 2022 Batch.xlsx")[0];
const passwordJsonData = data.map((student) => ({
  REGNO: student.REGNO,
  PASSWORD: password.generate({ length: 6, excludeSimilarCharacters: true }),
}));

for (let [index, student] of passwordJsonData.entries()) {
  const toWrite = `${student.REGNO},${student.PASSWORD}\n`;
  index === 0 && fs.writeFileSync("CSE_2022.csv", toWrite);
  index !== 0 && fs.appendFileSync("CSE_2022.csv", toWrite);
}
