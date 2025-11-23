import 'package:evently/core/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextLocation extends StatelessWidget {
  final String image;
  final String text;
  final void Function()? onPressed;
  final DateTime? eventDateTime;

  const TextLocation({
    super.key,
    required this.image,
    required this.text,
    required this.onPressed,
    this.eventDateTime,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.08,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 2, color: Colormanager.blue),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.009,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image, height: height * 0.1, width: width * 0.1),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (eventDateTime != null)
                  Text(
                    DateFormat('d MMMM yyyy').format(eventDateTime!),
                    style: TextStyle(
                      color: Colormanager.blue,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colormanager.blue,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
