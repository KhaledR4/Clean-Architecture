import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

List<String> monthNames = List.generate(12, (index) => DateFormat.MMMM().format(DateTime(2000, index + 1)));
const Map<String, int> daysInMonthMap = {
    'January': 31,
    'February': 29,
    'March': 31,
    'April': 30,
    'May': 31,
    'June': 30,
    'July': 31,
    'August': 31,
    'September': 30,
    'October': 31,
    'November': 30,
    'December': 31,
  };



class DatePicker extends StatelessWidget {
  final RxString year;
  final RxString month;
  final RxString day;
  const DatePicker({super.key, required this.day, required this.month, required this.year});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Month'),
            value: monthNames[0],
            items: monthNames.map((month) => DropdownMenuItem<String>(value: month, child: Text(month),)).toList(),
            onChanged: (value) { month.value = value!;},
          )
        ),

        const SizedBox(width: 10,),

        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Day'),
            value: "1",
            items: List.generate(daysInMonthMap[month.value]!, (index) => DropdownMenuItem<String>(value: (index + 1).toString(), child: Text((index + 1).toString()),)).toList(),
            onChanged: (value) { day.value = value!;},
          )
        ),

        const SizedBox(width: 10,),

        Expanded(
          child: DropdownButtonFormField<String>(
            value: DateTime.now().year.toString(),
            items: List.generate(100, (index) => DropdownMenuItem<String>(value: (DateTime.now().year - index).toString(), child: Text('${DateTime.now().year - index}'))),
            onChanged: (value) { year.value = value!;},
            decoration: const InputDecoration(labelText: 'Year',),),
        ),
      ],
    );
  }
}