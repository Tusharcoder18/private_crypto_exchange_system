import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545";
  final String _privateKey =
      "599e88531cff96185162a838a1fb50fd063e78504945cd76957bfbe445f17604";

  Web3Client? _client;
  bool? isLoading = true;

  String? _abiCode;
  EthereumAddress? _contractAddress;

  Credentials? _credentials;

  DeployedContract? _contract;
  ContractFunction? _getBalanceTPC;
  // ContractFunction? _getBalanceINR;
  ContractFunction? _buyTPC;
  ContractFunction? _sellTPC;

  int? _balance = 0;
  EthereumAddress? _address;

  int? get getCurrentBalance => _balance;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    String abiStringFile =
        await rootBundle.loadString("src/artifacts/TupperCoin.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    // _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _credentials = EthPrivateKey.fromHex(_privateKey);
    _address = await _credentials?.extractAddress();
  }

  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "TupperCoin"), _contractAddress!);

    // Extracting the functions, declared in contract.
    _getBalanceTPC = _contract?.function("equity_in_tuppercoins");
    // _getBalanceINR = _contract?.function("equity_in_inr");
    _buyTPC = _contract?.function("buy_tuppercoins");
    _sellTPC = _contract?.function("sell_tuppercoins");
    getBalance();
  }

  getBalance() async {
    // Getting the current balance declared in the smart contract.
    try {
      var currentBalance = await _client?.call(
          contract: _contract!, function: _getBalanceTPC!, params: [_address]);
      BigInt value = currentBalance![0];
      _balance = value.toInt();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  buyTPC(BigInt? amount) async {
    // Call the buy_tuppercoins function in smart contract
    try {
      isLoading = true;
      notifyListeners();
      await _client?.sendTransaction(
          _credentials!,
          Transaction.callContract(
            contract: _contract!,
            function: _buyTPC!,
            parameters: [_address, amount],
            // maxFeePerGas: EtherAmount.fromUnitAndValue(EtherUnit.ether, 100),
          ));
      getBalance();
      debugPrint("Bought $amount TPCs");
    } catch (e) {
      debugPrint("Didn't Bought $amount TPCs");
      debugPrint(e.toString());
    }
  }

  sellTPC(BigInt? amount) async {
    // Call the sell_tuppercoins function in smart contract
    try {
      isLoading = true;
      notifyListeners();
      await _client?.sendTransaction(
          _credentials!,
          Transaction.callContract(
              contract: _contract!,
              function: _sellTPC!,
              parameters: [_address, amount]));
      getBalance();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
