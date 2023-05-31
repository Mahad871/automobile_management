import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    AuthMethod authMethod = sl.get<AuthMethod>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Example'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition:  CameraPosition(
          target: LatLng(authMethod.currentUserData!.latitude,
              authMethod.currentUserData!.longitude), // Set initial position to Googleplex
          zoom: 14.0,
        ),
      ),
    );
  }
}
