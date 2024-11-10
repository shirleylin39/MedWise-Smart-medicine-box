import 'package:flutter/material.dart';
import '../buttons/buttons.dart';

class TimeSelector extends StatefulWidget {
  final TimeOfDay? layerTime;
  final Function(TimeOfDay) newLayerTime;

  const TimeSelector({
    super.key,
    this.layerTime,
    required this.newLayerTime
  });

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}
class _TimeSelectorState extends State<TimeSelector> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.layerTime;
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: const Color(0xFFFFE149),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE55733),
              onPrimary: Color(0xFFFFFFE9),
              surface: Color(0xFFE55733),
              onSurface: Color(0xFF191717),
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: const Color(0xFFFFFFE9),
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0xFF191717), width:1.5),
              ),
              hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? const Color(0xFF191717)
                  : const Color(0xFF191717).withOpacity(0.4)),
              hourMinuteTextStyle: const TextStyle(
                fontSize: 44,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w800,
                color: Color(0xFF191717),
              ),
              hourMinuteColor: const Color(0xFFFFFFE9),
              dayPeriodBorderSide: const BorderSide(color: Color(0xFF191717), width:1.5),
              dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? const Color(0xFF191717)
                  : const Color(0xFF191717).withOpacity(0.4)),
              dayPeriodTextStyle: const TextStyle(
                fontSize: 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color: Color(0xFF191717),
              ),
              dayPeriodColor: const Color(0xFFFFFFE9),
              dialHandColor: const Color(0xFFE55733),
              dialBackgroundColor: const Color(0xFFFFE149).withOpacity(0.3),
              entryModeIconColor: const Color(0xFF191717),
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
                fontSize: 20,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color: Color(0xFF191717),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
      widget.newLayerTime(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = selectedTime != null
        ? selectedTime!.format(context)
        : 'Select Time';

    return SmallBoxButton(
        text: formattedTime,
        onPressed: () => selectTime(context),
        isSelected: false
    );
  }
}
