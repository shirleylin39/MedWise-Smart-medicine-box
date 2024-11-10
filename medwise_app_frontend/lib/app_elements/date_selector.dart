import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../buttons/buttons.dart';

class DateSelector extends StatefulWidget {
  final DateTime? startDate;
  final Function(DateTime) newStartDate;

  const DateSelector({
    super.key,
    this.startDate,
    required this.newStartDate
  });

  @override
  _DateSelectorState createState() => _DateSelectorState();
}
class _DateSelectorState extends State<DateSelector> {
  DateTime? selectedStartDate;

  @override
  void initState() {
    super.initState();
    selectedStartDate = widget.startDate?.toLocal();
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: const Color(0xFFFFFFE9),
            colorScheme: const ColorScheme.light(
                primary: Color(0xFFE55733),
                onPrimary: Color(0xFFFFFFE9),
                surface: Color(0xFFFFFFE9),
                onSurface: Color(0xFF191717)
            ),
            datePickerTheme: const DatePickerThemeData(
              headerHelpStyle: TextStyle(
                fontSize: 20,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color: Color(0xFF191717),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF191717),
                backgroundColor: const Color(0xFFFFE149),
                textStyle: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                alignment: Alignment.center,
              ),
            ),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontSize: 32,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w800,
                color: Color(0xFF191717),
              ),
              bodyLarge: TextStyle(
                fontSize: 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color:Color(0xFF191717),
              ),
              titleSmall: TextStyle(
                fontSize: 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color: Color(0xFF191717),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF191717)),
                borderRadius: BorderRadius.circular(10),
              ),
              labelStyle: const TextStyle(
                fontSize: 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color: Color(0xFF191717),
              ),
              hintStyle: TextStyle(
                fontSize: 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color: const Color(0xFF191717).withOpacity(0.5),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != selectedStartDate) {
      setState(() {
        selectedStartDate = pickedDate;
      });
      widget.newStartDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: 45,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFFFE9),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Color(0xFF191717)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                  left: 12,
                  top: 12,
                  child:Text(
                    selectedStartDate == null
                        ? 'Select start date'
                        : '${DateFormat('MM/dd/yy (EEE)').format(selectedStartDate!)} - ${DateFormat('MM/dd/yy (EEE)').format(selectedStartDate!.add(const Duration(days: 6)))}',
                    style: TextStyle(
                      color:  selectedStartDate == null
                          ? const Color(0xFF191717).withOpacity(0.5)
                          : const Color(0xFF191717),
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  )
              ),
            ]
        ),
        const SizedBox(
            width: 21
        ),
        CalendarButton(
          onPressed: () => selectDate(context),
        ),
      ],
    );
  }
}