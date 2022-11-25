import 'package:http/http.dart';
import 'package:dio/dio.dart';

import './Models/Course.dart';

// const String localhost = "http://localhost:1200/";
// const String localhost = "http://192.168.56.1:1200";
const String localhost = "http://10.0.2.2:1200";

class GetAllCoursesApi {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getCourses() async {
    final response = await _dio.get('/getAllCourses');
    return response.data['courses'];
  }

  Future editCourseByCourseName(
      String courseName, String courseInstructor) async {
    final response = await _dio.post('/editCourseByCourseName',
        data: {'courseName': courseName, 'courseInstructor': courseInstructor});
    // return response.data;
  }

  //Future<List> getCourses() async {
  //  final response = await _dio.get('http://localhost:1200/getAllCourses');
  //  return response.data['courses'];
  //}
}

/*
  void httpRequest() async {
      var response = await http.get(Uri.parse('https://localhost:1200'));
      print(response.body);
      print(response.statusCode);
    }
    */
