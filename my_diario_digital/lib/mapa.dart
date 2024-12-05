import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.02032, -104.66756), // Victoria de Durango
    zoom: 10,
  );

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    _markers.add(
      Marker(
        markerId: MarkerId('mk1'),
        position: LatLng(24.03121944, -104.64691389), // Coordenadas del ITD
        infoWindow: InfoWindow(title: 'El tecno'),
      ),
    );
  }

  Future<void> _setMapStyle() async {
    if (_controller != null) {
      final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
      final style = isDarkMode ? await _loadMapStyle('assets/map_style_dark.json') : null;
      _controller?.setMapStyle(style);
    }
  }

  Future<String> _loadMapStyle(String path) async {
    return await DefaultAssetBundle.of(context).loadString(path);
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _setMapStyle();
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(title: 'New Marker', snippet: position.toString()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _controller?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: _onMapCreated,
        markers: _markers,
        onTap: _onMapTapped,
        onCameraMove: (position) {
          // Puedes manejar eventos de movimiento de cámara aquí
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
