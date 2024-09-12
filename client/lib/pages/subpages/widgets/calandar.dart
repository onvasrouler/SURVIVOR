import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarExample extends StatefulWidget {
  const CalendarExample({super.key});

  @override
  State<CalendarExample> createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Event>> _events = {
    DateTime(2024, 7, 2): [
      Event('Lorem Ipsum passage - Product Release', Colors.blue)
    ],
    DateTime(2024, 7, 3): [
      Event('1:30p Reader will be distracted', Colors.red)
    ],
    DateTime(2024, 7, 4): [Event('The leap into electronic', Colors.blue)],
    DateTime(2024, 7, 7): [Event('4p Jidehse gegoj fupelone.', Colors.red)],
    DateTime(2024, 7, 14): [Event('1:30p Rabfov va hezow.', Colors.green)],
    DateTime(2024, 7, 16): [Event('4p Ke uzipiz zip.', Colors.lightBlueAccent)],
    DateTime(2024, 7, 17): [
      Event('5a Rujfogve kabwih haznojuf.', Colors.red),
      Event('7a simply dummy text of the printin', Colors.blue),
    ],
    DateTime(2024, 7, 18): [
      Event('Piece of classical Latin literature', Colors.blue),
      Event('More events', Colors.blue),
    ],
  };

  List<Event> _getEventsForDay(DateTime day) {
    DateTime key = DateTime(day.year, day.month, day.day);
    return _events[key] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar<Event>(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          eventLoader: (day) => _getEventsForDay(day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          daysOfWeekHeight: 30, // Adjust height for weekday names
          daysOfWeekStyle: const DaysOfWeekStyle(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            weekdayStyle: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            weekendStyle: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          calendarStyle: CalendarStyle(
            markersMaxCount: 3,
            cellMargin: const EdgeInsets.all(2),
            defaultTextStyle: const TextStyle(fontSize: 14),
            outsideTextStyle: const TextStyle(color: Colors.grey),
            weekendTextStyle: const TextStyle(color: Colors.black),
            todayTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.6),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            isTodayHighlighted: true,
            outsideDecoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 0.5),
            ),
            defaultDecoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 0.5),
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronIcon: Icon(
              Icons.chevron_left,
              size: 28,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              size: 28,
            ),
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return _buildDay(day);
            },
            todayBuilder: (context, day, focusedDay) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  day.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  day.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDay(DateTime day) {
    final events = _getEventsForDay(day);

    return Container(
      width: 200,
      height: 85,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day.day.toString(),
            style: const TextStyle(fontSize: 12),
          ),
          ...events.map((event) => _buildEventMarker(event)),
        ],
      ),
    );
  }

  Widget _buildEventMarker(Event event) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        color: event.color.withOpacity(0.7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.white),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              event.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;
  final Color color;

  Event(this.title, this.color);
}
