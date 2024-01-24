import 'package:flutter/material.dart';

class RegisterTambang extends StatefulWidget {
  const RegisterTambang({Key? key}) : super(key: key);

  @override
  State<RegisterTambang> createState() => _RegisterTambangState();
}

class _RegisterTambangState extends State<RegisterTambang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Mitra Tambang'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(); // fungsi tombol kembali
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            "Syarat Dan Ketentuan \n\n1. Peserta Wajib memberikan data yang sebenar-benarnya\n2. Jika dikemudian hari ternyata data yang anda berikan tidak valid maka, kemitraan anda akan dicabut",
            // style: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
