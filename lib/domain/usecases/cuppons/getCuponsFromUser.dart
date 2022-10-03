import 'package:reality_near/data/models/cuponAssignModel.dart';
import 'package:reality_near/data/models/cuponModel.dart';
import 'package:reality_near/data/repository/cuponRepository.dart';

class GetCuponsFromUserUseCase {
  final CuponRepository _repo = CuponRepository();
  GetCuponsFromUserUseCase();

  Future<List<AssignCuponModel>> getCupponsAssignRequest() async {
    List<AssignCuponModel> lstCupons = [];
    await _repo.ReadCuponFromUser().then((value) => value.fold(
          (failure) => print(failure),
          (success) => {
            lstCupons = success.toList()
      },
    ));
    return lstCupons;
  }

  Future<List<CuponModel>> call() async {
    //CONTACTOS - Obtenemos lista de solicitudes pendientes
    List<AssignCuponModel> lstCuponsAssign = await getCupponsAssignRequest();

    //CONTACTOS - Obtenemos los datos de usuarios en la lista anterior
    List<CuponModel> lstCupons = [];

    //obtenemos usuario por ID
    for (var cuponAssign in lstCuponsAssign) {
      // CuponModel cupon = CuponModel();
      await _repo
          .ReadCupon(cuponAssign.couponId.toString())
          .then((value) => value.fold(
            (failure) => print(failure),
            (success) => {lstCupons.add(success)},
      ));

      // lstCupons.add(cupon);
    }

    return lstCupons;
  }
}
