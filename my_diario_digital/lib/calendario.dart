import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; //Libreria de table_calendar
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarioScreen extends StatefulWidget {
  @override
  _CalendarioScreenState createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  List<dynamic> _entradas = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Future<void> fetchEntradas(String fecha) async {
    final url = Uri.parse("https://tu-servidor.com/api/calendar/entries?fecha=$fecha");
    final headers = {
      "Authorization": "Bearer token_jwt",
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["status"] == "success") {
          setState(() {
            _entradas = data["entradas"];
          });
        }
      } else {
        throw Exception("Error al obtener las entradas");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    fetchEntradas(_focusedDay.toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendario"),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              fetchEntradas(selectedDay.toIso8601String());
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: _entradas.isEmpty
                ? Center(child: Text("No hay entradas para esta fecha."))
                : ListView.builder(
                    itemCount: _entradas.length,
                    itemBuilder: (context, index) {
                      final entrada = _entradas[index];
                      return ListTile(
                        title: Text(entrada["descripcion"]),
                        subtitle: Text("Multimedia: ${entrada["multimedia"].length} elementos"),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
