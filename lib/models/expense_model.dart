import 'package:fintrack/models/categories_model.dart';

class ExpenseModel {
  const ExpenseModel({
    required this.name,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    this.id,
    required this.periodId
  });


  final String name;
  final double amount;
  final CategoriesModel category;
  final DateTime date;
  final DateTime time;
  final int? id;
  final int periodId;
}