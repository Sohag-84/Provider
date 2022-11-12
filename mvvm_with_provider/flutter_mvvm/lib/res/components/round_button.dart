// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/colors.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isLoading;
  const RoundButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  title,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ),
      ),
    );
  }
}
