const mongoose = require("mongoose");

const MinorSpecialization = mongoose.Schema(
    {
        option1: String,
        option2: String,
        option3: String,
        option4: String,
    },
    { _id: false }
);

const StudentSchema = mongoose.Schema({
    regno: {
        type: Number,
        required: true,
    },
    name: String,
    password: String,
    email: String,
    cgpa: Number,
    backlog: Boolean,
    minor_specialization_selection: MinorSpecialization,
    dateOfRegistrationMinorSpecialization: String,
    minor_specialization: String,
    minor_specialization_dropped: Boolean,
    semester: Number,
    section: String,
    mobile: Number,
    open_elective_history: {
        open_elective1: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
    },
    elective_history: {
        elective1: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
        elective2: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
        elective3: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
    },
    minor_specialization_history: {
        _4thSem: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
        _5thSemSubject1: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
        _5thSemSubject2: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
        _6thSemSubject1: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
        _6thSemSubject2: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
        _7thSemSubject1: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
        _7thSemSubject2: {
            subject: String,
            subjectCode: String,
            statusFinished: Boolean,
        },
    },
    _4thSemElectiveSelection: {
        elective1: {
            option1: { subject: String, subjectCode: String },
            option2: { subject: String, subjectCode: String },
        },
        elective2: {
            option1: { subject: String, subjectCode: String },
            option2: { subject: String, subjectCode: String },
            option3: { subject: String, subjectCode: String },
            option4: { subject: String, subjectCode: String },
        },
    },
    _6thSemOptions: {
        elective5: [{ subject: String, subjectCode: String }],
        elective6: [{ subject: String, subjectCode: String }],
    },
    _6thSemElectiveSelection: {
        elective5: {
            option1: { subject: String, subjectCode: String },
            option2: { subject: String, subjectCode: String },
            option3: { subject: String, subjectCode: String },
            option4: { subject: String, subjectCode: String },
            option5: { subject: String, subjectCode: String },
        },
        elective6: {
            option1: { subject: String, subjectCode: String },
            option2: { subject: String, subjectCode: String },
            option3: { subject: String, subjectCode: String },
            option4: { subject: String, subjectCode: String },
            option5: { subject: String, subjectCode: String },
        },
    },
});

// StudentSchema.plugin(uniqueValidator);

module.exports = mongoose.model(
    "minor-specialization",
    StudentSchema,
    "minor-specialization-data"
);
