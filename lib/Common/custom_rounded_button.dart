import 'package:flutter/material.dart';

class CustomRoundButton extends StatelessWidget {
  final IconData? buttonIcon;
  final Color buttonColor;
  final Color buttonIconColor;
  final VoidCallback? onPress;
  final double buttonIconSize;
  final double buttonWidth;
  final double buttonHeight;
  const CustomRoundButton({
    super.key,
    this.buttonColor = const Color(0xFF4C4F5E),
    this.buttonIcon,
    this.buttonIconColor = Colors.black,
    this.onPress,
    this.buttonIconSize = 30,
    this.buttonWidth = 56.0,
    this.buttonHeight = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(
        width: buttonWidth,
        height: buttonHeight,
      ),
      shape: const CircleBorder(),
      fillColor: buttonColor,
      textStyle: const TextStyle(color: Colors.black),
      onPressed: onPress,
      child: Icon(
        buttonIcon,
        color: buttonIconColor,
        size: buttonIconSize,
      ),
    );
  }
}
