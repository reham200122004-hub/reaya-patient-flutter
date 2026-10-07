import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.warmDarkGray,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.warmDarkGray,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.warmDarkGray,
  );

  static const TextStyle bodyRegular = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodyBold = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.warmDarkGray,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 12,
    color: AppColors.textMuted,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
}
