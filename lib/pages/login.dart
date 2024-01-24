import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psc_119_ss/config.dart';
import 'package:psc_119_ss/pages/dashboard.dart';
import 'package:psc_119_ss/pages/home.dart';
import 'package:psc_119_ss/pages/main_user.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:psc_119_ss/utils/constants.dart';
import 'package:psc_119_ss/utils/helper.dart';
import 'package:psc_119_ss/widgets/app_button.dart';
import 'package:psc_119_ss/widgets/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import '../module/login/login_controller.dart';
import '../widgets/input_controller.dart';

class Login extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController _controller = LoginController();
  bool visibilityPass = false;

  @override
  Widget build(BuildContext context) {
    debugPrint('login page');
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0.0,
                top: -20.0,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    "assets/images/washing_machine_illustration.png",
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  return Home();
                                }));
                              },
                              child: const Icon(
                                Icons.keyboard_backspace_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Masukkan data diri",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height - 180.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Lets make a generic input widget
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nama"),
                                  const SizedBox(height: 5.0),
                                  Container(
                                    height: ScreenUtil().setHeight(48.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: TextFormField(
                                      controller: _controller.nameController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                            Icons.account_circle_outlined),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(74, 77, 84, 0.2),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                        hintText: "Nama anda",
                                        hintStyle: const TextStyle(
                                          fontSize: 14.0,
                                          color: Color.fromRGBO(
                                              105, 108, 121, 0.7),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              SizedBox(
                                height: 25.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("No Telepon"),
                                  const SizedBox(height: 5.0),
                                  Container(
                                    height: ScreenUtil().setHeight(48.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: TextFormField(
                                      controller: _controller.phoneController,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.contact_phone),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(74, 77, 84, 0.2),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                        hintText: "No Telepon / WhatsApp",
                                        hintStyle: const TextStyle(
                                          fontSize: 14.0,
                                          color: Color.fromRGBO(
                                              105, 108, 121, 0.7),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // SizedBox(
                              //   height: 15.0,
                              // ),
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: Text(
                              //     "Forgot Password?",
                              //     textAlign: TextAlign.right,
                              //     style: TextStyle(
                              //       color: Constants.primaryColor,
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: 20.0,
                              ),

                              (!_controller.isLoading)
                                  ? AppButton(
                                      type: ButtonType.PRIMARY,
                                      text: "Mulai",
                                      onPressed: _login,
                                    )
                                  : const SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                        strokeWidth: 3,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _controller.isLoading = true;
    });
    debugPrint('login func');
    // debugPrint(_controller.nameController.text);
    var name = _controller.nameController.text;
    var phone = _controller.phoneController.text;
    print('nama sekarang: ${name}.');
    print('phone sekarang: ${phone}.');
    var url = Uri.parse(
      '${AppConfig.base_url_api}/api/login',
    );
    // // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url, body: {'name': name, 'phone': phone});
    setState(() {
      _controller.isLoading = false;
    });
    print('Request failed with status: ${response.statusCode}.');
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['message'];
      String resToken = jsonResponse['data']['token'];
      String resName = jsonResponse['data']['name'];
      String resPhone = jsonResponse['data']['phone'];
      print('res token sekarang: ${resToken}.');
      print('res resPhone sekarang: ${resName}.');
      print('res resPhone sekarang: ${resPhone}.');
      final prefe = await SharedPreferences.getInstance();
      await prefe.setString('token', resToken);
      await prefe.setString('nama', resName);
      await prefe.setString('phone', resPhone);
      // await prefe.setString('email', jsonResponse['data']['email']);

      print(prefe.getString('token'));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainUser()));
      // }
      print('Number of books about http: $itemCount.');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Terjadi kesalahan")));
      print('Request failed with status: ${response.statusCode}.');
    }

    // var res = _controller.login();
    // MyResponse myResponse = await _controller.login();

    // debugPrint(myResponse.data);
    // if (!myResponse.status) {
    // } else {
  }
}
