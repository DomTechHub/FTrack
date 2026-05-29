import 'package:fintrack/data/months_data.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:flutter/material.dart';

class SetDateContainer extends StatefulWidget {
  const SetDateContainer({super.key,
  required this.descriptionText,
  required this.buttonDescription,
  required this.buttonColor,
  required this.dateSelected});

  final String descriptionText;
  final String buttonDescription;
  final Color buttonColor;
  final void Function (DateTime) dateSelected;

  @override
  State<SetDateContainer> createState() => _SetDateContainerState();
}

class _SetDateContainerState extends State<SetDateContainer> {

   DateTime? _selectedDate;
 
 DateTime firstDate = DateTime.now().subtract(Duration(days: 366));
 DateTime lastDate = DateTime.now().add(Duration(days: 366));

 void _pickedDate() async {
  final picked = await showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate);

  if(picked != null){
    setState(() {
      _selectedDate = picked;
    });

    widget.dateSelected(picked);
  }
 }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.03, vertical: context.screenHeight * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        width: double.infinity,
        height: context.screenHeight * 0.13,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.buttonColor.withValues(alpha: 0.7)
              ),
              height: 40,
              width: 40,
              child: Icon(Icons.calendar_month, color: const Color.fromARGB(150, 0, 0, 0),),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                Text(widget.descriptionText,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),),

                //${_selectedDate!.day} / ${_selectedDate!.month} / ${_selectedDate!.year}
                Text(_selectedDate == null ? "Date" : '${monthsData[_selectedDate!.month - 1]} ${_selectedDate!.day}, ${_selectedDate!.year}',
                style: TextTheme.of(context).bodySmall!.copyWith(color: Colors.black)),
          ],
        ),

        SizedBox(
          height: context.screenHeight * 0.07,
          width: context.screenWidth * 0.35,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: widget.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5)
              )
            ),
            onPressed: _pickedDate,
            child: Text(widget.buttonDescription, textAlign: TextAlign.center,)),
        )
          ]
      ),)
    );
  }
}