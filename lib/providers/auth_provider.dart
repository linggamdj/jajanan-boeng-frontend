import 'package:flutter/material.dart';
import 'package:jajanan_boeng/models/user_model.dart';
import 'package:jajanan_boeng/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  // REGISTER
  Future<bool> register({
    required String name,
    required String username,
    required String address,
    required String phone,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        address: address,
        phone: phone,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // LOGIN
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        username: username,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // UPDATE PROFILE
  Future<bool> update(
    String token,
    String name,
    String address,
    String phone,
  ) async {
    try {
      if (await AuthService().update(token, name, address, phone)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  // CHANGE PASSWORD
  Future<bool> changePassword(
    String token,
    String newPassword,
  ) async {
    try {
      if (await AuthService().changePassword(token, newPassword)) {
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
