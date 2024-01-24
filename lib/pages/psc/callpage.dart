import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:psc_119_ss/pages/main_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CallPage extends StatefulWidget {
  final String title;
  final String imagePath;
  final String urlApi;
  final String jenis;

  const CallPage({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.urlApi,
    required this.jenis,
    // required this.ontab,
  }) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  bool updateData = false;
  bool getPriceList = false;
  late String tmpFile = "";
  late String oldFile = "";
  String valueJenis = "";
  String valueTime = "";
  PlatformFile? file1;

  // String urlApi = widget.urlApi;

  @override
  void initState() {
    super.initState();
    _getValue();
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = '2000-10-22 14:30';
        // timeController.text = '15:00';
      });
    });
  }

  late List<Map<String, dynamic>> _items = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Constants.primaryColor,
          body: SafeArea(
            bottom: false,
            child: Container(
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
                    child: Container(
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return MainUser();
                                    }));
                                  },
                                  child: const Icon(
                                    Icons.keyboard_backspace_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  widget.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Flexible(
                            child: Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height - 180.0,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  GestureDetector(
                                    onTap:
                                        _callBtn, // Replace with your onTap function
                                    child: Container(
                                      width:
                                          160.0, // Adjust the size of the button
                                      height:
                                          160.0, // Adjust the size of the button
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors
                                            .blue, // Replace with your desired color
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.call,
                                          color: Colors
                                              .white, // Replace with your desired icon color
                                          size:
                                              130.0, // Adjust the size of the icon
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      future: null,
    );
  }

  Future displayTimePicker(BuildContext context) async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        // timeController.text = "${time.hour}:${time.minute}";
      });
    }
  }

  void _callBtn() async {
    // Get current location
    LocationData? position = await _getCurrentLocation();

    if (position != null) {
      print(
          'Latitude HD: ${position.latitude}, Longitude: ${position.longitude}');

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var uri = Uri.parse(widget.urlApi);

      var response = await http.post(
        uri,
        body: {
          'long': position.longitude.toString(),
          'lat': position.latitude.toString(),
          'ref_emergency_id': widget.jenis,
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token', // Include Bearer token in headers
        },
      );

      print('Request failed with status: ${response.statusCode}.');

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        var itemCount = jsonResponse['message'];

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Success on Call")));

        print('Number of books about http: $itemCount.');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Terjadi kesalahan")));
        print('Request failed with status: ${response.statusCode}.');
      }
    } else {
      // Handle if the location is not available
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to retrieve location")));
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
      print("Error getting location: $e");
      return null;
    }
  }
}
