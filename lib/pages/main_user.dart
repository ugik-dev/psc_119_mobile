// ignore_for_file: avoid_print

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:psc_119_ss/pages/information.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:psc_119_ss/pages//psc/req_call.dart';
import 'package:psc_119_ss/user/profile.dart';
import 'package:psc_119_ss/pages/dashboard.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class MainUser extends StatefulWidget {
  const MainUser({Key? key}) : super(key: key);
  @override
  State<MainUser> createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  int currentPage = 0;
  List<Widget> pages = [
    Dashboard(),
    const Information(),
    RequestCall(),
    Dashboard(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([cekToken(), _checkAndRequestPermission()]),
        builder: (context, _) {
          return Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Constants.scaffoldBackgroundColor,
                buttonBackgroundColor: Constants.primaryColor,
                items: [
                  Icon(
                    Icons.home,
                    size: 30.0,
                    color: currentPage == 0
                        ? Colors.white
                        : const Color(0xFFC8C9CB),
                  ),
                  Icon(
                    Icons.newspaper,
                    size: 30.0,
                    color: (currentPage == 1 || currentPage == 3)
                        ? Colors.white
                        : const Color(0xFFC8C9CB),
                  ),
                  Icon(
                    Icons.phone,
                    size: 30.0,
                    color: currentPage == 2
                        ? Colors.white
                        : const Color(0xFFC8C9CB),
                  ),
                  Icon(
                    Icons.chat_outlined,
                    size: 30.0,
                    color: currentPage == 3
                        ? Colors.white
                        : const Color(0xFFC8C9CB),
                  ),
                  Icon(
                    Icons.person,
                    size: 30.0,
                    color: currentPage == 4
                        ? Colors.white
                        : const Color(0xFFC8C9CB),
                  ),
                ],
                onTap: (index) {
                  if (index == 3) {
                    try {
                      launchWhatsApp();
                    } catch (e) {
                      print('Error launching WhatsApp: $e');
                    }
                  } else {
                    setState(() {
                      currentPage = index;
                    });
                  }
                },
              ),
              // backgroundColor: Constants.primaryColor,
              backgroundColor: Constants.primaryColor,
              body: pages[currentPage]);
        });
  }

  Future<void> cekToken() async {
    // final prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString('token');
  }

  Future<bool> _checkAndRequestPermission() async {
    if (await Permission.locationWhenInUse.request().isGranted) {
      return true; // Permission is granted
    } else {
      return false; // Permission is not granted
    }
  }

  void main() async {
    bool hasPermission = await _checkAndRequestPermission();

    if (hasPermission) {
      // Perform actions that require location access
      print("Location permission granted");
    } else {
      // Handle the case where permission is not granted
      print("Location permission not granted");
    }
  }

  void launchWhatsApp() async {
    String url = "https://wa.me/08127199119?text=Hallo";
    try {
      // ignore: deprecated_member_use
      await launch(url, forceWebView: false);
    } catch (e) {
      print('Error launching WhatsApp: $e');
      // Handle the error as needed
    }
  }
}
