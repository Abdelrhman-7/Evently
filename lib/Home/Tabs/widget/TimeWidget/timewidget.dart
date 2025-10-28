import 'package:evently/core/colormanager.dart';
import 'package:flutter/material.dart';

class Timewidget extends StatelessWidget {
  const Timewidget({
    super.key,
    required this.text,
    required this.image,
    //required this.chooseText,
    required this.onChooseEventOrDate,
    this.chooseDateOrTime,
  });

  final String text;
  // final String chooseText;
  final String image;
  final VoidCallback onChooseEventOrDate;
  final String? chooseDateOrTime;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final textStyle = TextStyle(
      color: Theme.of(context).disabledColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Row(
        children: [
          Image.asset(image, color: Theme.of(context).disabledColor),
          SizedBox(width: width * 0.04),
          Text(text, style: textStyle),
          const Spacer(),
          TextButton(
            onPressed: () {
              onChooseEventOrDate();
            },
            child: Text(
              chooseDateOrTime!,
              style: TextStyle(
                color: Colormanager.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
