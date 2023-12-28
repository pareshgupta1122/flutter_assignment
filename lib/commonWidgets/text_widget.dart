import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final TextDecoration textDecoration;
  final String? fontFamily; 

  const TextWidget({
    Key? key,
    required this.title,
    this.color = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0.25,
    this.maxLines,
    this.textOverflow,
    this.textAlign,
    this.textDecoration = TextDecoration.none,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double tS = MediaQuery.of(context).textScaleFactor;

    return Text(
      title,
      style: Theme.of(context).textTheme.headline3!.copyWith(
            fontSize: tS * fontSize,
            fontFamily: fontFamily,
            color: color,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            decoration: textDecoration,
          ),
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign,
      
    );
  }
}
