import 'package:world_famous_landmarks/data/models/landmark_model.dart';

class LandmarksNetworkResponseModel {
  List<Landmark>? landmarks;

  LandmarksNetworkResponseModel({required this.landmarks});

  LandmarksNetworkResponseModel.fromJson(Map<String, dynamic> json) {
    landmarks = [];
    for (Map<String, dynamic> element in json['landmarks']) {
      landmarks!.add(Landmark.fromJson(element));
    }
  }

  Map<String, dynamic> toJson() =>
      {'landmarks': landmarks!.map((e) => e.toJson()).toList(growable: false)};
}
