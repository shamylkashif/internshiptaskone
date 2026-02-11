class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? bio;
  List<String>? interests;
  String? fcmToken;
  DateTime? createdAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profileImage,
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
      profileImage: json["profileImage"],
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
      "profileImage": profileImage,
      "bio": bio,
      "interests": interests,
      "fcmToken": fcmToken,
      "createdAt": createdAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? bio,
    List<String>? interests,
    String? fcmToken,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage ,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
      fcmToken: fcmToken ?? this.fcmToken,
      createdAt: createdAt ?? this.createdAt,
    );
  }

}
