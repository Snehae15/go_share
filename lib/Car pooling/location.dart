import 'package:url_launcher/url_launcher.dart';
class MapUtils {
  MapUtils();
  static Future<void> openMap(double latitude, double longitude) async {
    print(latitude);
    print(longitude);
    var url = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&basemap=satellite";
    var googleUrl = Uri.parse(url);
    print(googleUrl);
    if (await canLaunchUrl(googleUrl) != null) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not open the map. $url';
    }
  }
}