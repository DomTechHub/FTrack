import 'package:fintrack/data/week_data.dart';
import 'package:fintrack/models/date_start_to_end_model.dart';
import 'package:flutter/material.dart';

class DeleteDateWidget extends StatelessWidget {
  const DeleteDateWidget({super.key, required this.selectedWeek, required this.onDelete});
  final DateStartToEndModel selectedWeek;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              title: Text('Delete Period'),
              content: Text('Are you sure you want to delete this period?'),
              actions: [
                TextButton(onPressed: (){Navigator.pop(context);}, child: Text('No')),
                TextButton(
                  onPressed: (){
                  
                    // Use removeWhere to safely delete items from the list
                weekData.remove(selectedWeek);

                onDelete();
           
                    
                  Navigator.pop(context);
                }, child: Text('Yes')),
              ],
            );
  }
}