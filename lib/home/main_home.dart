import 'package:flutter/material.dart';
import 'package:psc_119_ss/colors.dart';
import 'package:psc_119_ss/widgets/button_widget.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20),
        // ignore: sort_child_properties_last
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // width: 100%,
                height: 100,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/favicon.png"))),
              ),
              RichText(
                text: TextSpan(
                    text: "Welcome to",
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "\nPSC 119 Sepintu Sedulang Bangka",
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              ButtonWidget(
                  backgroundColor: AppColors.mainColor,
                  text: 'Login',
                  textColor: Colors.white),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                  backgroundColor: Colors.white,
                  text: 'Register',
                  textColor: AppColors.mainColor)
            ]),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/welcome.jpg"))),
      ),
    );
  }
}
