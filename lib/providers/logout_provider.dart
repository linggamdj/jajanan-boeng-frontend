import 'package:flutter/cupertino.dart';
import 'package:jajanan_boeng/services/logout_service.dart';

class LogoutProvider with ChangeNotifier {
  Future<bool> logout(String token) async {
    try {
      if (await LogoutService().logout(token)) {
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
