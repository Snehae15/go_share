import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
class LocationController extends GetxController {
  late Position? currentPosition;
  var isLoading = false.obs;

  String? currentLocation;
  String? locality;
  String? street;
  String? sublocality;
  String? subadminstartive;
  var myLat;
  var myLong;
  Future<Position> getPosition() async {
    LocationPermission?permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //do stuff here
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //stuff
        return Future.error("location permissions denied");
      }
    }
    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error("location permissions permanently denied");
    // }
    // Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLng(long, lat) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
      Placemark place = placemark[0];
      currentLocation =
      '${place.locality},${place.street},${place.subLocality},${place
          .subAdministrativeArea}';
      locality='${place.locality}';
      street='${place.street}';
      sublocality='${place.subLocality}';
      subadminstartive='${place.subAdministrativeArea}';
      myLat=lat;
      myLong=long;
      update();
    } catch (e) {
      print(e);
    }
  }
  Future<void> getCurrentLocation() async {
    try {
      isLoading(true);
      update();
      currentPosition = await getPosition();
      getAddressFromLatLng(currentPosition!.longitude, currentPosition!.latitude);
      isLoading(false);
      update();
    } catch (e) {
      print(e);
    }
  }
}