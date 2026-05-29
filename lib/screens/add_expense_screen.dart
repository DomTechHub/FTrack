import 'package:fintrack/data/categories_data.dart';
import 'package:fintrack/database/fintrack_database.dart';
import 'package:fintrack/models/categories_model.dart';
import 'package:fintrack/models/date_start_to_end_model.dart';
import 'package:fintrack/models/expense_model.dart';
import 'package:fintrack/services/notification_service.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:fintrack/widgets/category_grid_container.dart';
import 'package:fintrack/widgets/expense_text_input_widget.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key, required this.activeDay, required this.currentPeriod});
  final DateTime activeDay;
  final DateStartToEndModel currentPeriod;

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _expenseAmountController = TextEditingController(text: "0.00");
  final _expenseKey = GlobalKey<FormState>();
  int selectedIndex = -1;
  CategoriesModel? selectedCategory;

  @override
  void dispose() {
    _expenseAmountController.dispose();
      _expenseNameController.dispose();
    super.dispose();
  }

  Future<void> _addExpenseButton() async {
    final isValid = _expenseKey.currentState!.validate();

    if(isValid){

      if(selectedCategory == null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please select a category"))
        );
        return;
      }

      final parsedAmount = double.tryParse(_expenseAmountController.text.trim());

if (parsedAmount == null || parsedAmount <= 0) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Enter a valid amount')),
  );
  return;
}

      final newExpense = ExpenseModel(
      name: _expenseNameController.text.trim(),
      amount: parsedAmount,
      category: selectedCategory!,
      date: widget.activeDay,
      periodId: widget.currentPeriod.id!,
      time: DateTime.now()
      );

    await FintrackDatabase.insertExpense(
  name: newExpense.name,
  amount: newExpense.amount,
  category: newExpense.category.name,
  date: newExpense.date,
  time: newExpense.time,
  periodId: widget.currentPeriod.id!,
);

await NotificationService.showNotification(
  title: 'Expense Added',
  body: '₵${parsedAmount.toStringAsFixed(2)} added successfully',);

  if(!mounted) return;
  
      Navigator.pop(context);
    }
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("FTrack",
        style: TextTheme.of(context).titleMedium,),

        Text('Add Expense',
           style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.tertiary),)
          ],
        )
      ),
      
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05, vertical: context.screenHeight * 0.02),
          child: Form(
            key: _expenseKey,
            child: ListView(
              children: [
                Text("ENTER AMOUNT",
                style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.7), fontWeight: FontWeight.bold),),
            
                 SizedBox(height: context.screenHeight * 0.02),
            
                              ExpenseTextInputWidget(
                            controller: _expenseAmountController,
                            borderDesign: InputBorder.none,
                            inputAlign: TextAlign.center,
                            inputColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.7),
                            inputSize: 40,
                            inputWeight: FontWeight.bold,
                            keyboardType: TextInputType.number,
                            boxFill: false,
                            validator: (value) {
                                if(value == null || value.isEmpty){
                                  return 'Please enter the amount';
                                }
            
                                final parsedAmount = double.tryParse(value.trim());
            
                                if(parsedAmount == null){
                                  return 'Please enter a valid number';
                                }
                          
                                if(parsedAmount <= 0){
                                  return 'Amount cannot be less than ₵ 0';
                                }
                          
                                return null;
                              },),
            
                  SizedBox(height: context.screenHeight * 0.01),
            
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.03, vertical: context.screenHeight * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    width: double.infinity,
                    height: context.screenHeight * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expense Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: context.screenHeight * 0.01),
            
                        ExpenseTextInputWidget(
                          controller: _expenseNameController,
                          borderDesign: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          inputSize: 17,
                          inputColor: Colors.black,
                          inputAlign: TextAlign.left,
                          boxFill: true,
                          validator: (value) {
                                if(value == null || value.isEmpty){
                                  return 'Please enter an expense name';
                                }
                          
                                if(value.trim().length < 3){
                                  return 'Expense name must be at least 3 characters long';
                                }
                          
                                return null;
                              }
                          ),
            
                          SizedBox(height: context.screenHeight * 0.02),
            
                          Text("Select Category",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: context.screenHeight * 0.01),
            
                        Expanded(
                          child: GridView.builder(
                            itemCount: categoriesData.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: context.screenWidth * 0.04,
                              mainAxisSpacing: context.screenHeight * 0.01,
                              childAspectRatio: 1.5
                              ),
                            itemBuilder: (context, index){
                              return CategoryGridContainer(
                                key: ValueKey(categoriesData[index].name),
                                category: categoriesData[index],
                                isSelected: selectedIndex == index,
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    selectedCategory = categoriesData[index];
                                  });
                                },
                                );
                            }
                            ),
                        )
                      ],
                    ),
                  ),
            
                  TextButton(
                    onPressed: (){},
                    child: Text("Cancel")
                    ),
                  SizedBox(height: context.screenHeight * 0.005),
            
                  ElevatedButton.icon(
                    onPressed: _addExpenseButton,
            
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    icon: Icon(Icons.check_circle_outline, color: Colors.white,),
                    label: Text("Confirm Transaction"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}