import 'package:automobile_management/enums/notification_enum.dart';
import 'package:automobile_management/widgets/custom_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:automobile_management/models/my_notification.dart';
import 'package:geolocator/geolocator.dart';

class LocationApi {
  late Position currentPosistion;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      await determinePosition();
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        await Geolocator.openAppSettings();
        try {
          await determinePosition();
        } on Exception catch (e) {
          // TODO
        }
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      CustomToast.errorToast(
          message: "Cannot proceed Without Location permisiion.");
      await Geolocator.openAppSettings();
      await determinePosition();
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    currentPosistion = await Geolocator.getCurrentPosition();
    return currentPosistion;
  }
}
