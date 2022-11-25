// add requirements
const express = require('express');
const app = express();
const nodemon = require('nodemon');
app.use(express.json());

// Mongoose package (new this week)
const mongoose = require('mongoose');

// set port to 1200 per assignment instructions
const PORT = 1200;

// MongoDB connection string pointing to db named 'G3A4'
const dbURL = "mongodb+srv://admin:Underling999@cluster0.zkxltog.mongodb.net/G3A4";

// connect to MongoDB
mongoose.connect(dbURL,
    {
        useNewURLParser: true,
        useUnifiedTopology: true
    });

// Mongoose connection
const db = mongoose.connection;

// Handle DB error, display connection
db.on('error', () => {
    console.error.bind(console, 'connection error: ');
});
db.once('open', () => {
    console.log('MongoDB Connected');
});

// Schema model declaration
require('./Models/Student');
require('./Models/Course');

const Student = mongoose.model('Student');
const Course = mongoose.model('Course');

// index route; proves server connection is up and running and Postman works
app.get('/', (req, res) => {
    return res.status(200).json("(message: OK)");
});

// ##############################################################################
// The ADD_STUDENT route contoller
// ##############################################################################
app.post('/addStudent', async (req, res) => {
    try {
        let student = {
            fname: req.body.fname,
            lname: req.body.lname,
            studentID: req.body.studentID,
            dateEntered: req.body.dateEntered
        }
        await Student(student).save().then(e => {
            return res.status(201).json('Student Added');
        })

    } catch {
        return res.status(500).json('message: failed to add student -- bad data');
    }
});

// ##############################################################################
// The GET_ALL_STUDENTS route contoller
// ##############################################################################
app.get('/getAllStudents', async (req, res) => {
    try {
        let students = await Student.find({}).lean();
        return res.status(200).json(students);
    } catch {
        return res.status(500).json('message: failed to get students');
    }
});

// ##############################################################################
// The FIND_STUDENT route contoller
// ##############################################################################
app.post('/findStudent', async (req, res) => {
    try {
    let oneStudent = {
        lname: req.body.lname
        }
    var result = await Student.findOne({ lname: oneStudent.lname });
    return res.status(200).json(result);
    } catch {
        return res.status(500).json('message: failed to find student match');
    }
});

// ##############################################################################
// The ADD_COURSE route contoller
// ##############################################################################
app.post('/addCourse', async (req, res) => {
    try {
        let course = {
            courseInstructor: req.body.courseInstructor,
            courseCredits: req.body.courseCredits,
            courseID: req.body.courseID,
            courseName: req.body.courseName,
            dateEntered: req.body.dateEntered
        }
        await Course(course).save().then(e => {
            return res.status(201).json('Course Added');
        })

    } catch {
        return res.status(500).json('message: failed to add course -- bad data');
    }
});

// ##############################################################################
// The GET_ALL_COURSES route contoller
// ##############################################################################

app.get('/getAllCourses', async (req, res) => {
    try {
        let courses = await Course.find({}).lean();
        // return res.status(200).json(courses);
        return res.status(200).json({'courses': courses});
    } catch {
        return res.status(500).json('message: failed to get courses');
    }
});

// ##############################################################################
// The FIND_COURSE route contoller
// ##############################################################################
app.post('/findCourse', async (req, res) => {
    try {
    let oneCourse = {
        courseID: req.body.courseID
        }
        var result = await Course.findOne({ courseID: oneCourse.courseID });
        return res.status(200).json(result);
    } catch {
        return res.status(500).json('message: failed to find course match');
    }
});


// ##############################################################################
// The EDIT_STUDENT_BY_ID route contoller
// ##############################################################################

app.post('/editStudentById', async (req, res) => {
    try {
        var student = await Student.updateOne({_id: req.body._id}
        , {
            fname: req.body.fname
        }, {upsert: true});
        if(student)
        {
            res.status(200).json('message: Student Edited');
        }
        else {
            res.status(200).json('message: No Student Changed');
        }

    } catch {
        return res.status(500).json('message: failed to edit student');
    }
});


// ##############################################################################
// The EDIT_STUDENT_BY_FNAME route contoller
// ##############################################################################

app.post('/editStudentByFname', async (req, res) => {
    try {
        var student = await Student.updateOne({fname: req.body.queryFname}
        , {
            fname: req.body.fname,
            lname: req.body.lname
        }, {upsert: true});
        if(student)
        {
            res.status(200).json('message: Student Name Edited');
        }
        else {
            res.status(200).json('message: No Student Name Changed');
        }

    } catch {
        return res.status(500).json('message: failed to edit student name');
    }
});


// ##############################################################################
// The EDIT_COURSE_BY_COURSE_NAME route contoller
// ##############################################################################

app.post('/editCourseByCourseName', async (req, res) => {
    try {
        var course = await Course.updateOne({courseName: req.body.courseName}
        , {
            courseInstructor: req.body.courseInstructor
        }, {upsert: true});
        if(course)
        {
            res.status(200).json('message: Course Edited');
        }
        else {
            res.status(200).json('message: No Course Changed');
        }

    } catch {
        return res.status(500).json('message: failed to edit course');
    }
});


// ##############################################################################
// The DELETE_COURSE_BY_ID route contoller
// ##############################################################################

app.post('/deleteCourseById', async (req, res) => {
    try {
        var course = await Course.findOne({_id: req.body._id});

        if(course)
        {
            await Course.deleteOne({_id: req.body._id});
            res.status(200).json('message: Course Deleted.');
        }
        else {
            res.status(200).json('message: No Course object found with that ID');
        }

    } catch {
        return res.status(500).json('message: failed to delete course');
    }
});


// ##############################################################################
// The REMOVE_STUDENT_FROM_CLASSES route contoller
// ##############################################################################

app.post('/removeStudentFromClasses', async (req, res) => {
    try {
        var student = await Student.findOne({studentID: req.body.studentID});

        if(student)
        {
            await Student.deleteOne({studentID: req.body.studentID});
            res.status(200).json('message: Student Deleted from all Courses.');
        }
        else {
            res.status(200).json('message: No Student found with that ID');
        }

    } catch {
        return res.status(500).json('message: failed to delete student from courses.');
    }
});


// listening in on port 1200 for any activity -- SSSSHHHHHHH!!!!
app.listen(PORT, () => {
    console.log(`Server started on port ${PORT}`);
});


