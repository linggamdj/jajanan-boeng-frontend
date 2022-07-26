import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jajanan_boeng/models/transaction_model.dart';

class TransactionService {
  String baseUrl = 'http://jajanan-boeng.my.id/api';

  Future<List<TransactionModel>> getTransactions(String token) async {
    var url = '$baseUrl/transactions';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<TransactionModel> transactions = [];
      // print(data);

      for (var item in data) {
        transactions.add(TransactionModel.fromJson(item));
      }
      // print(transactions);
      return transactions;
    } else {
      throw Exception('Gagal mendapatkan transaksi user');
    }
  }
}
