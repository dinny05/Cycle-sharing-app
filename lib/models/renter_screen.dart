import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RenterScreen extends StatefulWidget {
  @override
  _RenterScreenState createState() => _RenterScreenState();
}

class _RenterScreenState extends State<RenterScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  // Mock data for available cycles
  final List<Map<String, dynamic>> _availableCycles = [
    {
      'name': 'Mountain Bike',
      'model': 'Trek X500',
      'condition': 'Excellent',
      'price': 50,
      'image': 'assets/bike1.jpg',
    },
    // Add more cycles as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Cycle'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Calendar
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(Duration(days: 30)),
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
          ),

          // Time Selection
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          _selectedStartTime = time;
                        });
                      }
                    },
                    child: Text(_selectedStartTime != null
                        ? 'Start: ${_selectedStartTime!.format(context)}'
                        : 'Select Start Time'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          _selectedEndTime = time;
                        });
                      }
                    },
                    child: Text(_selectedEndTime != null
                        ? 'End: ${_selectedEndTime!.format(context)}'
                        : 'Select End Time'),
                  ),
                ),
              ],
            ),
          ),

          // Available Cycles List
          Expanded(
            child: ListView.builder(
              itemCount: _availableCycles.length,
              itemBuilder: (context, index) {
                final cycle = _availableCycles[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(cycle['image']),
                    ),
                    title: Text(cycle['name']),
                    subtitle: Text('${cycle['model']} - ${cycle['condition']}'),
                    trailing: Text('₹${cycle['price']}/hr'),
                    onTap: () {
                      _showBookingConfirmation(context, cycle);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context, Map<String, dynamic> cycle) {
    if (_selectedDay == null || _selectedStartTime == null || _selectedEndTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select date and time first')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cycle: ${cycle['name']}'),
            Text('Date: ${_selectedDay!.toString().split(' ')[0]}'),
            Text('Time: ${_selectedStartTime!.format(context)} - ${_selectedEndTime!.format(context)}'),
            Text('Price: ₹${cycle['price']}/hr'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement booking logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Booking confirmed!')),
              );
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}