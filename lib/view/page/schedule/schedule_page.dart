import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../domain/schedule.dart';
import '../../../provider/schedule_provider.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Schedule',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                  onPressed: () {
                    context.go('/');
                  },
                  icon: Icon(Icons.close)
              ),
            ],
          ),
          SizedBox(height: 16),
          TableCalendar(
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(height: 24),
          Text(
            "${_selectedDay.day} / ${_selectedDay.month} / ${_selectedDay.year}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Consumer<ScheduleProvider>(
            builder: (context, scheduleProvider, child) {
              return FutureBuilder(
                future: scheduleProvider.show(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while the data is being fetched
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    // Show an error message if something went wrong
                    return Center(
                      child: Text('An error occurred: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    // Handle the case where no data is returned
                    return const Center(
                      child: Text('No schedule found.'),
                    );
                  } else {
                    List<Schedule> schedules = snapshot.data!;
                    List<Schedule> filteredSchedules = schedules.where((schedule) {
                      return isSameDay(schedule.appointmentDate, _selectedDay);
                    }).toList();
                    return Column(
                      children: filteredSchedules.map((schedule) {
                        return BookingCard(
                          time: '${DateFormat('HH:mm').format(schedule.appointmentStartTime)} - ${DateFormat('HH:mm').format(schedule.appointmentEndTime)}',
                          address: schedule.address,
                          houseSize: '${schedule.houseSize} sqft',
                          houseType: schedule.houseType,
                          bookingId: schedule.bookingId,
                          offerId: schedule.offerId,
                        );
                      }).toList(),
                    );
                  }
                }
              );
            }
          )
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String time;
  final String address;
  final String houseSize;
  final String houseType;
  final String bookingId;
  final String offerId;

  const BookingCard({
    super.key,
    required this.time,
    required this.address,
    required this.houseSize,
    required this.houseType,
    required this.bookingId,
    required this.offerId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/schedule/$bookingId/$offerId');
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Time: $time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Address: $address',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'House Size: $houseSize',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'House Type: $houseType',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}