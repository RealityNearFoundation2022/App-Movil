import 'package:near_flutter/near_flutter.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class WalletRepository {
  Near near;
  WalletAccount walletAccount;

  Future<Either<Failure, dynamic>> login(String accountId) async {
    try {
      print('en funcion login');
      walletAccount = setupWallet(accountId);
      Account jst = await near.account(accountId);
      var accessKeys = await jst.getAccessKeys();
      print('ACCESS KEYS: ${accessKeys[0]}');
      return const Right('usuario Logeado');
    } catch (e) {
      return const Left(ServerFailure(message: 'Error al logearse'));
    }
  }

  setupWallet(String accountId) {
    var keyStore = InMemoryKeyStore();
    var config = NearConfig(
        networkId: "testnet",
        nodeUrl: "https://rpc.testnet.near.org",
        masterAccount: '',
        helperUrl: '',
        initialBalance: null,
        keyStore: keyStore,
        walletUrl: "https://wallet.testnet.near.org/",
        signer: InMemorySigner(keyStore),
        headers: {});
    near = Near(config);
    return WalletAccount(accountId);
  }
}
