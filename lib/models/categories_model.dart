import 'package:flutter/material.dart';

class CategoriesModel {
  const CategoriesModel({
    required this.name,
    required this.categoryIcon,
    required this.iconColor
  });

  final String name;
  final Icon categoryIcon;
  final Color iconColor;
}