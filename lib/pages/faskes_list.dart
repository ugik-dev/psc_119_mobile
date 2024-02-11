import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:psc_119_ss/config.dart';
import 'package:psc_119_ss/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:psc_119_ss/widgets/faskes_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class InformationList extends StatefulWidget {
  const InformationList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InformationListState createState() => _InformationListState();
}

class _InformationListState extends State<InformationList> {
  int activeIndex = 0;
  late List<Map<String, dynamic>> dataJsonFaskes;

  @override
  void initState() {
    super.initState();
    dataJsonFaskes = [];
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
                              "Fasilitas Layanan Kesehatan",
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
                  // Flexible(
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 100.0,
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
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cekOrder() async {
    LocationData? position = await _getCurrentLocation();
    if (position != null) {
      if (kDebugMode) {
        print(
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      }

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.post(
        Uri.parse(
          '${AppConfig.base_url_api}/api/faskes',
        ),
        body: {
          'long': position.longitude.toString(),
          'lat': position.latitude.toString(),
        },
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          dataJsonFaskes = (jsonResponse['data'] as List<dynamic>?)
                  ?.cast<Map<String, dynamic>>()
                  .toList() ??
              [];
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Terjadi kesalahan tidak dapat mendapatkan lokasi anda")));
    }
  }

  Future<LocationData?> _getCurrentLocation() async {
    Location location = Location();

    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }

      PermissionStatus permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus != PermissionStatus.granted) {
          return null;
        }
      }

      return await location.getLocation();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Terjadi kesalahan tidak dapat mendapatkan lokasi anda ")));
      if (kDebugMode) {
        print("Error getting location: $e");
      }
      return null;
    }
  }

  // Future<Position?> _getCurrentLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );

  //     return position;
  //   } catch (e) {
  //     print("Error: $e");
  //     return null;
  //   }
  // }
}
