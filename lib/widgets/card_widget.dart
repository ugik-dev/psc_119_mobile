import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  final String hintText;
  final String secText;
  final String thText;
  final String prefixIcon;
  final String height;
  final logoPath;
  final onTap;
  final Color color;

  const CardWidget(
      {this.hintText = "",
      this.secText = "",
      this.thText = "",
      this.prefixIcon = "",
      this.height = "",
      this.logoPath,
      this.color = Colors.blue,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
        height: ScreenUtil().setHeight(127.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              hintText,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color.fromRGBO(74, 77, 84, 1),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: secText,
                        style: TextStyle(
                          color: Color.fromRGBO(143, 148, 162, 1),
                        ),
                      ),
                      TextSpan(
                        text: thText,
                        style: TextStyle(
                          color: Color.fromRGBO(74, 77, 84, 1),
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
                (logoPath != null)
                    ? Image.asset(
                        logoPath,
                        // width: 300,
                        height: 80,
                      )
                    : SizedBox(
                        height: 5.0,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
