import 'dart:convert';
import 'package:jajanan_boeng/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'http://5ca3-158-140-182-101.ngrok.io/api';

  // REGISTER
  Future<UserModel> register({
    required name,
    required username,
    required address,
    required phone,
    required password,
  }) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username.toLowerCase(),
      'address': address,
      'phone': phone,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      print(response.body);
      print(response.headers);
      throw Exception('Gagal Register');
    }
  }

  // LOGIN
  Future<UserModel> login({
    required username,
    required password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'username': username.toLowerCase(),
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      print(response.body);
      throw Exception('Gagal Login');
    }
  }

  // UPDATE
  Future<bool> update(
      String token, String name, String address, String phone) async {
    var url = '$baseUrl/user';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'name': name,
      'address': address,
      'phone': phone,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Edit Profile');
    }
  }
}
