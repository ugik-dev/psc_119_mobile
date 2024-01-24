import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardOne extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final String subText;
  final String imagePath;
  final Color textColor;
  const CardOne(
      {Key? key,
      required this.backgroundColor,
      required this.text,
      required this.subText,
      required this.imagePath,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        // width: ScreenUtil().setWidth(200.0),
        decoration: BoxDecoration(
          color: textColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(169, 176, 185, 0.42),
              spreadRadius: 0,
              blurRadius: 8.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -16.0,
              top: 0.0,
              child: Opacity(
                opacity: 0.69,
                child: Image.asset(
                  imagePath,
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${text},\n",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      fontSize: 16.0,
                    ),
                  ),
                  TextSpan(
                    text: subText,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
