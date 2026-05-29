import 'package:fintrack/utils/responsive.dart';
import 'package:flutter/material.dart';

class AddTimeContainer extends StatelessWidget {
  const AddTimeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorScheme.of(context).secondaryContainer
              ),
              height: context.screenHeight * 0.15,
              width: double.infinity,
              padding: EdgeInsets.only(left: context.screenWidth * 0.05),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 3),
                    shape: BoxShape.circle
                  ),
                  
                  child: Center(child: Icon(Icons.add, color: Colors.white,))),
                  SizedBox(height: context.screenHeight * 0.01,),
              
                Text('Add a new starting date',
                style: TextTheme.of(context).bodySmall,),
                SizedBox(height: context.screenHeight * 0.01,),
                Text('Quickly track your spending',
                style: TextTheme.of(context).bodySmall,)
              ],),
            );
  }
}