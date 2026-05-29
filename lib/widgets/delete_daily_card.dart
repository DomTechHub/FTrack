import 'package:fintrack/data/expenses_data.dart';
import 'package:fintrack/models/expense_model.dart';
import 'package:flutter/material.dart';

class DeleteDailyCard extends StatelessWidget {
  const DeleteDailyCard({super.key, required this.selectedExpense, required this.onDelete});
  final void Function() onDelete;
  final ExpenseModel selectedExpense;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              title: Text('Delete Expense'),
              content: Text('Are you sure you want to delete this expense?'),
              actions: [
                TextButton(onPressed: (){Navigator.pop(context);}, child: Text('No')),
                TextButton(
                  onPressed: (){
                  
                    // Use removeWhere to safely delete items from the list
                expensesData.remove(selectedExpense);

                onDelete();
           
                    
                  Navigator.pop(context);
                }, child: Text('Yes')),
              ],
            );
  }
}