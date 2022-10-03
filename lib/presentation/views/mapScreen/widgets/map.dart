import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/providers/location_provider.dart';

class MapSection extends StatefulWidget {
  const MapSection({Key key}) : super(key: key);

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initialization();
  }
  LatLng coliseoMelgarBre = LatLng(-12.060201343870178, -77.05406694161285);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      model.ctx = consumerContext;

      return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
          ),
          child: model.locationPosition != null
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
                            Marker(
                              width: 40.0,
                              height: 40.0,
                              point: LatLng(coliseoMelgarBre.latitude,
                                  coliseoMelgarBre.longitude),
                              builder: (context) => const Icon(
                                Icons.pin_drop,
                                color: greenPrimary,
                                size: 20,
                              ),
                            ),
                          ],
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
