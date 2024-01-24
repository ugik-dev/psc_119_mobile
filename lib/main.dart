import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psc_119_ss/module/login/login_controller_two.dart';
import 'package:psc_119_ss/pages/home.dart';
import 'package:psc_119_ss/pages/main_user.dart';
// import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const MainPage(),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool visibilityPass = false;
  final LoginControllerTwo _controller = LoginControllerTwo();
  Future<void> cekToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    debugPrint('token running cek token');
    if (token != null) {
      debugPrint('ada tokne $token');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainUser(),
          ));
    } else {
      debugPrint('tidak ada token');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cekToken(),
        builder: (context, _) {
          return Home();
        });
  }
}
