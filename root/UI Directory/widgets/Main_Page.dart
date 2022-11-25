import 'package:flutter/material.dart';
import 'Page_2.dart';
import 'editCourses.dart';

// ***************************
import '../api.dart';

class Main_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jensen_Assignment_8',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jensen_Assignment_8'),
        ),
        body: Group3Widget(),
      ),
    );
  }
}

class Group3Widget extends StatefulWidget {
  // const Main_Page({super.key});

  // ***************************************************8
  final GetAllCoursesApi api = GetAllCoursesApi();

  @override
  _Group3WidgetState createState() => _Group3WidgetState();
}

// state class
class _Group3WidgetState extends State<Group3Widget> {
  // *******************************************
  List courses = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getCourses().then((data) {
      setState(() {
        courses = data;
        _dbLoaded = true;
      });
    });
  }
  // ********************************************

  TextEditingController inputText = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputText.dispose();
    super.dispose();
  }

  // state variable

  String _textString = '';
  String _textString3 = 'Enter Data and Hit Enter!';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(padding: EdgeInsets.fromLTRB(350.0, 0.0, 50.0, 0.0)),
      Text(
        _textString,
        style: TextStyle(fontSize: 30),
      ),
      /*
      TextField(
        controller: inputText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter a search termyy',
        ),
      ),
      */

      //ElevatedButton(onPressed: () =>

      //  print(courses),

      //), child: Text('Press Me')),

      // ********************************************

      /*
      ElevatedButton(
          child: const Text('Display Courses'),
          onPressed: () => {
                print(courses),
                // _textString3 = inputText.text;
                // FocusScope.of(context).unfocus();
                // Text(inputText.text),
              }),
      //Text(
      //  _textString3,
      //  style: TextStyle(fontSize: 30),
      //),


      */

      // *********************************************

      /*
      ElevatedButton(
          child: const Text('Display Inputted Stringy'),
          onPressed: () {
            print(inputText.text);
            _textString3 = inputText.text;
            FocusScope.of(context).unfocus();
            // Text(inputText.text),
          }),
      Text(
        _textString3,
        style: TextStyle(fontSize: 30),
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[900], // Background color
          ),
          child: const Text('GOTO Page 2'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Page2()),
            );
          }),
          */

      _dbLoaded
          ? Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(15.0),
                  children: [
                    ...courses
                        .map<Widget>(
                          (course) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: TextButton(
                              onPressed: () => {
                                Navigator.pop(context),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditCourse(
                                            course['_id'],
                                            course['courseInstructor'],
                                            course['courseCredits'],
                                            course['courseID'],
                                            course['courseName'],
                                            course['dateEntered']))),
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: Text(course['courseName']),
                                ),
                                title: Text(
                                  (course['courseID'] +
                                      " \$" +
                                      course['courseInstructor']),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ]),
            )
          : Column(
              children: <Widget>[
                Text(
                  "Database Loading",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                CircularProgressIndicator(),
              ],
            )
    ]);
  }
}








/*

Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  TextButton(
                      onPressed: () => {
                            print(courses),
                          },
                      child: Text('Press Meeeee'))
                ]
                )

*/
