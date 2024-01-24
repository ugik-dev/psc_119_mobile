import 'package:flutter/material.dart';
import 'package:psc_119_ss/mitra_page.dart';
import 'package:psc_119_ss/home_page.dart';
import 'package:psc_119_ss/user/profile.dart';
import 'package:psc_119_ss/user/dashboard.dart';

import '../utils/constants.dart';

class HomeUsers extends StatefulWidget {
  const HomeUsers({Key? key}) : super(key: key);

  @override
  State<HomeUsers> createState() => _HomeUsersState();
}

class _HomeUsersState extends State<HomeUsers> {
  int currentPage = 0;
  List<Widget> pages = const [
    Dashboard(),
    MitraPage(),
    MitraPage(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Mobile Apps'),
      // ),
      backgroundColor: Constants.primaryColor,
      body: SingleChildScrollView(child: pages[currentPage]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Ini di click');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'HOME'),
          NavigationDestination(
              icon: Icon(Icons.local_car_wash), label: 'ABSEN'), //CARWASH
          NavigationDestination(
              icon: Icon(Icons.handshake), label: 'SKP'), //MITRA
          NavigationDestination(icon: Icon(Icons.person), label: 'PROFIL'),
          // NavigationDestination(icon: Icon(Icons.home), label: 'HOME'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
