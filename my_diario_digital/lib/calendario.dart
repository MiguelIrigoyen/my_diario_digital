import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart'; // Usa una librería de calendario de Flutter
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarioScreen extends StatefulWidget {
  @override
  _CalendarioScreenState createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  List<dynamic> _entradas = [];
  DateTime _selectedDate = DateTime.now();

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

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    fetchEntradas(date.toIso8601String());
  }

  @override
  void initState() {
    super.initState();
    fetchEntradas(_selectedDate.toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendario"),
      ),
      body: Column(
        children: [
          Calendar( // Widget del calendario
            onDateSelected: _onDateSelected,
            isExpandable: true,
            initialCalendarDateOverride: _selectedDate,
            dayBuilder: (context, date) {
              // Personaliza los días si lo necesitas
              return Container(
                decoration: BoxDecoration(
                  color: _selectedDate == date ? Colors.blue : Colors.white,
                  border: Border.all(color: Colors.black12),
                ),
                child: Center(child: Text("${date.day}")),
              );
            },
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
