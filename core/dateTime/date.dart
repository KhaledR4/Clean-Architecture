import 'package:intl/intl.dart';

class Date{
  late final DateTime _dateTime;

  Date({required year, required month, required day}){
    String neededYear;
    String neededMonth;
    String neededDay;
    DateFormat dateFormat;

    neededDay = day is int ? day.toString() : day;
    neededYear = year is int ? year.toString() : year;
    neededMonth = month is int ? month.toString() : month;
    dateFormat = month is int ? DateFormat('yyyy M d') : DateFormat('yyyy MMMM d');
    final String dateString = "$neededYear $neededMonth $neededDay";
    _dateTime = dateFormat.parse(dateString);
  }

  String formatDate(){
    return DateFormat('dd-MM-yyyy').format(_dateTime);
  }


}