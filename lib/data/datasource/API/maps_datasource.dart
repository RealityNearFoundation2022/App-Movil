import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class MapsRemoteDataSource {
  Future<String> getDirectionFromLatLng(LatLng location);
}

class MapsRemoteDataSourceImpl implements MapsRemoteDataSource {
  final String mapBoxApiUrl =
      "https://api.mapbox.com/geocoding/v5/mapbox.places/";
  var log = Logger();

  MapsRemoteDataSourceImpl();

  @override
  Future<String> getDirectionFromLatLng(LatLng location) async {
    final url = mapBoxApiUrl +
        "${location.longitude},${location.latitude}.json?access_token=$MAPBOX_ACCESS_TOKEN";

    var header = {
      "Content-Type": "application/json",
    };

    var response = await http.get(Uri.parse(url), headers: header);

    var direction = response.statusCode == 200 &&
            json.decode(response.body)["features"].length > 0
        ? json.decode(response.body)["features"][0]["place_name"]
        : "No encontrado";

    return direction;
  }
}
