import 'package:fintrack/data/days_data.dart';
import 'package:fintrack/data/months_data.dart';
import 'package:fintrack/database/fintrack_database.dart';
import 'package:fintrack/models/date_start_to_end_model.dart';
import 'package:fintrack/models/expense_model.dart';
import 'package:fintrack/screens/add_expense_screen.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:fintrack/widgets/daily_category_total_container.dart';
import 'package:fintrack/widgets/daily_total_container.dart';
import 'package:fintrack/widgets/delete_daily_card.dart';
import 'package:fintrack/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class DailyExpensesScreen extends StatefulWidget {
  const DailyExpensesScreen({super.key, required this.currentDay, required this.currentPeriod});
  final DateTime currentDay;
  final DateStartToEndModel currentPeriod;

  @override
  State<DailyExpensesScreen> createState() => _DailyExpensesScreenState();
}

class _DailyExpensesScreenState extends State<DailyExpensesScreen> {

  List <ExpenseModel> expenses = [];

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

      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpenseScreen(activeDay: widget.currentDay, currentPeriod: widget.currentPeriod)));
            await _loadExpenses();
          },
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: Colors.white),
        ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
        child: ListView(
          children: [
            Text(daysData[widget.currentDay.weekday - 1],
            style: TextTheme.of(context).titleMedium!.copyWith(fontSize: 17)),

            Text('${monthsData[widget.currentDay.month - 1]} ${widget.currentDay.day}, ${widget.currentDay.year}',
            style: TextTheme.of(context).titleLarge),
            SizedBox(height: context.screenHeight * 0.02,),

            DailyTotalContainer(currentDay: widget.currentDay, expenses: expenses,),

            


            for (var expense in expenses.where(
              // ignore: unnecessary_null_comparison
              (expense) => expense.date != null && expense.date.day == widget.currentDay.day && 
              expense.date.month == widget.currentDay.month && 
              expense.date.year == widget.currentDay.year))
              GestureDetector(
                onLongPress: () {
          showDialog(context: context, builder: (context) => DeleteDailyCard(selectedExpense: expense,
          onDelete: () async {
          await FintrackDatabase.deleteExpense(expense.id!);

          await _loadExpenses();
          }));
        },
                child: ExpenseCard(expense: expense)),


          Text("Category Breakdown",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          SizedBox(height: context.screenHeight * 0.01,),

          DailyCategoryTotalContainer(currentDay: widget.currentDay, expenses: expenses,),
          ],
        ),
      ),
      
      );
  }
}