import 'package:flutter/material.dart';
import '../api.dart';
import 'Main_Page.dart';

class EditCourse extends StatefulWidget {
  // const EditCourse({super.key});
  final String id,
      courseInstructor,
      courseCredits,
      courseID,
      courseName,
      dateEntered;

  final GetAllCoursesApi api = GetAllCoursesApi();

  EditCourse(this.id, this.courseInstructor, this.courseCredits, this.courseID,
      this.courseName, this.dateEntered);

  //_EditCourseState createState() => _EditCourseState(
  //   id, courseInstructor, courseCredits, courseID, courseName, dateEntered);

  @override
  State<EditCourse> createState() => _EditCourseState(
      id, courseInstructor, courseCredits, courseID, courseName, dateEntered);
}

class _EditCourseState extends State<EditCourse> {
  final String id,
      courseInstructor,
      courseCredits,
      courseID,
      courseName,
      dateEntered;

  _EditCourseState(this.id, this.courseInstructor, this.courseCredits,
      this.courseID, this.courseName, this.dateEntered);

  void _changeCourseInstructor(courseName, courseInstructor) {
    setState(() {
      widget.api.editCourseByCourseName(courseName, courseInstructor);
    });
  }

  TextEditingController courseInstructorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Instructor Name: ' + widget.courseInstructor),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: courseInstructorController,
                      ),
                      ElevatedButton(
                          onPressed: () => {
                                // null,
                                _changeCourseInstructor(widget.courseInstructor,
                                    courseInstructorController.text),
                              },
                          child: Text('Change Data')),
                    ],
                  ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.home),
            onPressed: () => {
                  Navigator.pop(context),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Main_Page())),
                }));
  }
}


/*
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('We are here!' + widget.courseID),
    );
  }

  */
