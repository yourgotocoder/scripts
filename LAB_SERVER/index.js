const express = require("express");
const mongoose = require("mongoose");
const json2Xls = require("json2xls");

const getStudentDataRouter = require("./routes/getStudentData.router");

const app = express();
const PORT = 3000;

app.use(express.json());
app.use(json2Xls.middleware);

app.use("/student-data", getStudentDataRouter);

mongoose
    .connect(
        `mongodb+srv://primary:StudentProfiling2021@cluster0.i5fq9.mongodb.net/elective?retryWrites=true&w=majority`
    )
    .then(() => {
        console.log(`Successfully connected to database`);
        return app.listen(PORT);
    })
    .then(() => {
        console.log(`Server started on port: ${PORT}`);
    });
