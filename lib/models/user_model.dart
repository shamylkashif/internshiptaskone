class UserModel {
  String? id;
  String? name;
  String? email;
  String? bio;
  List<String>? interests;
  String? fcmToken;
  DateTime? createdAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.bio,
    this.interests,
    this.fcmToken,
    this.createdAt,
  });

  // Convert JSON to Dart Object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      bio: json["bio"],
      interests: json["interests"] != null
          ? List<String>.from(json["interests"])
          : [],
      fcmToken: json["fcmToken"],
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : null,
    );
  }

  // Convert Dart Object to JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "bio": bio,
      "interests": interests,
      "fcmToken": fcmToken,
      "createdAt": createdAt?.toIso8601String(),
    };
  }
}
