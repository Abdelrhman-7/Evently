// ignore_for_file: camel_case_types
import 'package:evently/core/colormanager.dart';
import 'package:flutter/material.dart';

typedef onValidator = String? Function(String?)?;

// ignore: must_be_immutable
class TextFiled extends StatelessWidget {
  Color borderSideColor;
  String? hintext;
  String? lableText;
  TextStyle? hintTextStyle;
  TextStyle? lableTextStyle;
  Widget? prefixIcon;
  Widget? sufixIcon;
  onValidator? validator;
  TextInputType? keyBordType;
  bool obscureText;
  String? fieldName;
  TextStyle? styletext;
  TextEditingController? controller;
  final double vertical;
  final double horizontal;
  int? minLines;
  int? maxLines;
  TextFiled({
    super.key,
    this.borderSideColor = Colormanager.gray,
    this.hintTextStyle,
    this.hintext,
    this.lableText,
    this.lableTextStyle,
    this.prefixIcon,
    this.sufixIcon,
    this.validator,
    this.keyBordType = TextInputType.text,
    this.obscureText = false,
    required this.controller,
    this.fieldName,
    this.styletext,
    this.vertical = 20,
    this.horizontal = 12,
    this.maxLines = 1,
    this.minLines,
  });
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.009,
      ),
      child: TextFormField(
        minLines: minLines,
        maxLines: maxLines,

        style: styletext,
        controller: controller,
        obscureText: obscureText,
        validator:
            validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter $fieldName';
              }
              return null;
            },
        keyboardType: keyBordType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: vertical,
            horizontal: horizontal,
          ),

          enabledBorder: buildDecorionBorder(borderSideColor: borderSideColor),
          focusedBorder: buildDecorionBorder(borderSideColor: borderSideColor),
          errorBorder: buildDecorionBorder(borderSideColor: Colormanager.red),
          focusedErrorBorder: buildDecorionBorder(
            borderSideColor: Colormanager.red,
          ),
          hintText: hintext,
          hintStyle: hintTextStyle,
          labelText: lableText,
          labelStyle: lableTextStyle,
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
        ),
      ),
    );
  }
}

OutlineInputBorder buildDecorionBorder({required Color borderSideColor}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: borderSideColor, width: 2),
  );
}
