import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/core/providers/location_provider.dart';
import 'package:reality_near/data/datasource/API/asset_datadource.dart';
import 'package:reality_near/data/datasource/API/maps_datasource.dart';
import 'package:reality_near/data/models/asset_model.dart';
import 'package:reality_near/data/repository/assetRepository.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/Admin/assets/widgets/admin_asset_viewer.dart';
import 'package:reality_near/presentation/widgets/buttons/default_button.dart';
import 'package:reality_near/presentation/widgets/forms/textForm.dart';

class AdminAssetScreen extends StatefulWidget {
  static String routeName = "/adminAssetScreen";

  const AdminAssetScreen({Key key}) : super(key: key);

  @override
  State<AdminAssetScreen> createState() => _AdminAssetScreenState();
}

class _AdminAssetScreenState extends State<AdminAssetScreen> {
  List<CircleMarker> lstCircleMarkers = [];
  List<CircleMarker> lstCircleMarkersFilter = [];
  List<CircleMarker> lstCircleMarkersAssetSelect = [];
  bool loadMarkers = false;
  List<AssetModel> lstAssets = [];
  List<AssetModel> lstAssetsFilter = [];
  List<AssetModel> lstAssetsSearch = [];
  AssetModel assetSelected;
  bool filterContainerActive = false;
  bool SearchContainerActive = false;
  List<Map<String, LatLng>> placesResult = [];
  final MapController _mapController = MapController();
  final TextEditingController _ruleController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool editAddMode = false;
  bool editionMode = false;
  LatLng positionSelected;
  LatLng positionAnterior;
  Location locSelectedToEdit;
  getAssets() async {
    var x = await AssetRepository().getAllAssets();
    x.sort((a, b) => a.name.compareTo(b.name));
    setState(() {
      lstAssets = x;
      lstAssetsSearch = x;
    });
    getMarkers();
  }

  getMarkers() async {
    lstCircleMarkers = [];
    for (var asset in lstAssets) {
      Color assetColor = getRandomColorHex();
      for (var location in asset.locations) {
        lstCircleMarkers.add(CircleMarker(
          point:
              LatLng(location.position.latitude, location.position.longitude),
          color: assetColor.withOpacity(0.3),
          radius: double.parse(location.rule),
          useRadiusInMeter: true,
        ));
      }
    }
    setState(() {
      loadMarkers = true;
    });
  }

  getDirectionFromPosition(LatLng position) async {
    var direction =
        await MapsRemoteDataSourceImpl().getDirectionFromLatLng(position);
    return direction;
  }

