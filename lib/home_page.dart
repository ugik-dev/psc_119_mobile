// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:psc_119_ss/mitra_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Cennter(const Text('Mobile Apps'));
    return Column(children: [
      Image.asset('assets/images/onboarding_image_3.png'),
      Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const MitraPage();
            }));
          },
          child: const Text('Tombol 1'),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return const MitraPage();
          }));
        },
        child: const Text('Tombol 1'),
      ),
    ]);
  }
}
