
import 'package:reality_near/data/datasource/API/asset_datadource.dart';

import '../models/assetModel.dart';

class AssetRepository {

  final AssetRemoteDataSourceImpl _repo = AssetRemoteDataSourceImpl();

  Future<AssetModel> getAsset(String id) async{
    return await _repo.getAsset(id);
  }
}