import 'package:reality_near/data/models/news_model.dart';
import 'package:reality_near/data/repository/news_repository.dart';

class GetNews {
  final NewsRepository _newsRepository = NewsRepository();

  GetNews();

  Future<List<NewsModel>> call() async {
    List<NewsModel> news = [];
    await _newsRepository.getNews().then((value) => value.fold(
          (failure) => print(failure),
          (success) => {news = success},
        ));

    return news;
  }
}
