class Landmark {
  int? id;
  String? name;
  String? description;
  String? photoUrl;

  Landmark(
      {required this.id,
      required this.name,
      required this.description,
      required this.photoUrl});

  Landmark.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'photoUrl': photoUrl
      };
}
