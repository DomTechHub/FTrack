import 'package:fintrack/models/date_start_to_end_model.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:flutter/material.dart';

class PeriodTotalContainer extends StatelessWidget {
  const PeriodTotalContainer({super.key, required this.period, required this.expenses});
  final DateStartToEndModel period;
  final List expenses;

  @override
  Widget build(BuildContext context) {

    final total = PeriodCalculator.calculatePeriodTotal(
      expenses: expenses,
      period: period
    );

    final totalIncome = total['income'] ?? 0;
final totalSpending = total['spending'] ?? 0;
final balance = total['balance'] ?? 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.03),
      child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorScheme.of(context).primaryContainer
                ),
                height: context.screenHeight * 0.13,
                width: double.infinity,
                padding: EdgeInsets.only(left: context.screenWidth * 0.05),
      
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Total Amount',
                    style: TextTheme.of(context).bodySmall!.copyWith(
                      fontWeight: FontWeight.w900
                    ))),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text( '₵ ${totalIncome.toStringAsFixed(2)}',
                    style: TextTheme.of(context).bodySmall!.copyWith(
                      fontWeight: FontWeight.bold
                    ))),
                    SizedBox(height: context.screenHeight * 0.01,),
                
                  Row(
                    children: [
                      Icon(Icons.arrow_upward, color: Colors.white,),
                      Text('₵ ${balance.toStringAsFixed(2)}',
                      style: TextTheme.of(context).bodySmall!.copyWith(
                      fontWeight: FontWeight.bold
                    )),
                      SizedBox(width: context.screenWidth * 0.07,),

                      Icon(Icons.arrow_downward, color: Colors.white,),
                      Text('₵ ${totalSpending.toStringAsFixed(2)}',
                      style: TextTheme.of(context).bodySmall!.copyWith(
                      fontWeight: FontWeight.bold
                    )),
                    ],
                  )
                ],),
              ),
    );
  }
}




class PeriodCalculator{

  static Map<String, double> calculatePeriodTotal({
    required List expenses,
    required DateStartToEndModel period
  }){

    double totalSpending = 0;
    double totalIncome = period.amount;

    for (var expense in expenses){
       if (expense.periodId != period.id) continue;

      final category = expense.category;
      final amount = expense.amount;

      if(category.name == 'Add Amount'){
        totalIncome += amount;
      }
      else{
        totalSpending += amount;
      }  
    }
    final balance = totalIncome - totalSpending;

    return {
      'income': totalIncome,
      'spending': totalSpending,
      'balance': balance,
    };
  }
 
}