import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:near_api_flutter/near_api_flutter.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:reality_near/data/datasource/near/nearFunctions.dart';

class WalletRepository {
  Account connectedAccount;
  String userAccount = '';

  Future<Either<Failure, dynamic>> loginNearWallet(BuildContext context) async {
    try {
      //Generate Keys
      KeyPair fullAccessKeyPair = KeyStore.newKeyPair();
      if (kDebugMode) {
        print(KeyStore.publicKeyToString(fullAccessKeyPair.publicKey));
      }

      String walletURL = 'https://app.mynearwallet.com/login/?';
      String contractId = 'token.guxal.testnet';
      String appTitle = 'Reality Near';
      String accountId = userAccount;
      String nearSignInSuccessUrl = 'https://www.youtube.com';
      String nearSignInFailUrl = 'https://www.netflix.com/browse';

      connectedAccount = await NEARFunctions.loginWithFullAccess(
          walletURL,
          contractId,
          accountId,
          appTitle,
          nearSignInSuccessUrl,
          nearSignInFailUrl);

      var x = connectedAccount;

      // var user = await NEARFus
      return const Right('usuario Logeado ');
    } catch (e) {
      return const Left(ServerFailure(message: 'Error al logearse'));
    }
  }
}
