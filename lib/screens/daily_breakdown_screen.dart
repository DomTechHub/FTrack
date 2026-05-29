import 'package:fintrack/database/fintrack_database.dart';
import 'package:fintrack/models/date_start_to_end_model.dart';
import 'package:fintrack/models/expense_model.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:fintrack/widgets/daily_card_widget.dart';
import 'package:fintrack/widgets/period_total_container.dart';
import 'package:flutter/material.dart';

class DailyBreakdownScreen extends StatefulWidget {
  const DailyBreakdownScreen({super.key, required this.currentDate, required this.currentPeriod});
  final DateStartToEndModel currentDate, currentPeriod;
  

  @override
  State<DailyBreakdownScreen> createState() => _DailyBreakdownScreenState();
}

class _DailyBreakdownScreenState extends State<DailyBreakdownScreen> {

  List<ExpenseModel> expenses = [];

    @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {

    final loadedExpenses =
        await FintrackDatabase.getExpenses();

    setState(() {
      expenses = loadedExpenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
        icon: Icon(Icons.arrow_back_ios)),

        title: Text("FTrack",
        style: TextTheme.of(context).titleMedium,),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(),
      
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05, vertical: context.screenHeight * 0.01),
            child: Text('Daily Breakdown',
            style: TextStyle(fontWeight: FontWeight.bold),),
          ),
      
          PeriodTotalContainer(period: widget.currentPeriod, expenses: expenses),
          SizedBox(height: context.screenHeight * 0.01,),
      
          Expanded(
            child: ListView.builder(
              itemCount: widget.currentDate.days,
              itemBuilder: (context, index){
                final currentDay = widget.currentDate.startDate.add(Duration(days: index));
                return DailyCardWidget(day: currentDay, currentPeriod: widget.currentPeriod, expenses: expenses,
                onReturn: () async {
                  await _loadExpenses();
                });
              }),
          )
        ],
      ),
    );
  }
}