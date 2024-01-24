import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:psc_119_ss/pages/mitra/loading_mitra.dart';
import 'package:psc_119_ss/pages/mitra/register_tambang.dart';
import 'package:psc_119_ss/pages/mitra/takepicture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../main_user.dart';
import '../../widgets/app_button.dart';
import 'package:http/http.dart' as http;

class TakeSwa extends StatefulWidget {
  @override
  State<TakeSwa> createState() => _TakeSwaState();
}

class _TakeSwaState extends State<TakeSwa> {
  File? imageFile;
  String? imageLink;
  String? oldImage;

  @override
  Widget build(BuildContext context) {
    // print('=================dari pg cam2');
    // print(imageFile);
    return FutureBuilder(
        future: cekKemitraan(),
        builder: (context, _) {
          return Scaffold(
              backgroundColor: Constants.primaryColor,
              body: SafeArea(
                  bottom: false,
                  child: Container(
                      child: Stack(clipBehavior: Clip.none, children: [
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
                            padding: EdgeInsets.symmetric(
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
                                  "Daftar sebagai mitra tambang",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                ),
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
                                        MediaQuery.of(context).size.height -
                                            180.0,
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
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        width: 6000,
                                        height: 440,
                                        color: Colors.grey[200],
                                        child: (imageFile != null)
                                            ? Image.file(imageFile!)
                                            : ((oldImage != '')
                                                ? Image.network(oldImage!)
                                                : const SizedBox()),
                                      ),
                                      Container(
                                        child: ElevatedButton(
                                          // onPressed: _callCamera1,
                                          onPressed: _callImagePicture,
                                          child: Text('Ambil Gambar'),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      AppButton(
                                        type: ButtonType.PRIMARY,
                                        text: "Simpan dan Lanjutkan",
                                        onPressed: _registerTambang,
                                      )
                                    ],
                                  )))
                        ])))
                  ]))));
        });
  }

  void _callCamera1() async {
    imageFile = await Navigator.push<File>(
        context, MaterialPageRoute(builder: (_) => TakePicture()));
  }

  Future<void> _callImagePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo!.path.isNotEmpty)
      setState(() {
        imageFile = File(photo.path);
        imageLink = photo.path;
      });
    // print(photo);
  }

  void _registerTambang() async {
    var uri = Uri.parse(
      "http://127.0.0.1:8000/store/api/MitraTambang/upload_swa",
    );

    // if (PersyaratanController.text != "") {
    var request = new http.MultipartRequest("POST", uri);
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // final respStr = await response.stream.bytesToString();;
    Map<String, String> headers = {
      'X-API-KEY': token.toString(),
    };
    request.headers.addAll(headers);
    if (imageLink != "") {
      request.files.add(http.MultipartFile('file_swa',
          imageFile!.readAsBytes().asStream(), imageFile!.lengthSync(),
          filename: imageLink!.split("/").last));
    }

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    // Map<String, dynamic> myBody = jsonDecode(respStr);

    if (response.statusCode == 200) {
      Navigator.pushReplacement(this.context,
          MaterialPageRoute(builder: (context) => LoadingMitra()));
    }
  }

  Future<void> cekKemitraan() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(
        "http://127.0.0.1:8000/store/api/MitraTambang/cek",
      ),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'X-API-KEY': token.toString(),
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      final String res = response.body;
      Map<String, dynamic> myBody = jsonDecode(response.body);
      if (myBody['status']) {
        if (myBody['data']['file_persyaratan'] == '' ||
            myBody['data']['file_persyaratan'].isEmpty) {
          Navigator.pushReplacement(this.context,
              MaterialPageRoute(builder: (context) => const RegisterTambang()));
        }
        if (myBody['data']['file_pengaju'].isNotEmpty &&
            myBody['data']['file_pengaju'] != '') {
          oldImage =
              'http://192.168.1.110/imastore/uploads/file_pengaju/${myBody["data"]["file_pengaju"]}';
          print(oldImage);
        }
        ;
        if (myBody['data']['status'] == '0') {}
        if (myBody['data']['status'] == '1') {
          // Navigator.pushReplacement(this.context,
          //     MaterialPageRoute(builder: (context) => const LoadingMitra()));
        } else if (myBody['data']['status'] == '2') {
          // Navigator.pushReplacement(this.context,
          //     MaterialPageRoute(builder: (context) => const MainPage()));
        }
      }
      // }

      // print(res.data.message);
    }
  }
}
// }
