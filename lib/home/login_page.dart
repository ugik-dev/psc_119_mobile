import 'package:flutter/material.dart';

import '../colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    // TextEditingController passwordController = TextEditingController();
    return Scaffold(
        body: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage("assets/images/addtask.jpg")),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back, color: AppColors.mainColor))
              ],
            ),
            Column(
              children: [
                TextField(
                  maxLines: 1,
                  controller: usernameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white30,
                      hintText: "Username / Email",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1))),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            )
          ]),
    ));
  }
}
