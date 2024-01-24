import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text('ssssssssssssssssssssssssssssssssssssssssssssssssssa'),
        // Text('ssssssssssssssssssssssssssssssssssssssssssssssssssa'),
        Positioned(
          right: 0.0,
          top: -100.0,
          child: Opacity(
            opacity: 0.3,
            child: Image.asset("assets/images/onboarding_image_3.png"),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kToolbarHeight,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
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
                                  text: "Welcome, \n",
                                  // style: DefaultTextStyle.of(context).style,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: "Ugik Dev !!, \n",
                                  // style: DefaultTextStyle.of(context).style,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          // Image.asset("assets/images/profile_small.jpg")
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
