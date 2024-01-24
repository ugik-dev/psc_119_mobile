import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:psc_119_ss/pages/home.dart';
import 'package:psc_119_ss/utils/constants.dart';

class NavigationImaWidget extends StatelessWidget {
  final int activeIndex;
  // final String text;
  // final Color textColor;
  const NavigationImaWidget(int i, {this.activeIndex = 0});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Constants.scaffoldBackgroundColor,
      buttonBackgroundColor: Constants.primaryColor,
      items: [
        IconButton(
          icon: Icon(
            Icons.home,
            size: 30.0,
            color: activeIndex == 0 ? Colors.white : Color(0xFFC8C9CB),
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return Home();
            }));
          },
        ),
        Icon(
          Icons.local_car_wash,
          size: 30.0,
          color: activeIndex == 1 ? Colors.white : Color(0xFFC8C9CB),
        ),
        Icon(
          Icons.phone,
          size: 30.0,
          color: activeIndex == 2 ? Colors.white : Color(0xFFC8C9CB),
        ),
        Icon(
          Icons.chat,
          size: 30.0,
          color: activeIndex == 3 ? Colors.white : Color(0xFFC8C9CB),
        ),
        Icon(
          Icons.person,
          size: 30.0,
          color: activeIndex == 4 ? Colors.white : Color(0xFFC8C9CB),
        ),
      ],
      // onTap: (index) {
      //   setState(() {
      //     activeIndex = index;
      //   });
      // },
    );
  }
}
