import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController _controller;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.02032, -104.66756), //Victoria de durango
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps en Flutter'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (controller) {
          _controller = controller;
        },
        markers: {
          Marker(
            markerId: MarkerId('mk1'),
            position: LatLng(24.03121944, -104.64691389), //coordenadas del ITD
            infoWindow: InfoWindow(title: 'El tecno'),
          ),
        },
      ),
    );
  }
}
