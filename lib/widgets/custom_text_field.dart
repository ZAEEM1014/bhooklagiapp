import 'package:flutter/material.dart';
import 'package:bhooklagiapp/app/theme/theme.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  const AppTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
    );
  }
}
