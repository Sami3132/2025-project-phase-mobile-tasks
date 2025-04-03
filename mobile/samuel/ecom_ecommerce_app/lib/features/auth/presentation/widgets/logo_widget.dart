import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double fontSize;
  final bool isOutlined;
  final EdgeInsets? padding;
  final double? borderRadius;

  const LogoWidget({
    super.key,
    this.fontSize = 24,
    this.isOutlined = false,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: isOutlined
            ? Border.all(
                color: Theme.of(context).primaryColor,
                width: 1.5,
              )
            : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      child: Text(
        'Ecom',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'CaveatBrush',
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
} 