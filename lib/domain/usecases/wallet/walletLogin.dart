import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/repository/WalletRepository.dart';

class WalletLogin {
  WalletRepository walletRepository = WalletRepository();
  final String accountId;
  final BuildContext context;

  WalletLogin(this.context, this.accountId);

  Future<Either<Failure, dynamic>> call() async {
    return walletRepository.loginNearWallet(context, accountId);
  }
}
