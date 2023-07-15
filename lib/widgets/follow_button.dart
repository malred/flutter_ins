import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String text;
  const FollowButton({
    super.key,
    this.function,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          height: 27,
        ),
        onPressed: function,
      ),
    );
  }
}
