import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class GlobalText extends StatelessWidget {
  const GlobalText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.fontFamily,
    this.decorationColor,
    this.isEllipsis = false,
    this.softWrap,
  });

  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final Color? decorationColor;
  final bool isEllipsis;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      tr(text ?? "", context: context),
      style: TextStyle(
        overflow: overflow,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: decorationColor ?? CupertinoColors.black,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: fontFamily ?? "Poppins",
        letterSpacing: letterSpacing,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: isEllipsis ? TextOverflow.ellipsis : null,
      softWrap: softWrap,
    );
  }
}
