import 'dart:io';
import 'dart:convert';
// import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psc_119_ss/pages/main_user.dart';
import 'package:psc_119_ss/pages/mitra/cam2.dart';
import 'package:psc_119_ss/pages/mitra/loading_mitra.dart';
import 'package:psc_119_ss/pages/mitra/pilih_mitra.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import 'package:http/http.dart' as http;
// import 'Dio';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class RegisterTambang extends StatefulWidget {
  const RegisterTambang({Key? key}) : super(key: key);

  @override
  State<RegisterTambang> createState() => _RegisterTambangState();
}

class _RegisterTambangState extends State<RegisterTambang> {
  final PersyaratanController =
      TextEditingController(text: 'tidak ada file dipilih');
  final jenis_mitraController = TextEditingController(text: '1');
  final emailController = TextEditingController();
  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  final nohpController = TextEditingController();
  bool updateData = false;
  late String tmpFile = "";
  late String oldFile = "";
  String jm = "";
  PlatformFile? file1;

  // Uint8List? fileBytes;
  final List<Map<String, dynamic>> _items = [
    {
      'value': '1',
      'label': 'Perseorangan',
    },
    {
      'value': '2',
      'label': 'Perusahaan (PT)',
    },
    {
      'value': '3',
      'label': 'Perusahaan (CV)',
    },
  ];
  // final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    jenis_mitraController.text = '1';
    return FutureBuilder(
        future: cekKemitraan(),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Nama Lengkap
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Jenis Mitra"),
                                        // const SizedBox(height: 5.0),
                                        Container(
                                          height: ScreenUtil().setHeight(48.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: SelectFormField(
                                            type: SelectFormFieldType
                                                .dialog, // or can be dialog
                                            // initialValue: 'ASDSD',
                                            // icon: Icon(Icons.format_shapes),
                                            // labelText: 'Shape',
                                            items: _items,
                                            // value:
                                            onChanged: (val) => {jm = val},
                                            onSaved: (val) => {jm = val!},
                                            controller: jenis_mitraController,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.handshake),
                                              hintText: "",
                                              hintStyle: TextStyle(
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    105, 108, 121, 0.7),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25.0,
                                    ),
                                    // Nama
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                            "Nama Perseorangan / Perushaaan"),
                                        const SizedBox(height: 5.0),
                                        Container(
                                          // height: ScreenUtil().setHeight(48.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: TextFormField(
                                            controller: namaController,
                                            // controller: _controller.emailController,
                                            obscureText: false,
                                            maxLines: 1,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.person),
                                              hintText: "",
                                              hintStyle: TextStyle(
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    105, 108, 121, 0.7),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25.0,
                                    ),
                                    // Alamat
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Alamat"),
                                        const SizedBox(height: 5.0),
                                        Container(
                                          // height: ScreenUtil().setHeight(48.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: TextFormField(
                                            controller: alamatController,
                                            // controller: _controller.emailController,
                                            obscureText: false,
                                            maxLines: 3,
                                            decoration: const InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.location_pin),
                                              hintText: "",
                                              hintStyle: TextStyle(
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    105, 108, 121, 0.7),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25.0,
                                    ),
                                    // no hp
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("No NIB"),
                                        const SizedBox(height: 5.0),
                                        Container(
                                          height: ScreenUtil().setHeight(48.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: TextFormField(
                                            controller: nohpController,
                                            // controller: _controller.emailController,
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.phone_android),
                                              hintText: "",
                                              hintStyle: TextStyle(
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    105, 108, 121, 0.7),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 25.0,
                                    ),
                                    // // no telp
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("File Persyaratan"),
                                        const SizedBox(height: 5.0),
                                        GestureDetector(
                                            onTap: _uploadPersyaratan,
                                            child: Container(
                                              height:
                                                  ScreenUtil().setHeight(48.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: TextFormField(
                                                onTap: _uploadPersyaratan,
                                                // readOnly: true,
                                                controller:
                                                    PersyaratanController,
                                                // controller: _controller.emailController,
                                                // obscureText: false,
                                                decoration:
                                                    const InputDecoration(
                                                  prefixIcon:
                                                      Icon(Icons.upload),
                                                  hintText: "",
                                                  hintStyle: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Color.fromRGBO(
                                                        105, 108, 121, 0.7),
                                                  ),
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        GestureDetector(
                                            onTap: downloadFile,
                                            child:
                                                const Text('Lihat file lama')),
                                      ],
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
        });
  }

  void _uploadPersyaratan() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first; // print(file.name);
      tmpFile = file.path.toString();
      // setState(() {
      // print(PersyaratanController.text);
      PersyaratanController.text = tmpFile.split("/").last.toString();
      file1 = file;
      updateData = true;

      // });
      // final newFile = await saveFileOne(file);
      // file1 = newFile;
    } else {
      // User canceled the picker
    }
  }

  void _registerTambang() async {
    var uri = Uri.parse(
      "http://127.0.0.1:8000/store/api/MitraTambang/register",
    );
    if (jenis_mitraController.text.isEmpty ||
        jenis_mitraController.text == "") {
      // print("Jenis Mitra tidak boleh kosong");
      ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(content: Text("Jenis Mitra tidak boleh kosong")));
      return;
    } else if (namaController.text.isEmpty || namaController.text == "") {
      // print("Nama tidak boleh kosong");
      ScaffoldMessenger.of(this.context)
          .showSnackBar(SnackBar(content: Text("Nama tidak boleh kosong")));
      return;
    } else if (alamatController.text.isEmpty || alamatController.text == "") {
      // print("Alamat tidak boleh kosong");
      ScaffoldMessenger.of(this.context)
          .showSnackBar(SnackBar(content: Text("Alamat tidak boleh kosong")));
      return;
    } else if (nohpController.text.isEmpty || nohpController.text == "") {
      // print("NO HP tidak boleh kosong");
      ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(content: Text("Nomor NIB tidak boleh kosong")));
      return;
    }
    // else if (tmpFile.isEmpty || tmpFile == "") {
    //   ScaffoldMessenger.of(this.context).showSnackBar(
    //       SnackBar(content: Text("File Persyaratan tidak boleh kosong")));
    // }
    // return;
    if (PersyaratanController.text != "") {
      // print("File Persyaratan Tidak boleh kosong");
    }
    if (!updateData) {
      ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(
          content: Text("File Persyaratan tidak boleh kosong !")));
      return;
    }
    if (PersyaratanController.text != "") {
      var request = new http.MultipartRequest("POST", uri);

      request.fields['nama'] = namaController.text;
      // request.fields['email'] = emailController.text;
      request.fields['alamat'] = alamatController.text;
      request.fields['nomor_nib'] = nohpController.text;
      request.fields['jenis_mitra'] = jm;
      Map<String, String> headers = {
        'X-API-KEY': 'psc_119_ss_apps',
      };
      request.headers.addAll(headers);
      if (tmpFile != "") {
        request.files.add(http.MultipartFile('persyaratan',
            File(tmpFile).readAsBytes().asStream(), File(tmpFile).lengthSync(),
            filename: tmpFile.split("/").last));
      }

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      // Map<String, dynamic> myBody = jsonDecode(respStr);

      // print(myBody);
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            this.context, MaterialPageRoute(builder: (context) => TakeSwa()));
      }
    }
  }

  Future<String> downloadFile() async {
    // print('donlod $oldFile');
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    // var status = await Permission.storage.status;
    // if (!status.isGranted) {
    //   await Permission.storage.request();
    // }

    try {
      myUrl = 'http://127.0.0.1:8000/store/uploads/file_persyaratan/' + oldFile;
      // Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
      // String tempPath = tempDir.path;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        // filePath = '$tempDir/$oldFile';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
      print(filePath);
    } catch (ex) {
      filePath = 'Can not fetch url';
      print(filePath);
    }
    print(filePath);

    return filePath;
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
        if (myBody['data']['status'] == '0') {
          updateData = true;
          namaController.text = myBody['data']['nama'];
          alamatController.text = myBody['data']['alamat'];
          String fl = myBody['data']['file_persyaratan'];
          print(fl);
          PersyaratanController.text = fl.toString();
          print(myBody['data']['file_persyaratan']);
          print('-');
          oldFile = myBody['data']['file_persyaratan'];

          nohpController.text = myBody['data']['nomor_nib'];
          jenis_mitraController.text = myBody['data']['jenis_mitra'];
        }
        if (myBody['data']['status'] == '1') {
          Navigator.pushReplacement(this.context,
              MaterialPageRoute(builder: (context) => const LoadingMitra()));
        } else if (myBody['data']['status'] == '2') {
          Navigator.pushReplacement(this.context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        }
      }
      // }

      // print(res.data.message);
    }
  }
}
