const router = require("express").Router();
const fs = require("fs");
const generatePassword = require("generate-password");
const csvToJson = require("convert-csv-to-json");
const excel2Json = require("simple-excel-to-json");

const StudentModel = require("../models/student.model");

router.get("/combine-name-password", async (req, res) => {
    try {
        const excelData = excel2Json.parseXls2Json(
            "./user_password_server/data.xlsx"
        )[0];
        const csvData = csvToJson
            .fieldDelimiter(",")
            .getJsonFromCsv("./user_password_server/student.csv");
        const result = csvData.reduce((acc, cur) => {
            for (let student of excelData) {
                if (student.regno == cur.regno) {
                    acc.push({
                        regno: student.regno,
                        name: student.name,
                        password: cur.password,
                    });
                }
            }
            return acc;
        }, []);
        const sortedResult = result.sort((a, b) => a.regno - b.regno);
        for (let student of sortedResult) {
            if (!fs.existsSync("./user_password_server/student_password.csv")) {
                fs.writeFileSync(
                    "./user_password_server/student_password.csv",
                    `${student.regno},${student.password}\n`
                );
            } else {
                fs.appendFileSync(
                    "./user_password_server/student_password.csv",
                    `${student.regno},${student.password}\n`
                );
            }
        }
        res.json({
            message: "Ok",
            count: result.length,
            data: result.sort((a, b) => a.regno - b.regno),
        });
    } catch (err) {}
});

router.get("/get-mysql", async (req, res) => {
    try {
        const jsonData = csvToJson
            .fieldDelimiter(",")
            .getJsonFromCsv("./user_password_server/student.csv");
        for (let student of jsonData) {
            if (!fs.existsSync("./user_password_server/student.sql")) {
                fs.writeFileSync(
                    "./user_password_server/student.sql",
                    `REVOKE ALL PRIVILEGES ON *.* FROM 'cse_${student.regno}'@'localhost';\nDROP DATABASE db_${student.regno};\nCREATE DATABASE db_${student.regno};\nGRANT ALL PRIVILEGES ON db_${student.regno}.* to 'cse_${student.regno}'@'localhost' with grant option;\n`
                );
            } else {
                fs.appendFileSync(
                    "./user_password_server/student.sql",
                    `REVOKE ALL PRIVILEGES ON *.* FROM 'cse_${student.regno}'@'localhost';\nDROP DATABASE db_${student.regno};\nCREATE DATABASE db_${student.regno};\nGRANT ALL PRIVILEGES ON db_${student.regno}.* to 'cse_${student.regno}'@'localhost' with grant option;\n`
                );
            }
        }

        res.json({
            message: "Ok",
            data: jsonData,
        });
    } catch (err) {}
});

router.get("", async (req, res) => {
    try {
        const studentList = await StudentModel.find();
        const _4thSemStudents = studentList.filter(
            (student) => student.semester == 4
        );
        for (let student of _4thSemStudents) {
            if (!fs.existsSync("./user_password_server/student.csv")) {
                fs.writeFileSync(
                    "./user_password_server/student.csv",
                    `${student.regno},${generatePassword.generate({
                        length: 6,
                        exclude: "I",
                        lowercase: true,
                    })}\n`
                );
            } else {
                fs.appendFileSync(
                    "./user_password_server/student.csv",
                    `${student.regno},${generatePassword.generate({
                        length: 6,
                        exclude: "i",
                        lowercase: true,
                    })}\n`
                );
            }
        }
        res.json({
            message: "Ok",
        });
    } catch (err) {}
});

module.exports = router;
