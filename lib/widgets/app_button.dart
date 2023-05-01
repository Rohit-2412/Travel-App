import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_first_app/widgets/app_large_text.dart';
import 'package:my_first_app/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final Color color;
  String? text;
  IconData? icon;
  bool isIcon;
  final Color backgroundColor;
  double size;
  final Color borderColor;
  bool isBold;

  AppButton(
      {super.key,
      this.text = "",
      this.isBold = false,
      this.icon,
      this.isIcon = false,
      required this.color,
      required this.backgroundColor,
      required this.size,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1.0),
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor),
      child: isIcon
          ? Center(
              child: Icon(
                icon,
                color: color,
                size: size,
              ),
            )
          : Center(
              child: isBold
                  ? AppLargeText(
                      size: size,
                      text: text!,
                      color: color,
                    )
                  : AppText(
                      size: size,
                      text: text!,
                      color: color,
                    ),
            ),
    );
  }
}
