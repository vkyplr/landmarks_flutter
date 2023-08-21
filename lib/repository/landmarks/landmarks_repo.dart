import 'dart:convert';

import 'package:world_famous_landmarks/data/models/error_model.dart';
import 'package:world_famous_landmarks/data/models/landmark_model.dart';
import 'package:world_famous_landmarks/data/models/landmarks_network_response_model.dart';
import 'package:world_famous_landmarks/data/network/landmarks_service.dart';

class LandmarksRepo {
  // Get List of All Landmarks
  static Future<dynamic> getAllLandmarks() async {
    try {
      String response = await LandmarksService.getLandmarksList();
      Map<String, dynamic> responseJson = jsonDecode(response);
      return LandmarksNetworkResponseModel.fromJson(responseJson);
    } catch (e) {
      return ErrorModel(message: 'Unable to Fetch Landmarks List');
    }
  }

  // Get Specific Landmark By its ID
  static Future<dynamic> getLandmarkById(int id) async {
    try {
      String response = await LandmarksService.getLandmarksList();

      // We will not need to compute this when we implement Network API because this will be computed and returned to us by Network Service
      Map<String, dynamic> responseJson = {
        'landmarks': [
          ...jsonDecode(response)['landmarks']
              .where((element) => element['id'] == id)
              .toList()
        ]
      };
      return LandmarksNetworkResponseModel.fromJson(responseJson);
    } catch (e) {
      return ErrorModel(message: 'Unable to Fetch Landmark Info');
    }
  }

  // Get Landmark(s) By Search Text
  static Future<dynamic> getLandmarkBySearchText(String searchText) async {
    try {
      String response = await LandmarksService.getLandmarksList();

      // We will not need to compute this when we implement Network API because this will be computed and returned to us by Network Service
      Map<String, dynamic> responseJson = jsonDecode(response);
      if (searchText.isNotEmpty) {
        List<Landmark> filteredLandmarks = [];
        responseJson['landmarks'].forEach((element) {
          if (element['name'].toLowerCase().contains(searchText)) {
            filteredLandmarks.add(Landmark.fromJson(element));
          }
        });
        return LandmarksNetworkResponseModel(landmarks: filteredLandmarks);
      } else {
        return LandmarksNetworkResponseModel.fromJson(jsonDecode(response));
      }
    } catch (e) {
      return ErrorModel(message: 'Unable to Fetch Landmark Info');
    }
  }
}
