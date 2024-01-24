import 'package:flutter/material.dart';
import 'package:psc_119_ss/user/mitra/tambang_register.dart';

class MitraTambang extends StatefulWidget {
  const MitraTambang({Key? key}) : super(key: key);

  @override
  State<MitraTambang> createState() => _MitraTambangState();
}

class _MitraTambangState extends State<MitraTambang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mitra Tambang'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(); // fungsi tombol kembali
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Image.asset('assets/images/produksi_timah.jpg'),
          const SizedBox(
            height: 9,
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            color: Colors.red,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Maaf, Anda belum bergabung sebagai mitra tambang\n silahkan klik tombol registrasi terlelbih dahulu',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const RegisterTambang();
              }));
              // debugPrint('register mitra tamANG');
            },
            child: const Text('Daftar Mitra Tambang'),
          ),
        ],
      ),
    );
  }
}
