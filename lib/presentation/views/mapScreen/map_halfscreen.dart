import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/repository/assetRepository.dart';
import 'package:reality_near/core/providers/location_provider.dart';

class MapBoxScreen extends StatefulWidget {
  const MapBoxScreen({Key key}) : super(key: key);

  @override
  State<MapBoxScreen> createState() => _MapBoxScreenState();
}

class _MapBoxScreenState extends State<MapBoxScreen> {
  List<CircleMarker> lstCircleMarkers = [];
  bool loadMarkers = false;
  final MapController _mapController = MapController();

  getAssets() async {
    var lstAssets = await AssetRepository().getAllAssets();
    var lstAssetsLocations = lstAssets.map((e) => e.locations).toList();
    for (var lstLocation in lstAssetsLocations) {
      for (var location in lstLocation) {
        lstCircleMarkers.add(CircleMarker(
          point:
              LatLng(location.position.latitude, location.position.longitude),
          color: greenPrimary.withOpacity(0.3),
          radius: double.parse(location.rule),
          useRadiusInMeter: true,
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
                            maxZoom: 18.4,
                            minZoom: 13,
                            controller: model.mapController,
                          ),
                          layers: [
                            TileLayerOptions(
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
                              ],
                            ),
                            CircleLayerOptions(
                              circles: lstCircleMarkers,
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: RotatedBox(
                            quarterTurns: 3,
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
                          ),
                        )
                      ],
                    )
                  : const Center(child: CircularProgressIndicator())));
    });
  }
}
