import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reality_near/data/models/fb_news_model.dart';

class FsNewsService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<fsNewsModel>> getNews() async {
    return await firestore
        .collection('noticias')
        .orderBy('Order', descending: true)
        .get()
        .then((value) {
      return value.docs.map((e) => fsNewsModel.fromSnapshot(e)).toList();
    });
  }
}
