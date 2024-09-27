import 'package:fast_location/src/shared/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, 
          padding: const EdgeInsets.symmetric(vertical: 16.0), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), 
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.white),
        ),
      ),
    );
  }
}
