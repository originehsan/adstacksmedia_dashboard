import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> card = [
    BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 8,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> sidebar = [
    BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 12,
      offset: Offset(2, 0),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> dropdown = [
    BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 16,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> floating = [
    BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 24,
      offset: Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> hover = [
    BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];
}