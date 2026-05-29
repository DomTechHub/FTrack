import 'package:fintrack/data/days_data.dart';
import 'package:fintrack/data/months_data.dart';
import 'package:fintrack/models/date_start_to_end_model.dart';
import 'package:fintrack/screens/daily_expenses_screen.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:fintrack/widgets/daily_total_container.dart';
import 'package:flutter/material.dart';

class DailyCardWidget extends StatefulWidget {
  const DailyCardWidget({super.key, required this.day, required this.onReturn, required this.currentPeriod, required this.expenses});
  final DateTime day;
  final VoidCallback onReturn;
  final DateStartToEndModel currentPeriod;
  final List expenses;


  @override
  State<DailyCardWidget> createState() => _DailyCardWidgetState();
}

class _DailyCardWidgetState extends State<DailyCardWidget> {
  @override
  Widget build(BuildContext context) {

    final total = DailyCalculator.getCategoryTotalPerDay(
      expenses: widget.expenses,
      selectedDay: widget.day
    );

    final usedAmount =
    total.values.fold(0.0, (sum, item) => sum + item);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
      child: GestureDetector(
        onTap: () async{
          await Navigator.push(context, MaterialPageRoute(builder: (context) => DailyExpensesScreen(currentDay: widget.day, currentPeriod: widget.currentPeriod,)));
          widget.onReturn();
        },
        child: Card(
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  blurRadius: 0,
                  offset: Offset(-8, 0)
                )
              ]
            ),
            width: double.infinity,
            height: context.screenHeight * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                Text('${monthsData[widget.day.month - 1]} ${widget.day.day}, ${widget.day.year}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primaryContainer),),
                Text(daysData[widget.day.weekday - 1]),
                  ],
                ),
                SizedBox(width: context.screenWidth * 0.07),
            
                Text('₵ ${usedAmount.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(width: context.screenWidth * 0.03),
        
                Icon(Icons.arrow_forward_ios_rounded, size: 15,)
              ],
            ),
          )
          
        
        ),
      ),
    );
  }
}