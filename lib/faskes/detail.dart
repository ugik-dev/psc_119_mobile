import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:psc_119_ss/pages/browser_page.dart';
import 'package:psc_119_ss/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailFaskesScreen extends StatelessWidget {
  final String name;
  final String description;
  final String phone;
  final String distance;
  final String whatsapp;
  final String mapsUrl;
  final String website;
  final String refFaskes;
  final String alamat;

  DetailFaskesScreen({
    required this.name,
    required this.description,
    required this.phone,
    required this.distance,
    required this.whatsapp,
    required this.mapsUrl,
    required this.website,
    required this.refFaskes,
    required this.alamat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
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
                              "Detail Faskes",
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
                        SizedBox(height: 20.0),
                        Text(
                          name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Jarak $distance',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description: $description",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          "Alamat: $alamat",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          "Phone: $phone",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          "Website: $website",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            launchWhatsApp(whatsapp);
                          },
                          child: Text('Whatsapp'),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            _launchPhoneCall(phone);
                          },
                          child: Text('Telepon'),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            openGoogleMaps(mapsUrl);
                          },
                          child: Text('Open in Google Maps'),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return BrowserPage(
                                  title: name, initialUrl: website);
                            }));
                          },
                          child: Text('Open Website'),
                        ),
                      ],
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
}

Future<void> _launchPhoneCall(String phoneNumber) async {
  final Uri phoneCallUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunch(phoneCallUri.toString())) {
    await launch(phoneCallUri.toString());
  } else {
    // Handle error, e.g., show an alert
    print('Could not launch $phoneCallUri');
  }
}

void launchWhatsApp(String whatsapp) async {
  // Check if the number starts with '08'
  if (whatsapp.startsWith('08')) {
    // Replace '08' with the desired country code '+62'
    whatsapp = '+62${whatsapp.substring(1)}';
  }

  String url = "https://wa.me/$whatsapp?text=Hallo";
  print(url);
  try {
    // ignore: deprecated_member_use
    await launch(url, forceWebView: false);
  } catch (e) {
    print('Error launching WhatsApp: $e');
    // Handle the error as needed
  }
}

Future<void> openGoogleMaps(String mapsUrl) async {
  if (await Permission.location.request().isGranted) {
    try {
      if (await canLaunch(mapsUrl)) {
        await launch(mapsUrl);
      } else {
        throw 'Could not launch Google Maps';
      }
    } catch (e) {
      print('Error launching Google Maps: $e');
    }
  } else {
    // Handle the case where location permission is not granted
    print('Location permission not granted');
    // You can show a message or request permission again, as needed
  }
}
