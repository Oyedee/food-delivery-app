import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  TextOverflow overflow;
  SmallText({
    Key? key,
    this.color = const Color(0xFF8F8F8F),
    required this.text,
    this.size = 14,
    this.height = 1.2,
    this.overflow = TextOverflow.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        overflow: overflow,
        fontFamily: 'Roboto',
        fontSize: size,
        height: height,
        color: color,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
