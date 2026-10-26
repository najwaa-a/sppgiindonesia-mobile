import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Tombol kustom yang konsisten dengan tema SPPGIndonesia
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      );
    }

    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: backgroundColor ?? AppColors.primaryNavy, width: 1.5),
          foregroundColor: textColor ?? backgroundColor ?? AppColors.primaryNavy,
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryNavy,
        foregroundColor: textColor ?? Colors.white,
      ),
    );
  }
}
