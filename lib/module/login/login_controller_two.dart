import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:psc_119_ss/model/user_model.dart';
import 'package:psc_119_ss/module/login/login_repo.dart';
import 'dart:convert' as convert;

class LoginControllerTwo {
  bool isLoading = false;
  final LoginRepo _repo = LoginRepo();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  Future<void> login() async {
    try {
      var url = Uri.http('127.0.0.1:8000', '/api/login');

      var response = await http.post(url, body: {'name': 'sad', 'phone': '08'});
      print(response.statusCode);

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        var itemCount = jsonResponse['message'];
        print('disini dari login controller: $itemCount.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error during book fetching: $error');
    }
  }
}
