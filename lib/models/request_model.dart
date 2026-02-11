import 'user_model.dart';

class RequestModel {
  String? id;
  UserModel? fromUser;
  UserModel? toUser;
  String? status;
  DateTime? createdAt;

  RequestModel({
    this.id,
    this.fromUser,
    this.toUser,
    this.status,
    this.createdAt,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json["_id"],
      fromUser: json["fromUser"] != null ? UserModel.fromJson(json["fromUser"]) : null,
      toUser: json["toUser"] != null ? UserModel.fromJson(json["toUser"]) : null,
      status: json["status"],
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "fromUser": fromUser?.toJson(),
      "toUser": toUser?.toJson(),
      "status": status,
      "createdAt": createdAt?.toIso8601String(),
    };
  }
}
