import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:psc_119_ss/utils/constants.dart';
import 'package:psc_119_ss/widgets/faskes_card.dart';
import 'package:http/http.dart' as http;
import 'package:psc_119_ss/widgets/faskes_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationList extends StatefulWidget {
  @override
  _InformationListState createState() => _InformationListState();
}

class _InformationListState extends State<InformationList> {
  int activeIndex = 0;
  var stCekOrderan = false;
  String statusTambang = 'Loading ..';
  String statusRentalMobil = 'Loading ..';
  late List<Map<String, dynamic>> dataJsonFaskes;

  @override
  void initState() {
    super.initState();
    dataJsonFaskes = []; // Inisialisasi dengan list kosong
    cekOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 15.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.keyboard_backspace_rounded,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              "List Informasi",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 150.0,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(1.0),
                      child: FaskesListWidget(dataFaskes: dataJsonFaskes),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cekOrder() async {
    Position? position = await _getCurrentLocation();
    if (position != null) {
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.post(
        Uri.parse(
          "http://192.168.18.83:8000/api/faskes",
        ),
        body: {
          'long': position.longitude.toString(),
          'lat': position.latitude.toString(),
        },
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token', // Include Bearer token in headers
        },
      );

      if (response.statusCode == 200) {
        final String res = response.body;
        Map<String, dynamic> myBody = jsonDecode(response.body);

        setState(() {
          dataJsonFaskes = List<Map<String, dynamic>>.from(myBody['data']);
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Terjadi kesalahan tidak dapat mendapatkan lokasi anda")));
    }
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
