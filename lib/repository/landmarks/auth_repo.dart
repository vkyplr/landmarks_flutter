import 'package:world_famous_landmarks/data/models/auth_network_response_model.dart';
import 'package:world_famous_landmarks/data/models/error_model.dart';
import 'package:world_famous_landmarks/data/network/auth_service.dart';

class AuthRepo {
  static Future<dynamic> login(
      {required String email, required String password}) async {
    final bool result =
        await AuthService.login(email: email, password: password);
    if (result) {
      return AuthNetworkResponseModel(isLoggedIn: result, email: email);
    } else {
      return ErrorModel(message: 'Invalid Email or Password');
    }
  }
}
