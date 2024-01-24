import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psc_119_ss/config.dart';
import 'package:psc_119_ss/models/location.dart';
import 'package:psc_119_ss/pages/psc/callpage.dart';

class LocationSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Model to represent each card

    // Make a list to represent each card
    List<Location> locations = [
      Location(
          address: "Darurat",
          color: Color.fromARGB(255, 201, 104, 97),
          state: "PSC 119",
          imagePath: "assets/images/house2.png",
          tabRoute: (() {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const CallPage(
                title: "Panggilan darurat ke PSC 119",
                imagePath: "assets/images/psc.png",
                urlApi: '${AppConfig.base_url_api}/api/request',
                jenis: '1',
              );
            }));
          })),
      Location(
          address: "Ambulan",
          color: Color.fromRGBO(89, 69, 199, 1),
          state: "PSC 119",
          imagePath: "assets/images/ambulance.png",
          tabRoute: (() {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const CallPage(
                title: "Panggilan ambulan dari PSC 119",
                imagePath: "assets/images/ambulance.png",
                urlApi: '${AppConfig.base_url_api}/api/request',
                jenis: '2',
              );
            }));
          })),
      Location(
          address: "Damkar",
          color: Color.fromRGBO(237, 116, 41, 1),
          state: "Pemadam\nKebakaran",
          imagePath: "assets/images/damkar.png",
          tabRoute: (() {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const CallPage(
                title: "Panggilan Damkar",
                imagePath: "assets/images/damkar.png",
                urlApi: '${AppConfig.base_url_api}/api/request',
                jenis: '4',
              );
            }));
          })),
    ];
    return Container(
      // height: ScreenUtil().setHeight(90.0),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              locations[index].tabRoute();
            },
            child: Container(
              width: ScreenUtil().setWidth(200.0),
              decoration: BoxDecoration(
                color: locations[index].color,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(169, 176, 185, 0.42),
                    spreadRadius: 0,
                    blurRadius: 8.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 12.0,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: -16.0,
                    top: 0.0,
                    child: Opacity(
                      opacity: 0.69,
                      child: Image.asset(
                        locations[index].imagePath,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${locations[index].address},\n",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: locations[index].state,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 15.0,
          );
        },
        itemCount: locations.length,
      ),
    );
  }
}
