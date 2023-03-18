import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Widget? cardChild;
  final VoidCallback? onPress;
  final double cardMargin;
  final double cardPaddinng;
  final double cardWidth;
  final double cardHeight;

  const ReusableCard({
    super.key,
    required this.colour,
    this.cardChild,
    this.onPress,
    this.cardMargin = 10,
    this.cardPaddinng = 0,
    this.cardWidth = 100,
    this.cardHeight = 100,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colour,
          ),
          margin: EdgeInsets.all(cardMargin),
          padding: EdgeInsets.only(top: cardPaddinng, bottom: cardPaddinng),
          child: cardChild,
        ),
      ),
    );
  }
}
