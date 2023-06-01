import 'dart:math';

import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({required this.users});
  final List<UserModel> users;
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};

  void _generateMarkers() {
    for (var markerData in markerDataList) {
      final markerId = MarkerId(markerData.imageUrl);
      final marker = Marker(
        markerId: markerId,
        position: markerData.location,
        // icon: BitmapDescriptor.fromAsset('assets/marker_icon.png'), // You can customize the marker icon here
        infoWindow: InfoWindow(
          title: markerData.name,
          snippet: 'Marker Snippet',
        ),
      );
      _markers.add(marker);
    }
  }

  @override
  void initState() {
    super.initState();
    for (var element in widget.users) {
      markerDataList.add(MarkerData(
          name: element.username,
          imageUrl: element.photoUrl ??
              "https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
          location: LatLng(element.latitude, element.longitude)));
    }
    _generateMarkers();
  }

  List<MarkerData> markerDataList = [];
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
        markers: _markers,
        buildingsEnabled: false,
        trafficEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(
              authMethod.currentUserData!.latitude,
              authMethod.currentUserData!
                  .longitude), // Set initial position to Googleplex
          zoom: 14.0,
        ),
      ),
    );
  }
}

class MarkerData {
  final String imageUrl;
  final String name;
  final LatLng location;

  MarkerData(
      {required this.name, required this.imageUrl, required this.location});
}
