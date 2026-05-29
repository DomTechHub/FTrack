import 'package:fintrack/models/categories_model.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:flutter/material.dart';

class DailyTotalContainer extends StatelessWidget {
  const DailyTotalContainer({super.key, required this.currentDay, required this.expenses});
  final DateTime currentDay;
  final List expenses;

  @override
  Widget build(BuildContext context) {

    final total = DailyCalculator.getCategoryTotalPerDay(
      expenses: expenses,
      selectedDay: currentDay
    );

    final usedAmount =
    total.values.fold(0.0, (sum, item) => sum + item);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      width: double.infinity,
      height: context.screenHeight * 0.1,
      padding: EdgeInsets.only(left: context.screenWidth * 0.03),

      child: Column(
        children: [
          SizedBox(height: context.screenHeight * 0.01,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Daily Total',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('₵ ${usedAmount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),),
          ),
        ],
      ),
    );
  }
}



class DailyCalculator{
  static Map<CategoriesModel, double> getCategoryTotalPerDay({
    required List expenses,
    required DateTime selectedDay
  }){
    final dailyTotal = <CategoriesModel, double>{};

    for (var expense in expenses){
      final date = expense.date;

      final sameDay = date.day == selectedDay.day &&
      date.month == selectedDay.month &&
      date.year == selectedDay.year;

      if (!sameDay) continue;

      final categoryName = expense.category;

      if(categoryName.name == 'Add Amount') continue;
      final amount = expense.amount;

      dailyTotal[categoryName] = (dailyTotal[categoryName] ?? 0) + amount;
    }

    return dailyTotal;
  }
}