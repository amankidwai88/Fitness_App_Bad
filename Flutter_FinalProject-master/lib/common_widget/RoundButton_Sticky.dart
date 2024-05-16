import 'package:crud/common/color_extension.dart';
import 'package:flutter/material.dart';

enum StickyButtonType { bgGradient, bgSGradient, textGradient }

class StickyButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double bottomPadding;

  const StickyButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.bottomPadding = 0.0, // Adjust the bottom padding as needed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottomPadding,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: TColor.primaryG, // Using primary gradient from color extension
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: MaterialButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textColor: TColor.divider,//Colors.white, // Using primary text color from color extension
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}