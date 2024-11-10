import 'package:flutter/material.dart';
import '../api_service.dart';
import 'package:table_calendar/table_calendar.dart';

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