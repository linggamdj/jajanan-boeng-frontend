import 'package:http/http.dart' as http;

class LogoutService {
  String baseUrl = 'http://jajanan-boeng.my.id/api';

  Future logout(String token) async {
    var url = '$baseUrl/logout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(Uri.parse(url), headers: headers);
    // print(response.body);

    if (response.statusCode == 200) {
      // print(response.body);
    } else {
      throw Exception('Logout gagal');
    }
  }
}
