import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psc_119_ss/config.dart';
import 'package:psc_119_ss/models/reqcall.dart';
import 'package:psc_119_ss/pages/psc/callpage.dart';

class RequestCallWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Model to represent each card

    // Make a list to represent each card
    List<ReqCall> locations = [
      ReqCall(
        address: "Darurat",
        color: Color.fromARGB(255, 255, 59, 59),
        state: "PSC 119",
        imagePath: "assets/images/house2.png",
        ontab: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CallPage(
              title: "Panggilan darurat ke PSC 119",
              imagePath: "assets/images/psc.png",
              urlApi: '${AppConfig.base_url_api}/api/request',
              jenis: '1',
            );
          }));
        },
      ),
      ReqCall(
        address: "Ambulan",
        color: Color.fromARGB(255, 94, 144, 201),
        state: "PSC 119",
        imagePath: "assets/images/ambulance.png",
        ontab: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CallPage(
              title: "Panggilan Ambulance",
              imagePath: "assets/images/psc.png",
              urlApi: '${AppConfig.base_url_api}/api/request',
              jenis: '2',
            );
          }));
        },
      ),
      ReqCall(
        address: "DAMKAR",
        color: Color.fromARGB(255, 27, 170, 180),
        state: "Pemadam Kebakaran",
        imagePath: "assets/images/damkar2.png",
        ontab: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CallPage(
              title: "Panggilan darurat ke PSC 119",
              imagePath: "assets/images/psc.png",
              urlApi: '${AppConfig.base_url_api}/api/request',
              jenis: '4',
            );
          }));
        },
      ),
      ReqCall(
        address: "Bidan",
        color: Color.fromARGB(255, 228, 133, 191),
        state: "Bantuan ibu hamil",
        imagePath: "assets/images/bidan.png",
        ontab: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CallPage(
              title: "Panggilan darurat ke PSC 119",
              imagePath: "assets/images/psc.png",
              urlApi: '${AppConfig.base_url_api}/api/request',
              jenis: '5',
            );
          }));
        },
      ),
      ReqCall(
        address: "Polisi",
        color: Color.fromARGB(255, 245, 189, 36),
        state: "Panggil Kepolisian",
        imagePath: "assets/images/police.png",
        ontab: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CallPage(
              title: "Panggil Kepolisian",
              imagePath: "assets/images/psc.png",
              urlApi: '${AppConfig.base_url_api}/api/request',
              jenis: '3',
            );
          }));
        },
      ),
      ReqCall(
        address: "TAGANA",
        color: Color.fromARGB(255, 245, 189, 36),
        state: "Taruna Siaga Bencana",
        imagePath: "assets/images/tagana.png",
        ontab: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CallPage(
              title: "Panggilan Taruna Siaga Bencana",
              imagePath: "assets/images/psc.png",
              urlApi: '${AppConfig.base_url_api}/api/request',
              jenis: '6',
            );
          }));
        },
      ),
    ];
    return Container(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: locations[index].ontab,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: locations[index].color,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.42),
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
                        fit: BoxFit.cover,
                        height: 80,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w800,
                            height: 1.5,
                            fontSize: 16.0,
                          ),
                          text: "${locations[index].address},\n",
                        ),
                        TextSpan(
                          text: locations[index].state,
                          style: const TextStyle(
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
            height: 15.0,
          );
        },
        itemCount: locations.length,
      ),
    );
  }
}