  directionWdg(LatLng position) {
    return FutureBuilder(
        future: getDirectionFromPosition(position),
        builder: (context, snapshot) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              snapshot.hasData ? snapshot.data : 'Cargando...',
              style: const TextStyle(
                  color: greenPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
          );
        });
  }

  deleteAssetLocation(Location location) async {
    dialgoResultOperation(AssetRemoteDataSourceImpl().deleteLocation(location),
        () {
      getAssets();
      lstCircleMarkersAssetSelect.removeWhere((element) =>
          element.point.latitude == location.position.latitude &&
          element.point.longitude == location.position.longitude);
      assetSelected.locations.remove(location);
    });
  }

  addAssetLocation(Location location) async {
    dialgoResultOperation(
        AssetRemoteDataSourceImpl().addLocation(assetSelected.id, location),
        () async {
      await getAssets();
      assetSelected.locations.add(location);
      lstCircleMarkersAssetSelect.add(CircleMarker(
        point: LatLng(location.position.latitude, location.position.longitude),
        color: greenPrimary.withOpacity(0.3),
        radius: double.parse(location.rule),
        useRadiusInMeter: true,
      ));
    });
  }

  updateAssetLocation(Location location, int indexlstCircleMarker) async {
    dialgoResultOperation(
        AssetRemoteDataSourceImpl().updateLocation(assetSelected.id, location),
        () async {
      await getAssets();

      var indexAssetSelected = assetSelected.locations
          .indexWhere((element) => element.id == location.id);

      assetSelected.locations[indexAssetSelected] = location;

      lstCircleMarkersAssetSelect[indexlstCircleMarker] = CircleMarker(
        point: LatLng(location.position.latitude, location.position.longitude),
        color: greenPrimary.withOpacity(0.3),
        radius: double.parse(location.rule),
        useRadiusInMeter: true,
      );
    });
  }

  dialgoResultOperation(Future<dynamic> operation, Function updateFunc) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: FutureBuilder(
              future: operation,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Icon(
                        snapshot.data ? Icons.check_circle : Icons.error,
                        color: greenPrimary,
                        size: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data
                            ? 'Operación exitosa'
                            : 'Ocurrió un error',
                        style: const TextStyle(
                            color: greenPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenPrimary,
                        ),
                        onPressed: () {
                          if (snapshot.data) {
                            updateFunc();
                          }
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Aceptar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Cargando...'),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }
              }),
        );
      },
    );
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

  getAssetOfSelect(LatLng point) {
    //encontrar el asset qye tiene el punto seleccionado en su rango
    for (var asset in lstAssets) {
      for (Location location in asset.locations) {
        if (calculateDistanceMts(location.position, point) <=
            double.parse(location.rule)) {
          setState(() {
            assetSelected = asset;
          });
          getMarkerFilterFromAsset(asset);
          return true;
        }
      }
    }
    print('No hay asset en el lugar seleccionado');

    return false;
  }

  getMarkerFilterFromAsset(AssetModel asset) {
    print('El asset en el lugar es ${asset.name}');
    List<CircleMarker> lstMarkers = [];
    for (var location in asset.locations) {
      lstMarkers.add(CircleMarker(
        point: LatLng(location.position.latitude, location.position.longitude),
        color: greenPrimary.withOpacity(0.3),
        radius: double.parse(location.rule),
        useRadiusInMeter: true,
      ));
    }

    setState(() {
      lstCircleMarkersAssetSelect = lstMarkers;
    });
  }

  getMarkerFilterFromList(List<AssetModel> lstAssets) {
    List<CircleMarker> lstMarkers = [];
    for (var asset in lstAssets) {
      Color assetColor = getRandomColorHex();
      for (var location in asset.locations) {
        lstMarkers.add(CircleMarker(
          point:
              LatLng(location.position.latitude, location.position.longitude),
          color: assetColor.withOpacity(0.3),
          radius: double.parse(location.rule),
          useRadiusInMeter: true,
        ));
      }
    }

    setState(() {
      lstCircleMarkersFilter = lstMarkers;
    });
  }

  addMarkerInPosition(LatLng position, double radius) {
    if (positionAnterior == null) {
      lstCircleMarkersAssetSelect.add(CircleMarker(
        point: position,
        color: greenPrimary.withOpacity(0.4),
        radius: radius,
        useRadiusInMeter: true,
      ));
    } else {
      var indexAnterior = lstCircleMarkersAssetSelect
          .indexWhere((element) => element.point == positionAnterior);
      lstCircleMarkersAssetSelect[indexAnterior] = CircleMarker(
        point: position,
        color: greenPrimary.withOpacity(0.4),
        radius: radius,
        useRadiusInMeter: true,
      );
    }

    setState(() {
      positionAnterior = position;
    });
  }

  deleteMarkerInPosition(LatLng position) {
    lstCircleMarkersAssetSelect
        .removeWhere((element) => element.point == positionAnterior);
  }

  searchPlace(String value) async {
    var lstPlaces = await MapsRemoteDataSourceImpl().searchDirection(value);
    setState(() {
      placesResult = lstPlaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: globalApppBar(context, 'Admin Assets'),
        body: Consumer<LocationProvider>(
            builder: (consumerContext, model, child) {
          model.ctx = consumerContext;

          return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: (loadMarkers)
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
                            onTap: (tapPosition, point) {
                              if (editAddMode || editionMode) {
                                setState(() {
                                  positionSelected = point;
                                });
                                addMarkerInPosition(
                                    point,
                                    double.parse(_ruleController.text != ""
                                        ? _ruleController.text
                                        : "30"));
                              } else {
                                getAssetOfSelect(point);
                              }
                            },
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
                                maxNativeZoom: 20),
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
                              circles: lstCircleMarkersAssetSelect.isNotEmpty
                                  ? lstCircleMarkersAssetSelect
                                  : lstCircleMarkersFilter.isNotEmpty
                                      ? lstCircleMarkersFilter
                                      : lstCircleMarkers,
                            )
                          ],
                        ),
                        Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              //filter
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      SearchContainerActive =
                                          !SearchContainerActive;
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                    height: MediaQuery.of(context).size.width *
                                        0.09,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: greenPrimary, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Icon(Icons.search,
                                          color: greenPrimary,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      side: const BorderSide(
                                          color: greenPrimary, width: 1.5),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        filterContainerActive =
                                            !filterContainerActive;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.filter_alt_outlined,
                                            color: greenPrimary),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Filtro' +
                                              (lstAssetsFilter.isNotEmpty
                                                  ? " (${lstAssetsFilter.length})"
                                                  : ""),
                                          style: const TextStyle(
                                              color: greenPrimary,
                                              fontSize: 14),
                                        )
                                      ],
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.57,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: ListView.builder(
                                      itemCount: lstAssetsFilter.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: greenPrimary,
                                                    width: 1.5)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      assetSelected =
                                                          lstAssetsFilter[
                                                              index];
                                                    });
                                                  },
                                                  child: Text(
                                                    lstAssetsFilter[index].name,
                                                    style: const TextStyle(
                                                        color: greenPrimary,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                //icon x
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      lstAssetsFilter
                                                          .removeAt(index);
                                                      getMarkerFilterFromList(
                                                          lstAssetsFilter);
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: greenPrimary,
                                                    size: 16,
                                                  ),
                                                )
                                              ],
                                            ));
                                      },
                                    ))
                              ],
                            )),
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
                        filterContainerActive
                            ? filterDialog()
                            : const SizedBox(),
                        editAddMode ? bottomAddLocation() : const SizedBox(),
                        editionMode ? bottomEditLocation() : const SizedBox(),
                        !filterContainerActive && !editAddMode && !editionMode
                            ? bottomInfoAsset(assetSelected)
                            : const SizedBox(),
                        SearchContainerActive
                            ? bottomSearchDirection()
                            : const SizedBox(),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()));
        }));
  }

  bottomEditLocation() {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assetSelected.name,
                        style: const TextStyle(
                            color: greenPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Editar ubicación',
                        style: TextStyle(
                            color: greenPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        deleteMarkerInPosition(positionSelected);
                        editionMode = false;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: greenPrimary,
                      size: 35,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.fromBorderSide(
                        BorderSide(color: greenPrimary, width: 1.5))),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.location_on_outlined,
                      color: greenPrimary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      positionSelected != null
                          ? 'Lat: ${positionSelected.latitude}'
                          : 'Lat: ${locSelectedToEdit.position.latitude}',
                      style: const TextStyle(color: greenPrimary, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.fromBorderSide(
                        BorderSide(color: greenPrimary, width: 1.5))),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.location_on_outlined,
                      color: greenPrimary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      positionSelected != null
                          ? 'Lng: ${positionSelected.longitude}'
                          : 'Lng: ${locSelectedToEdit.position.longitude}',
                      style: const TextStyle(color: greenPrimary, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              positionSelected != null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.home,
                            color: greenPrimary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          FutureBuilder(
                              future:
                                  getDirectionFromPosition(positionSelected),
                              builder: (context, snapshot) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    snapshot.hasData
                                        ? snapshot.data
                                        : 'Cargando...',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: greenPrimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                );
                              })
                        ],
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              TxtForm(
                placeholder: 'Ingresa la regla (${locSelectedToEdit.rule})',
                controller: _ruleController,
                inputType: InputType.Number,
                txtColor: txtPrimary,
                prefixIcon: const Icon(Icons.social_distance_outlined),
                errorMessage: S.current.Obligatorio,
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                label: 'Guardar',
                onPressed: () {
                  if (_ruleController.text.isNotEmpty) {
                    var indexMarker = lstCircleMarkersAssetSelect.indexWhere(
                        (element) =>
                            element.point.latitude ==
                                locSelectedToEdit.position.latitude &&
                            element.point.longitude ==
                                locSelectedToEdit.position.longitude);

                    Location newLocation = Location(
                        id: locSelectedToEdit.id,
                        position: LatLng(positionSelected.latitude,
                            positionSelected.longitude),
                        rule: _ruleController.text);
                    setState(() {
                      updateAssetLocation(newLocation, indexMarker);
                      editAddMode = false;
                      editionMode = false;
                    });
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  bottomAddLocation() {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assetSelected.name,
                        style: const TextStyle(
                            color: greenPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Agregar ubicación',
                        style: TextStyle(
                            color: greenPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        deleteMarkerInPosition(positionSelected);
                        editAddMode = false;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: greenPrimary,
                      size: 35,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.fromBorderSide(
                        BorderSide(color: greenPrimary, width: 1.5))),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.location_on_outlined,
                      color: greenPrimary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      positionSelected != null
                          ? 'Lat: ${positionSelected.latitude}'
                          : 'Selecciona una posición en el mapa',
                      style: const TextStyle(color: greenPrimary, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.fromBorderSide(
                        BorderSide(color: greenPrimary, width: 1.5))),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.location_on_outlined,
                      color: greenPrimary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      positionSelected != null
                          ? 'Lng: ${positionSelected.longitude}'
                          : 'Selecciona una posición en el mapa',
                      style: const TextStyle(color: greenPrimary, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              positionSelected != null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.home,
                            color: greenPrimary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          FutureBuilder(
                              future:
                                  getDirectionFromPosition(positionSelected),
                              builder: (context, snapshot) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    snapshot.hasData
                                        ? snapshot.data
                                        : 'Cargando...',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: greenPrimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                );
                              })
                        ],
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              TxtForm(
                placeholder: 'Ingresa la regla',
                controller: _ruleController,
                inputType: InputType.Number,
                txtColor: txtPrimary,
                prefixIcon: const Icon(Icons.social_distance_outlined),
                errorMessage: S.current.Obligatorio,
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                label: 'Guardar',
                onPressed: () {
                  if (_ruleController.text.isNotEmpty) {
                    Location newLocation = Location(
                        id: null,
                        position: LatLng(positionSelected.latitude,
                            positionSelected.longitude),
                        rule: _ruleController.text);
                    setState(() {
                      addAssetLocation(newLocation);
                      editAddMode = false;
                    });
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  bottomInfoAsset(AssetModel asset) {
    return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.4,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        asset.name,
                        style: const TextStyle(
                            color: greenPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          assetSelected = null;
                          lstCircleMarkersAssetSelect = [];
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "ID: ${asset.id}",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    // default check
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Default",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Checkbox(
                        value: asset.defaultAsset ?? false,
                        onChanged: (value) {
                          // setState(() {
                          //   asset.defaultAsset = value!;
                          // });
                        }),

                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminARSection(
                                        assetAR: asset,
                                      )));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'Ver asset',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Posiciones: ${asset.locations.length}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: greenPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          positionSelected = null;
                          _ruleController.text = '';
                          editAddMode = true;
                          editionMode = false;
                        });
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            color: greenPrimary,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: asset.locations.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: IconButton(
                                  onPressed: () {
                                    setCameraToCurrentPosition(LatLng(
                                        asset
                                            .locations[index].position.latitude,
                                        asset.locations[index].position
                                            .longitude));
                                    //down the sheet

                                    scrollController.animateTo(
                                      scrollController.position.minScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeOut,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.gps_fixed,
                                    color: greenPrimary,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "ID: ${asset.locations[index].id}",
                                            style: const TextStyle(
                                                color: greenPrimary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'Regla: ${asset.locations[index].rule} mts',
                                            style: const TextStyle(
                                                color: greenPrimary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Lat: ${asset.locations[index].position.latitude}",
                                        style: const TextStyle(
                                            color: greenPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Lng: ${asset.locations[index].position.longitude}",
                                        style: const TextStyle(
                                            color: greenPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      directionWdg(
                                          asset.locations[index].position),
                                    ],
                                  ),
                                ),
                              ),
                              //options
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          positionSelected = null;

                                          locSelectedToEdit =
                                              asset.locations[index];
                                          editionMode = true;
                                          editAddMode = false;
                                        });

                                        //edit
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: greenPrimary,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deleteAssetLocation(
                                            asset.locations[index]);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: greenPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        });
  }

  bottomSearchDirection() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              // height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Buscar dirección',
                          style: TextStyle(
                              color: greenPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              SearchContainerActive = false;
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: greenPrimary,
                          ),
                        )
                      ],
                    ),
                  ),
                  searchBar(() {
                    searchPlace(_searchController.text);
                  }, () {
                    setState(() {
                      placesResult = [];
                    });
                  }),
                  Expanded(
                    child: ListView.builder(
                        itemCount: placesResult.length,
                        itemBuilder: (context, index) {
                          Map<String, LatLng> place = placesResult[index];
                          return directionCard(
                              place.keys.first, place.values.first);
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ));
        });
  }

  directionCard(String name, LatLng position) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                setCameraToCurrentPosition(position);
              },
              icon: const Icon(
                Icons.gps_fixed,
                color: greenPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      name,
                      style: const TextStyle(
                          color: greenPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Lat: ${position.latitude}",
                        style: const TextStyle(
                            color: greenPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Lng: ${position.longitude}",
                        style: const TextStyle(
                            color: greenPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  searchBar(Function search, Function clear) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Buscar por nombre',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _searchController.text = '';
                _searchController.clear();
                _searchController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _searchController.text.length));
                clear();
              });
            },
            icon: const Icon(
              Icons.close,
              color: greenPrimary,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                search();
                _searchController.text = '';
                _searchController.clear();
                _searchController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _searchController.text.length));
              });
            },
            icon: const Icon(
              Icons.search,
              color: greenPrimary,
            ),
          ),
        ],
      ),
    );
  }

  filterAssetPorNombre(String nombre) {
    var x = lstAssets
        .where((element) =>
            element.name.toLowerCase().contains(nombre.toLowerCase()))
        .toList();
    return x;
  }

  filterDialog() {
    //MultiSelect dialog filter por asset name
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              // height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filtrar',
                          style: TextStyle(
                              color: greenPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              filterContainerActive = false;
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: greenPrimary,
                          ),
                        )
                      ],
                    ),
                  ),
                  searchBar(() {
                    lstAssetsSearch =
                        filterAssetPorNombre(_searchController.text);
                  }, () {
                    lstAssetsSearch = lstAssets;
                  }),
                  Expanded(
                    child: ListView.builder(
                        itemCount: lstAssetsSearch.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (lstAssetsFilter.any((element) =>
                                    element.id == lstAssets[index].id)) {
                                  lstAssetsFilter.removeWhere((element) =>
                                      element.id == lstAssets[index].id);
                                  getMarkerFilterFromList(lstAssetsFilter);
                                } else {
                                  lstAssetsFilter.add(lstAssets[index]);
                                  getMarkerFilterFromList(lstAssetsFilter);
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: lstAssetsFilter.any((element) =>
                                          element.id ==
                                          lstAssetsSearch[index].id)
                                      ? greenPrimary
                                      : Colors.white,
                                  border:
                                      Border.all(color: greenPrimary, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  lstAssetsSearch[index].name,
                                  style: TextStyle(
                                      color: lstAssetsFilter.any((element) =>
                                              element.id ==
                                              lstAssetsSearch[index].id)
                                          ? Colors.white
                                          : greenPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ));
        });
  }
}
