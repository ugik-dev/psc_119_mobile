import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String nama = 'GUEST';
  Future<void> cekToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? namas = prefs.getString('nama');
    // final String? phones = prefs.getString('phone');
    debugPrint(namas);
    nama = namas!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Nama,\n",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          TextSpan(
                            text: nama,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/images/dp.png",
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Column(children: [
            const Center(child: Text('halaman profil')),
            ElevatedButton(
              onPressed: logout,
              child: const Text('LOG OUT'),
            ),
            OutlinedButton(
              onPressed: () {
                debugPrint('register mitra');
              },
              child: const Text('Mitra Mobil'),
            ),
          ]),
        ],
      ),
    );
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainPage()));
  }
}
