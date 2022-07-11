import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jajanan_boeng/models/cart_model.dart';

class CheckoutService {
  String baseUrl = 'http://890d-158-140-182-101.ngrok.io/api';

  Future<bool> checkout(
      String token, List<CartModel> carts, double totalPrice) async {
    var url = '$baseUrl/checkout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var body = jsonEncode(
      {
        'items': carts
            .map(
              (cart) => {
                'id': cart.product.id,
                'quantity': cart.quantity,
              },
            )
            .toList(),
        'status': "PENDING",
        'total_price': totalPrice,
        'shipping_price': 0,
      },
    );

    print(body);

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // print(response.request);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Checkout');
    }
  }
}
