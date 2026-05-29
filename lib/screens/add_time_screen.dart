import 'dart:io';

import 'package:fintrack/data/week_data.dart';
import 'package:fintrack/database/fintrack_database.dart';
import 'package:fintrack/models/date_start_to_end_model.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:fintrack/widgets/set_date_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTimeScreen extends StatefulWidget {
  const AddTimeScreen({super.key});

  @override
  State<AddTimeScreen> createState() => _AddTimeScreenState();
}

class _AddTimeScreenState extends State<AddTimeScreen> {
  final totalAmountController = TextEditingController();
  final _dateKey = GlobalKey<FormState>();

  DateTime? startDate;
  DateTime? endDate;

  @override
  void dispose() {
    totalAmountController.dispose();
    super.dispose();
  }

void _addStartEndTime() async {
  if (startDate == null || endDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please select both dates")),
    );
    return;
  }

  if (!_validRange()) return;

  final amountIsValid = _dateKey.currentState!.validate();

  if (amountIsValid) {
    final period = DateStartToEndModel(
      startDate: startDate!,
      endDate: endDate!,
      amount: double.parse(totalAmountController.text),
    );

    await FintrackDatabase.insertPeriod(period);

    // Fetch updated weekData from the database
    final updatedPeriods = await FintrackDatabase.getPeriods();
    setState(() {
      weekData.clear();
      weekData.addAll(updatedPeriods);
    });

    if(!mounted) return;
    
    Navigator.pop(context);
  }
}

bool _validRange() {
  if (endDate != null && startDate != null && endDate!.isBefore(startDate!)) {
    if(Platform.isIOS){
      showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
        title: const Text('Invalid Date'),
        content: const Text('End date must be after start date'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ));
    }
    else if(Platform.isAndroid){
      showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid Date'),
        content: const Text('End date must be after start date'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    }
    return false;
  }
  return true;
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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
        child: Form(
          key: _dateKey,
          child: ListView(
            children: [
              SizedBox(height: context.screenHeight * 0.02),
              Text("Track your growth",
              style: TextTheme.of(context).titleLarge,),
              SizedBox(height: context.screenHeight * 0.01),
          
              Text("Add starting and ending dates.",
              style: TextTheme.of(context).bodySmall!.copyWith(
                color: Colors.black
              ),),
          
              SizedBox(height: context.screenHeight * 0.03,),
              SetDateContainer(descriptionText: "Starting Date",
              buttonDescription: "Pick a starting date",
              buttonColor: Theme.of(context).colorScheme.primaryContainer,
              dateSelected: (date) {
                startDate = date;
              },),
          
              SizedBox(height: context.screenHeight * 0.02),
              SetDateContainer(descriptionText: "Ending Date",
              buttonDescription: "Pick a ending date",
              buttonColor: Theme.of(context).colorScheme.secondaryContainer,
              dateSelected: (date) {
                endDate = date;
              },),
              SizedBox(height: context.screenHeight * 0.02),
          
              TextFormField(
                controller: totalAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Total Amount'
                ),

                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "If you don't have input 0";
                  }

                  if(double.parse(value.trim()) < 0){
                    return 'The amount cannot be negative';
                  }

                  return null;
                },
              ),
              SizedBox(height: context.screenHeight * 0.04),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                    SizedBox(width: context.screenWidth * 0.04),
          
                  ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)
                )
              ),
              onPressed: _addStartEndTime,
              child: Text("Ok", textAlign: TextAlign.center,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}