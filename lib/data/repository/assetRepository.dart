import 'package:reality_near/data/datasource/firebase/fs_asset_service.dart';

import '../models/asset_model.dart';

class AssetRepository {
  final FsAssetService _service = AssetRemoteDataSourceImpl();

  Future<AssetModel> getAsset(String id) async {
    return await _service.getAsset(id);
  }

  Future<List<AssetModel>> getAllAssets() async {
    return await _service.getAllAssets();
  }
}
