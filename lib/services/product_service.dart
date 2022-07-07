import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jajanan_boeng/models/product_model.dart';

class ProductService {
  String baseUrl = 'http://95c1-158-140-182-101.ngrok.io/api';

  Future<List<ProductModel>> getProducts() async {
    var url = '$baseUrl/products';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal mendapatkan produk');
    }
  }
}
