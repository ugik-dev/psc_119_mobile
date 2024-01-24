import 'dart:convert';
// import 'dart:ffi';
import 'package:psc_119_ss/model/user_model.dart';
import 'package:psc_119_ss/module/login/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import '../../model/user_model.dart';

// class Album {
//   // final int userId;
//   // final int id;
//   // final String title;
//   final String error;

//   const Album({required this.error
//       // required this.userId,
//       // required this.id,
//       // required this.title,
//       });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       error: json['error'],
//       // id: json['id'],
//       // title: json['title'],
//     );
//   }
// }

class LoginController {
  bool isLoading = false;
  final LoginRepo _repo = LoginRepo();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  // Future<MyResponse> login() async {
  //   http.Response result =
  //       await _repo.login(nameController.text, phoneController.text);
  //   debugPrint(result.body);
  //   // if (result.statusCode == 200) {
  //   Map<String, dynamic> myBody = jsonDecode(result.body);
  //   // debugPrint(res);
  //   MyResponse<User> myResponse = MyResponse.fromJson(myBody, User.fromJson);
  //   return myResponse;
  // }
}
