import 'package:flutter/material.dart';
import '../utils/api_service.dart';
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
  DateTime? _selectedDay;
  List<dynamic> backlogByDevice = [];

  @override
  void initState() {
    super.initState();
    _fetchBacklog();
  }

  Future<void> _fetchBacklog() async {
    backlogByDevice = await fetchBacklogByDevice(widget.deviceID);
    setState(() {});
  }

  List<dynamic> _getEventsForSelectedDay(DateTime day) {
    return backlogByDevice.where((event) {
      final intakeDate = DateTime.parse(event['intake_date']).toLocal();
      return isSameDay(intakeDate, day);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final eventsForSelectedDay = _getEventsForSelectedDay(_selectedDay ?? DateTime.now());
    return Stack(
      alignment: const Alignment(0.0, 0.0),
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height*0.53,
          decoration: ShapeDecoration(
            color: const Color(0xFFFFFFE9),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xFF191717)),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment. center,
          children: [
             SizedBox(
                width: MediaQuery.of(context).size.width*0.75,
                height: MediaQuery.of(context).size.height*0.4,
                child: TableCalendar(
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2050),
                  focusedDay: DateTime.now().toLocal(),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: (day) =>_getEventsForSelectedDay(day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                    });
                    widget.onDaySelected?.call(selectedDay);
                  },
                  rowHeight: 50,
                  daysOfWeekHeight: 18,
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      color: Color(0xFF191717),
                      fontSize: 19,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Color(0xFF191717),
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                    weekendStyle: TextStyle(color: Color(0xFFE55733),
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: const TextStyle(
                      color: Color(0xFF191717),
                      fontSize: 17,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600
                    ),
                    outsideTextStyle: TextStyle(
                      color: const Color(0xFF191717).withOpacity(0.3),
                      fontSize: 17,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600
                    ),
                    holidayTextStyle: const TextStyle(
                      color: Color(0xFF191717),
                      fontSize: 17,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600
                    ),
                    weekendTextStyle: const TextStyle(
                      color: Color(0xFF191717),
                      fontSize: 17,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600
                    ),
                    todayTextStyle: const TextStyle(
                      color: Color(0xFFFFFFE9),
                      fontSize: 17,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                    selectedTextStyle:  const TextStyle(
                      color: Color(0xFFFFFFE9),
                      fontSize: 17,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                    todayDecoration: const BoxDecoration(
                      color: Color(0xFF43A363),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFFE55733),
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: true,
                  )
                )
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.height*0.1,
                child: eventsForSelectedDay.isNotEmpty
                  ? ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    itemCount: eventsForSelectedDay.length,
                    itemBuilder: (context, index) {
                      final intake = eventsForSelectedDay[index];
                      final status = intake['status'];
                      final icon = status == 'completed'
                          ? Icons.check_circle
                          : status == 'incomplete'
                          ? Icons.cancel
                          : Icons.access_time;
                      return ListTile(
                        leading: Icon(icon, color : status == 'completed' ? const Color(0xFF43A363)
                                                  : status == 'incomplete' ? const Color(0xFFE55733)
                                                  : const Color(0xFF336BB7)),
                        title: Text(
                          intake['medication'] ?? 'Unnamed Medication',
                          style: const TextStyle(
                            color: Color(0xFF191717),fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700
                          )
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${intake['intake_time']}',
                              style: const TextStyle(
                                color: Color(0xFF191717),
                                fontSize: 16,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600
                              )
                            ),
                            Text(
                              '${intake['reminder_note']}',
                              style: const TextStyle(
                                color: Color(0xFF191717),fontSize: 16,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600
                              )
                            ),
                          ],
                        ),
                      );
                    },
                  )
                  : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      final emptyDays = [
                        _selectedDay != null && _selectedDay!.isAfter(DateTime.now())
                        ? {'log':'No upcoming medication plan'}
                        : {'log':'No medication record'}
                      ];
                      final emptyDay = emptyDays[index];
                      final icon = _selectedDay != null && _selectedDay!.isAfter(DateTime.now())
                        ? Icons.hourglass_empty
                        : Icons.info_outline;
                      return ListTile(
                        leading: Icon(icon, color: _selectedDay != null && _selectedDay!.isAfter(DateTime.now()) ?  const Color(0xFF43A363) : const Color(0xFFE55733)),
                        title: Text(
                          '${emptyDay['log']}',
                          style: const TextStyle(
                            color: Color(0xFF191717),
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600
                          )
                        ),
                      );
                    },
                  )
                ),
              ],
            )
          ]
        );
      }
    }
