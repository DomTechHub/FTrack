import 'package:fintrack/models/categories_model.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:flutter/material.dart';

class DailyCategoryTotalContainer extends StatelessWidget {
  const DailyCategoryTotalContainer({super.key, required this.currentDay, required this.expenses});
  final DateTime currentDay;
  final List expenses;

  @override
  Widget build(BuildContext context) {

    final total = ExpenseCalculator.getCategoryTotalPerDay(
      expenses: expenses,
      selectedDay: currentDay
    );

    final totalAmount =
    total.values.fold(0.0, (sum, item) => sum + item);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      width: double.infinity,
      child: Column(
        children: total.entries.map((category){
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(category.key.name,
                  style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('₵ ${category.value.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),

              SizedBox(height: context.screenHeight * 0.01,),

              LayoutBuilder(
                builder: (context, constraints) {
                  final percentage =
        totalAmount == 0 ? 0 : category.value / totalAmount;
                  return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
                  height: 7,
                  width: double.infinity,
                
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      color: category.key.iconColor,
                      height: double.infinity,
                      width: constraints.maxWidth * percentage,
                    ),
                  ),
                );
                }
              ),
              SizedBox(height: context.screenHeight * 0.005,)
            ],
          );
        }).toList(),
      ),
    );
  }
}


class ExpenseCalculator{
  static Map<CategoriesModel, double> getCategoryTotalPerDay({
    required List expenses,
    required DateTime selectedDay
  }){
    final categoryTotal = <CategoriesModel, double>{};

    for (var expense in expenses){
      final date = expense.date;

      final sameDay = date.day == selectedDay.day &&
      date.month == selectedDay.month &&
      date.year == selectedDay.year;

      if (!sameDay) continue;

      final categoryName = expense.category;
      final amount = expense.amount;

      categoryTotal[categoryName] = (categoryTotal[categoryName] ?? 0) + amount;
    }

    return categoryTotal;
  }
}