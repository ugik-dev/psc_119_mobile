import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psc_119_ss/pages/main_user.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import 'package:http/http.dart' as http;

class CarWashNewOrder extends StatefulWidget {
  const CarWashNewOrder({Key? key}) : super(key: key);

  @override
  State<CarWashNewOrder> createState() => _CarWashNewOrderState();
}

class _CarWashNewOrderState extends State<CarWashNewOrder> {
  final jenisController = TextEditingController(text: '1');
  final emailController = TextEditingController();
  final namaController = TextEditingController();
  final platController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  // String valPrice
  bool updateData = false;
  bool getPriceList = false;
  late String tmpFile = "";
  late String oldFile = "";
  String valueJenis = "";
  String valueTime = "";
  PlatformFile? file1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functPriceList();
    _getValue();
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {});
    });
  }

  // late List _items;
  late List<Map<String, dynamic>> _items = [];
  // Uint8List? fileBytes;
  late List<Map<String, dynamic>> _jam = [
    // {
    //   'value': '7.30',
    //   'label': '7.30',
    // },
    {
      'value': '8.00',
      'label': '8.00',
    },
    {
      'value': '9.00',
      'label': '9.00',
    },
    {
      'value': '10.00',
      'label': '10.00',
    },
    {
      'value': '11.00',
      'label': '11.00',
    },
    {
      'value': '12.00',
      'label': '12.00',
    },
    {
      'value': '13.00',
      'label': '13.00',
    },
    {
      'value': '14.00',
      'label': '14.00',
    },
    {
      'value': '15.00',
      'label': '15.00',
    },
    {
      'value': '16.00',
      'label': '16.00',
    },
    {
      'value': '17.00',
      'label': '17.00',
    },
  ];

  // var _items = [];

  // final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    jenisController.text = '1';
    return FutureBuilder(
        future: functPriceList(),
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
                                    "Daftar Antrian",
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
                                        Text("Jenis"),
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
                                            onChanged: (val) => {val = val},
                                            onSaved: (val) =>
                                                {valueJenis = val!},
                                            controller: jenisController,
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
                                        const Text("Nama Driver"),
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
                                        const Text("Nomor Kendaraan"),
                                        const SizedBox(height: 5.0),
                                        Container(
                                          // height: ScreenUtil().setHeight(48.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: TextFormField(
                                            controller: platController,
                                            // controller: _controller.emailController,
                                            obscureText: false,
                                            maxLines: 3,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.numbers),
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
                                        const Text("Tanggal Pemesanan"),
                                        const SizedBox(height: 5.0),
                                        Container(
                                          height: ScreenUtil().setHeight(48.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: TextFormField(
                                            controller: dateController,
                                            // controller: _controller.emailController,
                                            obscureText: false,
                                            readOnly:
                                                true, //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      initialDatePickerMode:
                                                          DatePickerMode.day,
                                                      firstDate: DateTime(
                                                          2000), //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime(2101));

                                              if (pickedDate != null) {
                                                print(
                                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickedDate);
                                                print(
                                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                                //you can implement different kind of Date Format here according to your requirement

                                                setState(() {
                                                  dateController.text =
                                                      formattedDate; //set output date to TextField value.
                                                });
                                              } else {
                                                print("Date is not selected");
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.calendar_month),
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
                                        Text("Jam"),
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
                                            items: _jam,
                                            // value:
                                            onChanged: (val) =>
                                                {valueTime = val},
                                            onSaved: (val) =>
                                                {valueTime = val!},
                                            controller: timeController,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                  Icons.punch_clock_rounded),
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
                                    const SizedBox(
                                      height: 25.0,
                                    ),
                                    // // no telp

                                    AppButton(
                                      type: ButtonType.PRIMARY,
                                      text: "Daftar Sekarang",
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

  Future displayTimePicker(BuildContext context) async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        timeController.text = "${time.hour}:${time.minute}";
      });
    }
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
      file1 = file;
      updateData = true;
    } else {}
  }

  void _registerTambang() async {
    var uri = Uri.parse(
      "http://127.0.0.1:8000/store/api/CarWash/pesan",
    );
    if (jenisController.text.isEmpty || jenisController.text == "") {
      // print("Jenis Mitra tidak boleh kosong");
      ScaffoldMessenger.of(this.context)
          .showSnackBar(SnackBar(content: Text("Jenis tidak boleh kosong")));
      return;
    } else if (namaController.text.isEmpty || namaController.text == "") {
      // print("Nama tidak boleh kosong");
      ScaffoldMessenger.of(this.context)
          .showSnackBar(SnackBar(content: Text("Nama tidak boleh kosong")));
      return;
    } else if (platController.text.isEmpty || platController.text == "") {
      // print("Alamat tidak boleh kosong");
      ScaffoldMessenger.of(this.context)
          .showSnackBar(SnackBar(content: Text("No Plat tidak boleh kosong")));
      return;
    } else if (dateController.text.isEmpty || dateController.text == "") {
      // print("NO HP tidak boleh kosong");
      ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(content: Text("Tanggal Perkiraan tidak boleh kosong")));
      return;
    }
    // else if (tmpFile.isEmpty || tmpFile == "") {
    //   ScaffoldMessenger.of(this.context).showSnackBar(
    //       SnackBar(content: Text("File Persyaratan tidak boleh kosong")));
    // }
    // return;

    var request = new http.MultipartRequest("POST", uri);
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    request.fields['nama_driver'] = namaController.text;
    // request.fields['email'] = emailController.text;
    request.fields['plat'] = platController.text;
    request.fields['req_tanggal'] = dateController.text;
    request.fields['service_1'] = valueJenis;
    request.fields['service_2'] = valueJenis;
    request.fields['req_waktu'] = valueTime;
    request.fields['token'] = token.toString();
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'X-API-KEY': 'psc_119_ss_apps',
    };
    request.headers.addAll(headers);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    // Map<String, dynamic> myBody = jsonDecode(respStr);

    print(respStr);
    print('push');
    // if (response.statusCode == 200) {
    //   Navigator.pushReplacement(
    //       this.context, MaterialPageRoute(builder: (context) => TakeSwa()));
    // }
  }
  // }

  Future<void> functPriceList() async {
    print(getPriceList.toString());
    if (!getPriceList) {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      print('cekpricelist');
      print(token.toString());
      print(_items.toString());

      final response = await http.get(
        Uri.parse(
            // "http://127.0.0.1:8000/store/api/CarWash/getPriceList",
            "http://127.0.0.1:8000/store/api/CarWash/PriceList"),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'X-API-KEY': 'psc_119_ss_apps',
        },
      );
      if (response.statusCode == 200) {
        final String res = response.body;
        Map<String, dynamic> myBody = jsonDecode(response.body);
        if (myBody['status']) {
          print('data respon :');
          print('masuk getpricelst');
          setState(() {
            print('data respon 2:');
            // _items.add({'value': 4, 'label': 'tambahan'});
            // _items.add({'value': 4, 'label': 'tambahan'});
            print('data respon 3:');
            print(myBody['data']);
            late List<Map<String, dynamic>> _itemstmp =
                new List<Map<String, dynamic>>.from(myBody['data']);
            // _items.addAll(myBody['data']);
            getPriceList = true;
            // List<dynamic> _items = myBody['data'];
            _items = _itemstmp;
            print('_items setstate List Map');
            print(_items.toString());
          });
          // print(myBody['data']);
        }
        // if (myBody['data']['status'] == '0') {

        // updateData = true;
        // namaController.text = myBody['data']['nama'];
        // platController.text = myBody['data']['alamat'];
        // String fl = myBody['data']['file_persyaratan'];
        // print(fl);
        // print(myBody['data']['file_persyaratan']);
        // print('-');
        // oldFile = myBody['data']['file_persyaratan'];

        // dateController.text = myBody['data']['nomor_nib'];
        // jenisController.text = myBody['data']['jenis_mitra'];
        // }
        // if (myBody['data']['status'] == '1') {
        //   Navigator.pushReplacement(this.context,
        //       MaterialPageRoute(builder: (context) => const LoadingMitra()));
        // } else if (myBody['data']['status'] == '2') {
        //   Navigator.pushReplacement(this.context,
        //       MaterialPageRoute(builder: (context) => const MainPage()));
        // }
      }
    }
  }
}
