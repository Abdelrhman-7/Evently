import 'package:evently/core/colormanager.dart';
import 'package:flutter/material.dart';

class Customelevatedbutton extends StatelessWidget {
  final VoidCallback onpressed;
  final String text;
  final Color? backgroundcolor;
  // ignore: non_constant_identifier_names
  final Color? Bordercolor;
  final TextStyle? textStyle;
  final Color? textcolor;
  final bool hasIcon;
  //final Image? icon;
  final Widget? iconWidget;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  const Customelevatedbutton({
    super.key,
    required this.onpressed,
    required this.text,
    this.backgroundcolor = Colormanager.blue,
    // ignore: non_constant_identifier_names
    this.Bordercolor = Colors.transparent,
    this.textStyle,
    this.textcolor = Colormanager.whitepure,
    this.hasIcon = false,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    var heigh = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundcolor,
        elevation: 0,

        padding: EdgeInsets.symmetric(vertical: heigh * 0.02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(width: 2, color: Bordercolor!),
        ),
      ),
      onPressed: onpressed,
      child: hasIcon
          ? Row(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
              crossAxisAlignment:
                  crossAxisAlignment ?? CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.03),
                  child: iconWidget,
                ),
                SizedBox(width: width * 0.02),
                Text(
                  text,
                  style:
                      textStyle ??
                      TextStyle(
                        color: textcolor,

                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                ),
              ],
            )
          : Text(
              text,
              style:
                  textStyle ??
                  TextStyle(
                    color: textcolor,

                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
            ),
    );
  }
}
