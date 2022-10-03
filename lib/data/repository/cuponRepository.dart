import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/datasource/API/cupon_datasource.dart';
import 'package:reality_near/data/models/cuponAssignModel.dart';
import 'package:reality_near/data/models/cuponModel.dart';

class CuponRepository {
  final CuponRemoteDataSourceImpl _repo = CuponRemoteDataSourceImpl();

  Future<Either<Failure, String>> AssignCuponToUser(String cuponId) async {
    try {
      var response = await _repo.AssignCuponToUser(cuponId);
      return Right(response);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, List<AssignCuponModel>>> ReadCuponFromUser() async {
    try {
      List<AssignCuponModel> lstCuppons = await _repo.ReadCuponFromUser();
      return Right(lstCuppons);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, CuponModel>> ReadCupon(String cuponId) async {
    try {
      CuponModel cupon = await _repo.ReadCupon(cuponId);
      return Right(cupon);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }
  Future<Either<Failure, AssignCuponModel>> RedeemCupon(String cuponId,String ownerId) async {
    try {
      AssignCuponModel cupon = await _repo.RedeemCupon(cuponId,ownerId);
      return Right(cupon);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }


}