import 'package:fintrack/utils/responsive.dart';
import 'package:flutter/material.dart';

class SpendingContainer extends StatefulWidget {
  const SpendingContainer({super.key});

  @override
  State<SpendingContainer> createState() => _SpendingContainerState();
}

class _SpendingContainerState extends State<SpendingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorScheme.of(context).primaryContainer
              ),
              height: context.screenHeight * 0.15,
              width: double.infinity,
              padding: EdgeInsets.only(left: context.screenWidth * 0.05),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Total Amount',
                  style: TextTheme.of(context).bodySmall)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Amount: Will Change',
                  style: TextTheme.of(context).bodySmall,)),
                  SizedBox(height: context.screenHeight * 0.01,),
              
                Row(
                  children: [
                    Icon(Icons.arrow_upward, color: Colors.white,),
                    Text('Amount',
                    style: TextTheme.of(context).bodySmall,),
                    SizedBox(width: context.screenWidth * 0.07,),
                    Icon(Icons.arrow_downward, color: Colors.white,),
                    Text('Amount',
                    style: TextTheme.of(context).bodySmall,),
                  ],
                )
              ],),
            );
  }
}