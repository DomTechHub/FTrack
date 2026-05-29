import 'package:fintrack/models/categories_model.dart';
import 'package:flutter/material.dart';

class CategoryGridContainer extends StatelessWidget {
  const CategoryGridContainer({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap});

  final CategoriesModel category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        
        backgroundColor: isSelected ? Theme.of(context).colorScheme.primaryContainer
        : Colors.grey.shade200,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: EdgeInsets.zero
      ),
    
      onPressed: onTap,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            category.categoryIcon,
            Text(category.name)
          ],
        ),
      ),
    );
  }
}