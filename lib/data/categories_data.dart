import 'package:fintrack/models/categories_model.dart';
import 'package:flutter/material.dart';

List <CategoriesModel> categoriesData = [
  const CategoriesModel(
    name: 'Add Amount',
    categoryIcon: Icon(Icons.add, size: 30,),
    iconColor: Colors.yellow
  ),

  const CategoriesModel(
    name: 'Food',
    categoryIcon: Icon(Icons.fastfood_outlined, size: 30,),
    iconColor: Colors.red
  ),
  const CategoriesModel(
    name: 'Transport',
    categoryIcon: Icon(Icons.directions_car_outlined, size: 30,),
    iconColor: Colors.purple
  ),
  const CategoriesModel(
    name: 'Shopping',
    categoryIcon: Icon(Icons.shopping_bag_outlined, size: 30,),
    iconColor: Colors.blue
  ),
  const CategoriesModel(
    name: 'Entertainment',
    categoryIcon: Icon(Icons.gamepad_outlined, size: 30,),
    iconColor: Colors.orange
  ),
  const CategoriesModel(
    name: 'Health',
    categoryIcon: Icon(Icons.health_and_safety_outlined, size: 30,),
    iconColor: Colors.green
  ),

  const CategoriesModel(
    name: 'Bills',
    categoryIcon: Icon(Icons.receipt_outlined, size: 30,),
    iconColor: Colors.brown
  ),

  const CategoriesModel(
    name: 'Others',
    categoryIcon: Icon(Icons.more_horiz, size: 30,),
    iconColor: Color.fromARGB(255, 19, 142, 158)
  ),
];