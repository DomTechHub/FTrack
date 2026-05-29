import 'package:flutter/material.dart';

class ExpenseTextInputWidget extends StatelessWidget {
  const ExpenseTextInputWidget({super.key,
  required this.controller,
  required this.validator,
  required this.borderDesign,
  required this.inputSize,
  required this.inputColor,
  required this.inputAlign,
  this.inputWeight = FontWeight.normal,
  this.keyboardType = TextInputType.text,
  required this.boxFill});

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final InputBorder borderDesign;
  final double inputSize;
  final Color inputColor;
  final TextAlign inputAlign;
  final FontWeight? inputWeight;
  final bool boxFill;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                  controller: controller,
                  textAlign: inputAlign,
                  style: TextStyle(
                    fontSize: inputSize,
                    color: inputColor,
                    fontWeight: inputWeight
                  ),
                  decoration: InputDecoration(
                    border: borderDesign,
                    filled: boxFill,
                    fillColor: Colors.grey.shade200,
                  ),
              
                  validator: validator
                );
  }
}