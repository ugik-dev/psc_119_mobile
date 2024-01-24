import 'package:flutter/material.dart';
import 'package:psc_119_ss/user/mitra/tambang.dart';

class MitraPage extends StatefulWidget {
  const MitraPage({Key? key}) : super(key: key);

  @override
  State<MitraPage> createState() => _MitraPageState();
}

class _MitraPageState extends State<MitraPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('mitra page');
    return Container(
      child: Column(
        children: [
          Image.asset('assets/images/onboarding_image_3.png'),
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
                'Anda belum bergabung sebagai mitra',
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
                return const MitraTambang();
              }));
              // debugPrint('register mitra tamANG');
            },
            child: const Text('Mitra Tambang'),
          ),
          OutlinedButton(
            onPressed: () {
              debugPrint('Register mitra');
            },
            child: const Text('Mitra Mobil'),
          ),
          // GestureDetector(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: const [
          //       Text('This is for gesture detectore'),
          //       Text('and row element'),

          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
