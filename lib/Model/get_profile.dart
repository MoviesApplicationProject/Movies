class GetUserProfileData {
  final String? message;
  final Data? data;

  GetUserProfileData({
    required this.message,
    required this.data,
  });

  factory GetUserProfileData.fromJson(Map<String, dynamic> json){
    return GetUserProfileData(
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.avaterId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? email;
  final String? password;
  final String? name;
  final String? phone;
  final int? avaterId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      email: json["email"],
      password: json["password"],
      name: json["name"],
      phone: json["phone"],
      avaterId: json["avaterId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
