import 'package:flutter/cupertino.dart';
import 'package:jajanan_boeng/models/cart_model.dart';
import 'package:jajanan_boeng/services/checkout_service.dart';

class CheckoutProvider with ChangeNotifier {
  Future<bool> checkout(
      String token, List<CartModel> carts, int totalPrice) async {
    try {
      if (await CheckoutService().checkout(token, carts, totalPrice)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
