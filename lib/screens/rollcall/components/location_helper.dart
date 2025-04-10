import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("GPS chưa được bật");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Quyền GPS bị từ chối");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Quyền GPS bị từ chối vĩnh viễn, hãy vào cài đặt để bật.");
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print("📍 Vĩ độ: ${position.latitude.toStringAsPrecision(15)}, "
      "Kinh độ: ${position.longitude.toStringAsPrecision(15)}");

    return position;
  }
}

