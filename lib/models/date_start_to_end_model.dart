class DateStartToEndModel {
  const DateStartToEndModel({
    required this.startDate,
    required this.endDate,
    required this.amount,
    this.id
  });

  final int? id;
  final DateTime startDate;
  final DateTime endDate;
  final double amount;


  int get days => endDate.difference(startDate).inDays + 1;
}