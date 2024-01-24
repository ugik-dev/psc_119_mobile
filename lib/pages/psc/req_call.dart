import 'package:flutter/material.dart';
import 'package:psc_119_ss/utils/constants.dart';
import 'package:psc_119_ss/widgets/request_call_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestCall extends StatefulWidget {
  const RequestCall({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestCallState createState() => _RequestCallState();
}

class _RequestCallState extends State<RequestCall> {
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
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Constants.scaffoldBackgroundColor,
                        child: Column(
                          children: [
                            const SizedBox(height: 7.0),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 300),
                              height: 1300,
                              child: RequestCallWidget(),
                            ),
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
