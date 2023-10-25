import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/repository/cuponRepository.dart';

class AssignCuponUseCase {
  final CuponRepository _repo = CuponRepository();
  final String cuponId;
  AssignCuponUseCase(this.cuponId);

  Future<Either<Failure, String>> call() async {
    return await _repo.AssignCuponToUser(cuponId);
  }
}
