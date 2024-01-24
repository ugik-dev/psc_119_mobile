import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psc_119_ss/news/list.dart';
import 'package:psc_119_ss/pages/information_list.dart';
import 'package:psc_119_ss/utils/constants.dart';
import 'package:psc_119_ss/widgets/card_widget.dart';
import 'package:psc_119_ss/widgets/location_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Track active index
  String nama = 'GUEST';
  Future<void> cekToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? namas = prefs.getString('nama');
    final String? phones = prefs.getString('phone');
    debugPrint(namas);
    nama = namas!;
  }

  int activeIndex = 0;
  // final prefe = await SharedPreferences.getInstance();
  // final nama = prefe.getString('nama');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cekToken(),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Selamat datang,\n",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      TextSpan(
                                        text: nama,
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
                                Image.asset(
                                  "assets/images/dp.png",
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
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
                                "Darurat",
                                style: TextStyle(
                                  color: Color.fromRGBO(19, 22, 33, 1),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 7.0),
                            Container(
                              height: ScreenUtil().setHeight(100.0),
                              child: Center(
                                // lets make a widget for the cards
                                child: LocationSlider(),
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                    ),
                                    child: Text(
                                      "Lainnya",
                                      style: TextStyle(
                                        color: Color.fromRGBO(19, 22, 33, 1),
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                    ),
                                    child: CardWidget(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return InformationList();
                                        }));
                                      },
                                      logoPath: "assets/images/hospital.png",
                                      hintText: "Layanan Kesehatan",
                                      secText:
                                          "cari Layanan Kesehatan terdekat \n",
                                      thText: "",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                    ),
                                    child: CardWidget(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ListNews();
                                        }));
                                      },
                                      logoPath: "assets/images/info.png",
                                      hintText: "Informasi",
                                      secText:
                                          "lihat informasi mengenai \nstok data dan lainnya \n",
                                      thText: "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // LatestOrders(),

                            //   CardOne(
                            //       backgroundColor: Colors.black,
                            //       text: "Unit Layanan",
                            //       subText: "cari Layanan Kesehatan terdekat",
                            //       imagePath: "assets/images/house1.png",
                            //       textColor: Colors.red),
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
}
