import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {}; // Use a Set for markers

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.02032, -104.66756), // Victoria de Durango
    zoom: 14, // Increased initial zoom for better visibility
  );

  @override
  void initState() {
    super.initState();
    // Initialize markers in initState
    _markers.add(
      Marker(
        markerId: MarkerId('mk1'),
        position: LatLng(24.03121944, -104.64691389), // ITD coordinates
        infoWindow: InfoWindow(title: 'El Tecno'),
      ),
    );
  }

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
        markers: _markers, // Use the _markers Set
      ),
    );
  }
}