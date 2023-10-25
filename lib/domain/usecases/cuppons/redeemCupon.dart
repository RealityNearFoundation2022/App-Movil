import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/models/cuponAssignModel.dart';
import 'package:reality_near/data/repository/cuponRepository.dart';

class RedeemCuponUseCase {
  final CuponRepository _repo = CuponRepository();
  final String cuponId;
  final String ownerId;
  RedeemCuponUseCase(this.cuponId,this.ownerId);

  Future<Either<Failure, AssignCuponModel>> call() async {
    return await _repo.RedeemCupon(cuponId,ownerId);
  }
}
