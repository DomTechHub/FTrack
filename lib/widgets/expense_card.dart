import 'package:fintrack/models/expense_model.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense});
  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: double.infinity,
          height: context.screenHeight * 0.07,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.04, vertical: context.screenHeight * 0.007),
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // ignore: deprecated_member_use
                      color: expense.category.iconColor.withValues(alpha: 0.3)
                    ),
                    width: context.screenWidth * 0.15,
                    height: double.infinity,
                  
                    child: Center(
                      child: expense.category.categoryIcon
                    ),
                  ),
                ),
                SizedBox(width: context.screenWidth * 0.03),
        
                Expanded(
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(expense.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.screenHeight * 0.02),),
                          
                        Text('${expense.time.hour} : ${expense.time.minute}',),
                      
                    ],
                  ),
                  
                  Column(
                    children: [
                      Text(expense.category.name == "Add Amount" ? "+ ₵ ${expense.amount.toStringAsFixed(2)}" 
                      : "- ₵ ${expense.amount.toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: expense.category.iconColor
                        ),
                        child: Text(expense.category.name,
                        style: TextStyle(fontSize: context.screenHeight * 0.017, color: Colors.white),),
                      )
                    ],
                  )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        SizedBox(height: context.screenHeight * 0.015,)
      ],
    );
  }
}