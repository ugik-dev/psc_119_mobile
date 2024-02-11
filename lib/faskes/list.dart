// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:psc_119_ss/config.dart';
// import 'package:psc_119_ss/news/detail.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:psc_119_ss/widgets/faskes_card.dart';
// import 'package:psc_119_ss/config.dart';
// import 'package:psc_119_ss/utils/constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:psc_119_ss/widgets/faskes_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
// class FaskesIItem {
//   final int id;
//   final int refContentId;
//   final String judul;
//   final String slug;
//   final String content;
//   final String tanggal;
//   final String sampul;
//   final String nameContent;

//   FaskesIItem({
//     required this.id,
//     required this.refContentId,
//     required this.judul,
//     required this.slug,
//     required this.content,
//     required this.tanggal,
//     required this.sampul,
//     required this.nameContent,
//   });
// }

class ListFaskes extends StatefulWidget {
  const ListFaskes({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListFaskesState createState() => _ListFaskesState();
}

class _ListFaskesState extends State<ListFaskes> {
  // late List<FaskesIItem> FaskesIItems = [];
  late List<Map<String, dynamic>> FaskesIItems;
  @override
  void initState() {
    super.initState();
    FaskesIItems = [];
    cekOrder();
  }

  // Future<void> fetchData() async {
  //   final response =
  //       await http.get(Uri.parse('${AppConfig.base_url_api}/api/content'));

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     if (data['error'] == false) {
  //       final List<dynamic> dataList = data['data'];
  //       FaskesIItems = dataList
  //           .map((item) => FaskesIItem(
  //                 id: item['id'],
  //                 refContentId: int.parse(item['ref_content_id']),
  //                 judul: item['judul'],
  //                 slug: item['slug'],
  //                 content: item['content'],
  //                 tanggal: item['tanggal'],
  //                 sampul: item['sampul'],
  //                 nameContent: item['name_content'],
  //               ))
  //           .toList();
  //       setState(() {});
  //     } else {
  //       // Handle error response
  //       print('Failed to fetch data: ${data['message']}');
  //     }
  //   } else {
  //     // Handle other HTTP status codes
  //     print('Failed to fetch data. Status Code: ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Fasilitas Kesehatan'),
      ),
      // ignore: unnecessary_null_comparison
      body: FaskesIItems.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: FaskesIItems.length,
              itemBuilder: (context, index) {
                return FaskesCard(
                  name: FaskesIItems[index]['name'],
                  description: FaskesIItems[index]['description'],
                  distance: FaskesIItems[index]['distance'],
                  phone: FaskesIItems[index]['phone'],
                  whatsapp: FaskesIItems[index]['whatsapp'],
                  alamat: FaskesIItems[index]['alamat'],
                  mapsUrl: FaskesIItems[index]['url'],
                  website: FaskesIItems[index]['website'],
                  refFaskes: FaskesIItems[index]['name_jenis'],
                );
                // ListTile(
                //   title: Text(FaskesIItems[index]['name']),
                //   subtitle: Text(
                //       'Jarak : ${FaskesIItems[index]['distance']} \n${FaskesIItems[index]['alamat']}'),
                //   onTap: () {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => FaskesIItemDetailPage(
                //     //         FaskesIItem: FaskesIItems[index]),
                //     //   ),
                //     // );
                //   },
                // );
              },
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
          FaskesIItems = (jsonResponse['data'] as List<dynamic>?)
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
}
