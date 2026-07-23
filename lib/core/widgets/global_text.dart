import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

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
    this.height,
    this.translate = true,
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
  final double? height;
  final bool translate;

  @override
  Widget build(BuildContext context) {
    return Text(
      translate ? tr(text ?? "") : (text ?? ""),
      style: _resolveStyle(),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: isEllipsis ? TextOverflow.ellipsis : overflow,
      softWrap: softWrap,
    );
  }

  TextStyle _resolveStyle() {
    final base = TextStyle(
      decoration: decoration ?? TextDecoration.none,
      decorationColor: decorationColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );

    switch (fontFamily) {
      case 'Newsreader':
        return GoogleFonts.newsreader(textStyle: base);
      case 'DaysOne':
        return GoogleFonts.daysOne(textStyle: base);
      case null:
      case 'Manrope':
        return GoogleFonts.manrope(textStyle: base);
      default:
        return base.copyWith(fontFamily: fontFamily);
    }
  }
}
