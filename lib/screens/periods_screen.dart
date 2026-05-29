import 'package:fintrack/data/week_data.dart';
import 'package:fintrack/database/fintrack_database.dart';
import 'package:fintrack/screens/daily_breakdown_screen.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:fintrack/widgets/delete_date_widget.dart';
import 'package:fintrack/widgets/week_card_widget.dart';
import 'package:flutter/material.dart';

class PeriodsScreen extends StatefulWidget {
  const PeriodsScreen({super.key});
  

  @override
  State<PeriodsScreen> createState() => _PeriodsScreenState();
}

class _PeriodsScreenState extends State<PeriodsScreen> {

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPeriods();
  }

  Future<void> _loadPeriods() async {

    setState(() {
      isLoading = true;
    });

  final periods = await FintrackDatabase.getPeriods();

  setState(() {
    weekData.clear();
    weekData.addAll(periods);

    isLoading = false;
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

        title: Row(
          children: [
            Text("FTrack",
        style: TextTheme.of(context).titleMedium,),
        SizedBox(width: context.screenWidth * 0.1),

           Text('Dates Created',
           style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.tertiary),)
          ],
        ) 
      ),

      body:isLoading ?

        Center(
          child: CircularProgressIndicator(),
        ) 
  
      : weekData.isEmpty ? 
      Center(
        child: Text('No Period created',
        style: Theme.of(context).textTheme.titleLarge,),
      ) 

      : ListView(
        children: [
          for(var data in weekData)
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DailyBreakdownScreen(currentDate: data, currentPeriod: data,)));
              },
              onLongPress: () {
                showDialog(context: context, builder: (context) => DeleteDateWidget(selectedWeek: data,
                onDelete: ()async{
                    await FintrackDatabase.deletePeriod(data.id!);

  await _loadPeriods();
                }));
              },
              child: WeekCardWidget(weekDate: data))
        ],
      )
    );
  }
}