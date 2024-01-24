import 'package:flutter/material.dart';
import 'package:psc_119_ss/news/list.dart';
import 'package:psc_119_ss/pages/browser_page.dart';
import 'package:psc_119_ss/pages/information_list.dart';
import 'package:psc_119_ss/utils/constants.dart';
import 'package:psc_119_ss/widgets/latest_orders.dart';

import '../../widgets/card_widget.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
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
                                  text: "Informasi",
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
                    minHeight: MediaQuery.of(context).size.height - 150.0,
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
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(height: 7.0),
                            CardWidget(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ListNews();
                                }));
                              },
                              logoPath: "assets/images/washlogo.png",
                              hintText: "Informasi",
                              secText: "",
                              thText:
                                  "Informasi, berita, pengumuman dan artikel",
                            ),
                            SizedBox(height: 7.0),
                            CardWidget(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return InformationList();
                                }));
                              },
                              logoPath: "assets/images/washlogo.png",
                              hintText: "Fasilitas Kesehatan",
                              secText: "",
                              thText: "Cari fasilitas kesehatan terdekat",
                            ),
                            SizedBox(height: 7.0),
                            CardWidget(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const BrowserPage(
                                      title: 'SIDORA',
                                      initialUrl:
                                          'https://sidora.bangka.go.id/');
                                }));
                              },
                              logoPath: "assets/images/blood.png",
                              hintText: "SIDORA",
                              secText: "",
                              thText: "Cari infomasi stok darah",
                            ),
                          ],
                        ),
                      ),
                      // ),
                      // LatestOrders(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
