import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/repository/assetRepository.dart';
import 'package:reality_near/providers/location_provider.dart';

class MapBoxScreen extends StatefulWidget {
  const MapBoxScreen({Key key}) : super(key: key);

  @override
  State<MapBoxScreen> createState() => _MapBoxScreenState();
}

class _MapBoxScreenState extends State<MapBoxScreen> {
  List<Marker> lstMarkers = [];
  bool loadMarkers = false;
  final MapController _mapController = MapController();

  getAssets() async {
    var lstAssets = await AssetRepository().getAllAssets();
    var lstAssetsLocations = lstAssets.map((e) => e.locations).toList();
    for (var lstLocation in lstAssetsLocations) {
      for (var location in lstLocation) {
        lstMarkers.add(Marker(
          width: 80.0,
          height: 80.0,
          point:
              LatLng(location.position.latitude, location.position.longitude),
          builder: (ctx) => const Icon(
            Icons.location_on,
            color: greenPrimary,
            size: 25,
          ),
        ));
      }
    }
    setState(() {
      loadMarkers = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getAssets();
    Provider.of<LocationProvider>(context, listen: false).initialization();
  }

  LatLng coliseoMelgarBre = LatLng(-12.060201343870178, -77.05406694161285);
  setCameraToCurrentPosition(LatLng position) {
    _mapController.move(position, 18);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      model.ctx = consumerContext;

      return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: (model.locationPosition != null && loadMarkers)
                  ? Stack(
                      children: [
                        FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            center: LatLng(model.locationPosition.latitude,
                                model.locationPosition.longitude),
                            zoom: 18,
                            controller: _mapController,
                          ),
                          layers: [
                            TileLayerOptions(
                              maxZoom: 18,
                              minZoom: 15,
                              maxNativeZoom: 18,
                              minNativeZoom: 15,
                              urlTemplate:
                                  "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
                              subdomains: ['a', 'b', 'c'],
                              additionalOptions: {
                                'id': 'mapbox/streets-v11',
                                'accessToken': MAP_BOX_V2
                              },
                            ),
                            MarkerLayerOptions(
                              markers: [
                                Marker(
                                  width: 40.0,
                                  height: 40.0,
                                  point: LatLng(model.locationPosition.latitude,
                                      model.locationPosition.longitude),
                                  builder: (context) => const Icon(
                                    Icons.navigation_rounded,
                                    color: greenPrimary,
                                    size: 20,
                                  ),
                                ),
                                for (var marker in lstMarkers) marker
                              ],
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.all(20),
                          child: IconButton(
                            onPressed: () {
                              setCameraToCurrentPosition(LatLng(
                                  model.locationPosition.latitude,
                                  model.locationPosition.longitude));
                            },
                            icon: const Icon(
                              Icons.gps_fixed,
                              color: greenPrimary,
                              size: 40,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: greenPrimary,
                              size: 40,
                            ),
                          ),
                        )
                      ],
                    )
                  : const Center(child: CircularProgressIndicator())));
    });
  }
}
