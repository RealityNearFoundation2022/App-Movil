
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/presentation/providers/location_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
      model.ctx = consumerContext;
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
        ),
        child: (model.locationPosition != null &&
                model.markerLocationId != null &&
                model.markerPlaceId != null)
            ? Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: model.locationPosition,
                      zoom: 18,
                    ),
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    buildingsEnabled: false,
                    minMaxZoomPreference: const MinMaxZoomPreference(13, 20),
                    markers: Set<Marker>.of(model.markers.values),
                    onMapCreated: (GoogleMapController controller) async {
                      Provider.of<LocationProvider>(context, listen: false)
                          .setMapController(controller);
                    },
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(10),
                    child: IconButton(
                      onPressed: () {
                        Provider.of<LocationProvider>(context, listen: false)
                            .setCameraToCurrentPosition();
                      },
                      icon: const Icon(
                        Icons.gps_fixed,
                        color: greenPrimary,
                        size: 40,
                      ),
                    ),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      );
    });
  }
}
