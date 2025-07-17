import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color textColor;
  final Color bgColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.icon,
    required this.label,
    required this.textColor,
    required this.bgColor,
    required this.borderColor,
    this.borderWidth = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: icon,
      label: Text(
        label,
        style: TextStyle(fontSize: 16, color: textColor),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        side: BorderSide(color: borderColor, width: borderWidth),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
