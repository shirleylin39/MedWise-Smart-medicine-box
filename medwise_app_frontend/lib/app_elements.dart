import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'api_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'buttons.dart';
import 'package:http/http.dart' as http;


class ProgressChart extends StatelessWidget {
  final double progress;

  const ProgressChart({super.key,
    required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50,
        height: 50,
        child: Stack(
            alignment: Alignment.center,
            children:[
              PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: progress * 100,
                      color: const Color(0xFFE55733),
                      radius: 8,
                      title: '${(progress * 100).toStringAsFixed(1)}%',
                      titleStyle: const TextStyle(
                          color: Color(0xFF191717),
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.33,
                          height: 0
                      ),
                    ),
                    PieChartSectionData(
                      value: (1 - progress) * 100,
                      color: const Color(0xFF191717),
                      radius: 8,
                      title: '',
                    ),
                  ],
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 37,// Space in the middle
                ),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: Color(0xFF191717),
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.33,
                ),
              ),
            ]
        )
    );
  }
}

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


class BoxCalendar extends StatefulWidget {
  final String deviceID;
  final ValueChanged<DateTime>? onDaySelected;

  const BoxCalendar({
    super.key,
    required this.deviceID,
    this.onDaySelected,
  });

  @override
  _BoxCalendarState createState() => _BoxCalendarState();
}
class _BoxCalendarState extends State<BoxCalendar> {
  late Map<DateTime, List<String>> _events;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // 固定的 firstDay 和 lastDay
  final DateTime firstDay = DateTime(2010);
  final DateTime lastDay = DateTime(2050);

  @override
  void initState() {
    super.initState();
    _events = {};
    fetchBacklogByDevice(widget.deviceID);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: firstDay, // 使用固定值
          lastDay: lastDay,   // 使用固定值
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          eventLoader: (day) => _events[day] ?? [],
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            // 調用外部提供的回調函數
            if (widget.onDaySelected != null) {
              widget.onDaySelected!(selectedDay);
            }
          },
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: false,
          ),
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView(
            children: _events[_selectedDay] != null
                ? _events[_selectedDay]!
                .map((event) => ListTile(
              title: Text(event),
            ))
                .toList()
                : [const Text('No medication history for this date.')],
          ),
        ),
      ],
    );
  }
}
