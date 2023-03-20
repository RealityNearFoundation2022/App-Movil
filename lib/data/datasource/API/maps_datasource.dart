import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class MapsRemoteDataSource {
  Future<String> getDirectionFromLatLng(LatLng location);
  Future<List<Map<String, LatLng>>> searchDirection(String direction);
}

class MapsRemoteDataSourceImpl implements MapsRemoteDataSource {
  final String mapBoxApiUrl =
      "https://api.mapbox.com/geocoding/v5/mapbox.places/";
  var log = Logger();

  // https://api.mapbox.com/geocoding/v5/mapbox.places/ovalo%20higuereta.json?country=pe&proximity=ip&language=es&access_token=

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

  @override
  Future<List<Map<String, LatLng>>> searchDirection(String direction) async {
    final url = mapBoxApiUrl +
        "${direction.replaceAll(' ', '%20')}.json?country=pe&proximity=ip&language=es&access_token=$MAPBOX_ACCESS_TOKEN";
    //   final url = mapBoxApiUrl +
    //       "$direction.json?country=pe&proximity=-12.046374,-77.042793&language=es&access_token=$MAPBOX_ACCESS_TOKEN";

    var header = {
      "Content-Type": "application/json",
    };

    var response = await http.get(Uri.parse(url), headers: header);

    var list = <Map<String, LatLng>>[];

    if (response.statusCode == 200 &&
        json.decode(response.body)["features"].length > 0) {
      var features = json.decode(response.body)["features"];

      features.forEach((element) {
        var lat = element["center"][1];
        var lng = element["center"][0];
        var name = element["place_name"];
        list.add({name: LatLng(lat, lng)});
      });
    }

    return list;
  }
}
