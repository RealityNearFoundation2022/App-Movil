import 'package:reality_near/data/models/cuponModel.dart';
import 'package:reality_near/data/repository/cuponRepository.dart';

class GetCuponsWithIdUseCase {
  final CuponRepository _repo = CuponRepository();
  final String cuponId;
  GetCuponsWithIdUseCase(this.cuponId);

  Future<CuponModel> call() async {
    CuponModel cupon = CuponModel();
    await _repo.ReadCupon(cuponId).then((value) => value.fold(
          (failure) => print(failure),
          (success) => {cupon = success},
        ));

    return cupon;
  }
}
