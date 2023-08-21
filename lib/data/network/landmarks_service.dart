import 'package:flutter/services.dart';
import 'package:world_famous_landmarks/data/network/network_api_service.dart';

class LandmarksService extends NetworkApiService {
  static Future<String> getLandmarksList() async {
    // This line can be replaced by http call
    dynamic response =
        await rootBundle.loadString('assets/json/landmarks.json');
    return response;
  }
}
