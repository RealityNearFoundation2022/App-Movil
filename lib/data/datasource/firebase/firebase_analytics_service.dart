import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:latlong2/latlong.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/datasource/firebase/fs_analytics_service.dart';
import 'package:reality_near/data/models/fs_ga_places_model.dart';
import 'package:reality_near/data/models/user_model.dart';

class FirebaseAnalyticsService {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> initialize() async {
    await analytics.setAnalyticsCollectionEnabled(true);
  }

  //Esta es la base para crear eventos
  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    await analytics.logEvent(name: name, parameters: parameters);
  }

  //Set User Properties Location
  Future<void> setUserProperties() async {
    //get userLocation
    var currentLocation = await getCurrentLocation();
    LatLng userLocation =
        LatLng(currentLocation.latitude, currentLocation.longitude);

    //get analytics places from firestore
    List<FsGaPlaceModel> places = await FsAnalyticsService().getPlaces();

    String userLocationName = 'other';
    for (var place in places) {
      if (place.isInside(userLocation)) {
        userLocationName = place.name;
        break;
      }
    }

    String userJson = await getPreference('user');
    UserModel user = UserModel().userModelFromJson(userJson);

    await analytics.setUserProperty(
        name: 'user_location', value: userLocationName);
    await analytics.setUserProperty(
        name: 'user_email', value: user.email ?? 'no_email');
  }

  Future<void> setCurrentScreen(String screenName) async {
    await analytics.setCurrentScreen(screenName: screenName);
  }

  Future<void> setSessionTimeoutDuration(Duration time) async {
    await analytics.setSessionTimeoutDuration(time);
  }
}
