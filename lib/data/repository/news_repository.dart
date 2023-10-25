import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/datasource/API/news_datasource.dart';
import 'package:reality_near/data/models/news_model.dart';

class NewsRepository {
  final NewsRemoteDataSource _repo = NewsRemoteDataSourceImpl();

  Future<Either<Failure, List<NewsModel>>> getNews() async {
    try {
      List<NewsModel> news = await _repo.getNews();
      return Right(news);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }
}
