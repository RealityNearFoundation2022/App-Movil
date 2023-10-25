import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/datasource/API/report_datasource.dart';
import 'package:reality_near/data/models/reportModel.dart';

class ReportRepository {
  final ReportsRemoteDataSourceImpl reportsRemoteDataSourceImpl =
      ReportsRemoteDataSourceImpl();

  Future<Either<Failure, bool>> createReport(ReportModel report) async {
    try {
      final isCreated = await reportsRemoteDataSourceImpl.createReport(report);
      return Right(isCreated);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }
}
