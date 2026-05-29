import 'package:fintrack/data/days_data.dart';
import 'package:fintrack/models/date_start_to_end_model.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:flutter/material.dart';

class WeekCardWidget extends StatefulWidget {
  const WeekCardWidget({super.key, required this.weekDate});
  final DateStartToEndModel weekDate;

  @override
  State<WeekCardWidget> createState() => _WeekCardWidgetState();
}

class _WeekCardWidgetState extends State<WeekCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
      child: Card(
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primaryContainer,
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
              Text('${widget.weekDate.startDate.day} / ${widget.weekDate.startDate.month} / ${widget.weekDate.startDate.year} - ${widget.weekDate.endDate.day} / ${widget.weekDate.endDate.month} / ${widget.weekDate.endDate.year}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primaryContainer),),
              Text('${daysData[widget.weekDate.startDate.weekday - 1]} - ${daysData[widget.weekDate.endDate.weekday - 1]}'),
                ],
              ),
              SizedBox(width: context.screenWidth * 0.07),
          
              Text('₵ ${widget.weekDate.amount.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(width: context.screenWidth * 0.03),
      
              Icon(Icons.arrow_forward_ios_rounded, size: 15,)
            ],
          ),
        )
        
      
      ),
    );
  }
}