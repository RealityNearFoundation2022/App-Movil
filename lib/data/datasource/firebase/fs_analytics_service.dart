import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reality_near/data/models/fs_ga_places_model.dart';

class FsAnalyticsService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<FsGaPlaceModel>> getPlaces() async {
    // from this path: /app/analytics/places
    return await firestore
        .collection('app')
        .doc('analytics')
        .collection('places')
        .get()
        .then((value) {
      return value.docs.map((e) => FsGaPlaceModel.fromSnapshot(e)).toList();
    });
  }
}
