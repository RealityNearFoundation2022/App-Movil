import 'dart:convert';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:reality_near/data/models/nftModel.dart';

abstract class ContractRemoteDataSource {
  Future<double> getMyBalance();
  Future<List<NftModel>> getMyNFTs();
}

class ContractRemoteDataSourceImpl implements ContractRemoteDataSource {
  final String baseUrl = NEAR_RPC_TESTNET;
  var log = Logger();

  ContractRemoteDataSourceImpl();

  @override
  Future<double> getMyBalance() async {
    final url = baseUrl;
    var accoutId = await getPersistData('walletId');
    //convertimos a base64 los args
    var argsBase64 = convertToBase64('{"account_id":"$accoutId"}');
    Map data = {
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "query",
      "params": {
        "request_type": "call_function",
        "finality": "final",
        "account_id": "token.guxal.testnet",
        "method_name": "ft_balance_of",
        "args_base64": argsBase64
      }
    };
    var bodyData = json.encode(data);

    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: bodyData);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      List<dynamic> result = responseJson['result']['result'];
      List<int> resultResponse =
          result.map((e) => int.parse(e.toString())).toList();
      //convert ASCII array to string
      String resultString =
          String.fromCharCodes(resultResponse).replaceAll(RegExp(r'"'), '');
      log.i('Result: $resultString');

      var balance = double.parse(resultString) / 100000000;

      return balance;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NftModel>> getMyNFTs() async {
    final url = baseUrl;
    var accoutId = await getPersistData('walletId');
    //convertimos a base64 los args
    var argsBase64 = convertToBase64('{"account_id":"$accoutId"}');
    List<NftModel> lstNFTs = [];
    Map data = {
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "query",
      "params": {
        "request_type": "call_function",
        "finality": "final",
        "account_id": "nft3.guxal.testnet",
        "method_name": "nft_tokens_for_owner",
        "args_base64": argsBase64
      }
    };
    var bodyData = json.encode(data);

    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: bodyData);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      List<dynamic> result = responseJson['result']['result'];
      List<int> resultResponse =
          result.map((e) => int.parse(e.toString())).toList();

      //convert ASCII array to string
      String resultString = String.fromCharCodes(resultResponse);

      //convert srting to JSON
      var jsonResult = json.decode(resultString);

      log.i('Result: $jsonResult');
      //convert JSON to List<NFT>
      for (var item in jsonResult) {
        NftModel nft = NftModel.fromJson(item);
        lstNFTs.add(nft);
      }

      return lstNFTs;
    } else {
      throw ServerException();
    }
  }
}
