import 'package:world_famous_landmarks/data/network/network_api_service.dart';

class AuthService extends NetworkApiService {
  static Future<bool> login(
      {required String email, required String password}) async {
    // This line can be replaced by http call
    return email == 'user@app.com' && password == 'secret';
  }
}
