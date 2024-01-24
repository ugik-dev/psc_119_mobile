import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psc_119_ss/models/order.dart';
import 'package:psc_119_ss/pages/mitra/menu_tambang.dart';
import 'package:psc_119_ss/pages/profil.dart';
import 'package:psc_119_ss/utils/constants.dart';
import 'package:psc_119_ss/widgets/latest_orders.dart';
import 'package:psc_119_ss/widgets/location_slider.dart';
import 'package:psc_119_ss/widgets/navigation_widget.dart';

import 'package:psc_119_ss/pages/carwash/neworder.dart';
import 'package:psc_119_ss/pages/mitra/register_tambang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/card_widget.dart';
import 'package:http/http.dart' as http;

class CarwashDash extends StatefulWidget {
  @override
  _CarwashDashState createState() => _CarwashDashState();
}

class _CarwashDashState extends State<CarwashDash> {
  // Track active index
  int activeIndex = 0;
  var stCekOrderan = false;
  String statusTambang = 'Loading ..';
  String statusRentalMobil = 'Loading ..';
  late List<Map<String, dynamic>> orderAktif = [
    // {"id": 1, "name": "HTML and CSS", "price": 150},
    // {"id": 2, "name": "Python", "price": 250},
    // {"id": 3, "name": "Dart", "price": 120},
    // {"id": 4, "name": "Java", "price": 100},
    // {"id": 5, "name": "JavaScript", "price": 110},
    // {"id": 6, "name": "Swift", "price": 90},
    // {"id": 7, "name": "C++", "price": 85},
    // {"id": 8, "name": "C#", "price": 58},
    // {"id": 9, "name": "Python", "price": 120},
    // {"id": 10, "name": "Ruby", "price": 55},
    // {"id": 11, "name": "FrameWork", "price": 125}
  ];
  // var orderAktif;
  var linkTambang;

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cekOrder(),
        builder: (context, _) {
          return Stack(
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
                      SizedBox(
                        height: kToolbarHeight,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "CarWash",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                                // Image.asset(
                                //   "assets/images/dp.png",
                                // )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 200.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          color: Constants.scaffoldBackgroundColor,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 24.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Text(
                                "",
                                style: TextStyle(
                                  color: Color.fromRGBO(19, 22, 33, 1),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            // SizedBox(height: 7.0),
                            // Container(
                            //   padding: EdgeInsets.all(20),
                            //   child: Column(
                            //     children: [
                            //       ListView.builder(
                            //         shrinkWrap: true,
                            //         padding: const EdgeInsets.all(8),
                            //         itemCount: orderAktif.length,
                            //         itemBuilder:
                            //             (BuildContext context, int index) {
                            //           return CardWidget(
                            //               logoPath:
                            //                   "assets/images/washlogo.png",
                            //               hintText: "Riwayat Order",
                            //               secText: ''
                            //               // "Anda Belum terdaftar sebagai \nmitra tambang\n",
                            //               // thText: "Klik untuk mendaftar",
                            //               );
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Container(
                              padding: EdgeInsets.all(20),
                              // height: Scree
                              // nUtil().setHeight(100.0),
                              // child: Center(
                              // lets make a widget for the cards
                              // child: LocationSlider(),
                              child: Column(
                                children: [
                                  // ListView.builder(
                                  //     itemCount: orderAktif.length,
                                  //     itemBuilder: (BuildContext, int index) {
                                  //       // return new ListTile(
                                  //       //   title: Container(
                                  //       //     padding: new EdgeInsets.all(10),
                                  //       //     decoration: BoxDecoration(
                                  //       //         border: Border.all(
                                  //       //             color: Colors.teal)),
                                  //       //   ),
                                  //       // );
                                  //       return new Flexible(
                                  //           child: const CardWidget(
                                  //               // onTap: () {
                                  //               //   Navigator.push(context,
                                  //               //       MaterialPageRoute(
                                  //               //           builder: (context) {
                                  //               //     return linkTambang;
                                  //               //   }));
                                  //               // },
                                  //               logoPath:
                                  //                   "assets/images/washlogo.png",
                                  //               hintText: "Tambang",
                                  //               secText: ''));
                                  //     }),
                                  // // return new ListTile(
                                  // //   title: Container(
                                  // //       child: new Text('order')),
                                  // // );
                                  // // });,
                                  // stCekOrderan != true
                                  //     ? CardWidget(
                                  //         onTap: () {
                                  //           Navigator.push(context,
                                  //               MaterialPageRoute(
                                  //                   builder: (context) {
                                  //             return linkTambang;
                                  //           }));
                                  //         },
                                  //         logoPath:
                                  //             "assets/images/washlogo.png",
                                  //         hintText: "Riwayat Order",
                                  //         secText: ''
                                  //         // "Anda Belum terdaftar sebagai \nmitra tambang\n",
                                  //         // thText: "Klik untuk mendaftar",
                                  //         )
                                  //     : GestureDetector(
                                  //         // onTap: onTap,
                                  //         child: Container(
                                  //             decoration: BoxDecoration(
                                  //               color: Colors.white,
                                  //               borderRadius:
                                  //                   BorderRadius.circular(8.0),
                                  //             ),
                                  //             padding:
                                  //                 const EdgeInsets.all(16.0),
                                  //             height:
                                  //                 ScreenUtil().setHeight(147.0),
                                  //             child: Column(children: [
                                  //               Container(
                                  //                   decoration: BoxDecoration(
                                  //                     color: Colors.white,
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(
                                  //                             8.0),
                                  //                   ),
                                  //                   child: Column(
                                  //                       crossAxisAlignment:
                                  //                           CrossAxisAlignment
                                  //                               .stretch,
                                  //                       children: [
                                  //                         Text(
                                  //                           "Antrian yang sedang berjalan",
                                  //                           style: Theme.of(
                                  //                                   context)
                                  //                               .textTheme
                                  //                               .headline6
                                  //                               ?.copyWith(
                                  //                                 color: Color
                                  //                                     .fromRGBO(
                                  //                                         74,
                                  //                                         77,
                                  //                                         84,
                                  //                                         1),
                                  //                                 fontSize:
                                  //                                     16.0,
                                  //                                 fontWeight:
                                  //                                     FontWeight
                                  //                                         .w800,
                                  //                               ),
                                  //                         ),
                                  //                         SizedBox(
                                  //                           height: 5.0,
                                  //                         ),
                                  //                       ])),
                                  //               Center(
                                  //                 child: Column(
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment
                                  //                           .center,
                                  //                   children: [
                                  //                     SizedBox(
                                  //                       height: 5.0,
                                  //                     ),
                                  //                     SizedBox(
                                  //                       child:
                                  //                           CircularProgressIndicator(),
                                  //                       height: 50.0,
                                  //                       width: 50.0,
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ])),
                                  //       ),
                                  // GestureDetector(
                                  //     child: Container(
                                  //       padding: const EdgeInsets.all(16.0),
                                  //       height:
                                  //           ScreenUtil().setHeight(147.0),
                                  //       // width:
                                  //       //     MediaQuery.of(context).size.width,
                                  //       decoration: BoxDecoration(
                                  //         color: Colors.white,
                                  //         borderRadius:
                                  //             BorderRadius.circular(8.0),
                                  //       ),
                                  //       child: const SizedBox(
                                  //         height: 50.0,
                                  //         width: 0.0,
                                  //         child: CircularProgressIndicator(
                                  //           color: Colors.blue,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  SizedBox(height: 7.0),
                                  CardWidget(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CarWashNewOrder();
                                      }));
                                    },
                                    logoPath: "assets/images/washlogo.png",
                                    hintText: "Order Baru",
                                    secText: "",
                                    thText: "Klik untuk mendaftar",
                                  ),
                                ],
                              ),
                            ),
                            // ),
                            LatestOrders(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> cekOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    // print(token.toString());
    // print('cekmitra pocess');
    print('func CekKemitraan');

    final response = await http.get(
      Uri.parse(
        "http://127.0.0.1:8000/store/api/CarWash/cek",
      ),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'X-API-KEY': 'psc_119_ss_apps',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final String res = response.body;
      Map<String, dynamic> myBody = jsonDecode(response.body);

      print('cekOrder');
      print(token.toString());
      print(myBody['data']);
      myBody.forEach((key, value) {
        print(value['req_time']);
      });
      print('data 1');
      late List<Map<String, dynamic>> _itemstmp =
          new List<Map<String, dynamic>>.from(myBody['data']);

      print('data 2');
      setState(() {
        orderAktif = _itemstmp;
      });
      print('data 2');
      if (!stCekOrderan) {
        if (myBody['status']) {
          // print('data s');
          if (myBody['data'] == null) {
            // print('data null');
            setState(() {
              stCekOrderan = true;
              statusTambang =
                  'Anda Belum terdaftar sebagai \nmitra tambang\nklik untuk mendaftar';
            });
          } else {
            print('data tdk null');
            if (myBody['data']['file_pengaju'] == '') {
              // print('Data sedang diverifikasi');
              setState(() {
                stCekOrderan = true;
                statusTambang = "Belum Upload SWA FOTO";
              });
            } else if (myBody['data']['status'] == '0') {
              // print('Data sedang diverifikasi');
              setState(() {
                stCekOrderan = true;
                statusTambang = "Data sedang diverifikasi";
                linkTambang = RegisterTambang();
              });
            } else if (myBody['data']['status'] == '1') {
              print('Klik untuk membuka menu');
              setState(() {
                stCekOrderan = true;
                statusTambang = 'Anda sudah terdaftar sebagai mitra';
                linkTambang = MenuTambang();
              });
              // print('Anda sudah terdaftar sebagai mitra');
            }
          }
        } else {
          print('3');
          setState(() {
            stCekOrderan = true;
            statusTambang =
                'Anda Belum terdaftar sebagai \nmitra tambang\nklik untuk mendaftar';
          });
        }
      }
      // stCekOrderan = true;
      print('55');
      print(statusTambang);

      // print(res.data.message);
    }
  }
}

class ResKemitraan {
  // int id_user;
  int id;
  String nama;
  int status;
  // String token;

  // User({this.id = 0, this.name = "", this.email = "", this.token = ""});
  ResKemitraan({this.id = 0, this.status = 0, this.nama = ""});
  factory ResKemitraan.fromJson(Map<String, dynamic> json) {
    return ResKemitraan(
      // id_user: json['id_user'],
      nama: json['nama'],
      id: json['id'],
      status: json['status'],
    );
  }
}
