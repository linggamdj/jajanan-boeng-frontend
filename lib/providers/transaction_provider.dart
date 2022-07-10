import 'package:flutter/cupertino.dart';
import 'package:jajanan_boeng/models/transaction_model.dart';
import 'package:jajanan_boeng/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  set transactions(List<TransactionModel> transactions) {
    _transactions = transactions;
    notifyListeners();
  }

  Future<void> getTransactions(String token) async {
    try {
      List<TransactionModel> transactions =
          await TransactionService().getTransactions(token);
      _transactions = transactions;
    } catch (e) {
      print(e);
    }
  }
}
