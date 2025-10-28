import 'package:flutter/material.dart';

class EventTabItem extends StatelessWidget {
  const EventTabItem({
    super.key,
    required this.eventName,
    required this.isSelected,
    required this.isSelectedColor,
    required this.isNotSelectedColor,
    required this.backGround,
    required this.borderColor,
  });

  final String eventName;
  final bool isSelected;
  final Color isSelectedColor;
  final Color isNotSelectedColor;
  final Color backGround;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),

      decoration: BoxDecoration(
        color: isSelected ? backGround : Colors.transparent,
        borderRadius: BorderRadius.circular(46),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Row(
        children: [
          Text(
            eventName,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? isSelectedColor : isNotSelectedColor,
            ),
          ),
        ],
      ),
    );
  }
}
