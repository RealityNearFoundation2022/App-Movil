import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/repository/assetRepository.dart';
import 'package:reality_near/core/providers/location_provider.dart';

class MapSection extends StatefulWidget {
  const MapSection({Key key}) : super(key: key);

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  List<Marker> lstMarkers = [];
  bool loadMarkers = false;

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

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      model.ctx = consumerContext;

      lstMarkers.add(Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(model.locationPosition.latitude,
            model.locationPosition.longitude),
        builder: (context) => const Icon(
          Icons.navigation_rounded,
          color: greenPrimary,
          size: 20,
        ),
      ));

      return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
          ),
          child: (loadMarkers)
              ? Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        center: LatLng(model.locationPosition.latitude,
                            model.locationPosition.longitude),
                        zoom: 18,
                        maxZoom: 18.4,
                        minZoom: 14,
                        controller: model.mapController,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
                          subdomains: ['a', 'b', 'c'],
                          additionalOptions: {
                            'id': 'mapbox/streets-v11',
                            'accessToken': MAPBOX_ACCESS_TOKEN
                          },
                        ),
                        MarkerLayerOptions(
                          markers: lstMarkers,
                        ),
                      ],
                    ),
                    // Container(
                    //   alignment: Alignment.bottomRight,
                    //   padding: const EdgeInsets.all(10),
                    //   child: IconButton(
                    //     onPressed: () {
                    //       Provider.of<LocationProvider>(context, listen: false)
                    //           .setCameraToCurrentPosition();
                    //     },
                    //     icon: const Icon(
                    //       Icons.gps_fixed,
                    //       color: greenPrimary,
                    //       size: 40,
                    //     ),
                    //   ),
                    // )
                  ],
                )
              : const Center(child: CircularProgressIndicator()));
    });
  }
}
