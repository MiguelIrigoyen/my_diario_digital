import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfiguracionScreen extends StatefulWidget {
  @override
  _ConfiguracionScreenState createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  Future<void> configurarPermisos(String tipoPermiso, bool estado) async {
    final url = Uri.parse("https://tu-servidor.com/api/settings/permissions");
    final body = json.encode({
      "tipoPermiso": tipoPermiso,
      "estado": estado,
    });

    try {
      final response = await http.post(url, body: body, headers: {
        "Content-Type": "application/json",
      });
      final data = json.decode(response.body);
      print(data["message"]);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> cambiarTema(String tema) async {
    final url = Uri.parse("https://tu-servidor.com/api/settings/theme");
    final body = json.encode({
      "tema": tema,
    });

    try {
      final response = await http.post(url, body: body, headers: {
        "Content-Type": "application/json",
      });
      final data = json.decode(response.body);
      print(data["message"]);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> ajustarNotificaciones(bool notificaciones) async {
    final url = Uri.parse("https://tu-servidor.com/api/settings/notifications");
    final body = json.encode({
      "notificaciones": notificaciones,
    });

    try {
      final response = await http.post(url, body: body, headers: {
        "Content-Type": "application/json",
      });
      final data = json.decode(response.body);
      print(data["message"]);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuración"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => configurarPermisos("cámara", true),
            child: Text("Configurar Permisos"),
          ),
          ElevatedButton(
            onPressed: () => cambiarTema("oscuro"),
            child: Text("Cambiar Tema"),
          ),
          ElevatedButton(
            onPressed: () => ajustarNotificaciones(false),
            child: Text("Ajustar Notificaciones"),
          ),
        ],
      ),
    );
  }
}
