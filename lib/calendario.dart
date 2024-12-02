import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarioScreen extends StatefulWidget {
  @override
  _CalendarioScreenState createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  List<dynamic> _entradas = [];

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
    fetchEntradas("2024-11-26T00:00:00Z");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendario"),
      ),
      body: ListView.builder(
        itemCount: _entradas.length,
        itemBuilder: (context, index) {
          final entrada = _entradas[index];
          return ListTile(
            title: Text(entrada["descripcion"]),
            subtitle: Text("Multimedia: ${entrada["multimedia"].length} elementos"),
          );
        },
      ),
    );
  }
}
