import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  GoogleMapController? _googleMapController;
  Stream<LocationData> locationStream = Location().onLocationChanged;


  @override
  void initState() {
    Location().changeSettings(distanceFilter: 3);
    final subscription = locationStream.listen((event) {
      print('location: ' + event.latitude.toString() + " " +
          event.longitude.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
        polylines: _polylines,
        onMapCreated: (controller) {
          _googleMapController = controller;
          Polyline(polylineId: PolylineId('text'),);
        },
        markers: _markers,


      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _googleMapController?.dispose();
  }
}

