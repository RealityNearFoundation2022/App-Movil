import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/models/reportModel.dart';
import 'package:reality_near/data/repository/reportRepository.dart';
import 'package:reality_near/data/repository/userRepository.dart';
import 'package:reality_near/domain/entities/user.dart';

class CreateReport {
  ReportRepository reportRepository = ReportRepository();
  final ReportModel report;

  CreateReport(this.report);

  Future<Either<Failure, bool>> call() async {
    return await reportRepository.createReport(report);
  }
}
