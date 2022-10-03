import 'package:flutter/cupertino.dart';
import 'package:near_flutter/near_flutter.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class WalletRepository {
  Near near;
  WalletAccount walletAccount;

  Future<Either<Failure, dynamic>> loginNearWallet(
      BuildContext context, String accountId) async {
    try {
      print('en funcion login');
      walletAccount = setupWallet(accountId);
      var response = await walletAccount.requestSignIn(
          context,
          'token.guxal.testnet',
          'Reality Near App',
          'https://www.google.com',
          'eduperaltas.testnet');
      print('response login with NEAR: $response');
      // persistData("walletId", accountId);
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
