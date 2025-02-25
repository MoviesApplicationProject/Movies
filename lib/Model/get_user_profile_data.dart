class GetUserProfileData {
  final String? type;
  final GetprofiledataProperties? properties;

  GetUserProfileData({
    required this.type,
    required this.properties,
  });

  factory GetUserProfileData.fromJson(Map<String, dynamic> json){
    return GetUserProfileData(
      type: json["type"],
      properties: json["properties"] == null ? null : GetprofiledataProperties.fromJson(json["properties"]),
    );
  }

}

//profile properties
class GetprofiledataProperties {
  final Message? message;
  final Data? data;

  GetprofiledataProperties({
    required this.message,
    required this.data,
  });

  factory GetprofiledataProperties.fromJson(Map<String, dynamic> json){
    return GetprofiledataProperties(
      message: json["message"] == null ? null : Message.fromJson(json["message"]),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}
// Data Class
class Data {

  final String? type;
  final DataProperties? properties;
  Data({
    required this.type,
    required this.properties,
  });



  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      type: json["type"],
      properties: json["properties"] == null ? null : DataProperties.fromJson(json["properties"]),
    );
  }

}
// Properties data
class DataProperties {
  DataProperties({
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

  final Message? id;
  final Message? email;
  final Message? password;
  final Message? name;
  final Message? phone;
  final Message? avaterId;
  final Message? createdAt;
  final Message? updatedAt;
  final Message? v;

  factory DataProperties.fromJson(Map<String, dynamic> json){
    return DataProperties(
      id: json["_id"] == null ? null : Message.fromJson(json["_id"]),
      email: json["email"] == null ? null : Message.fromJson(json["email"]),
      password: json["password"] == null ? null : Message.fromJson(json["password"]),
      name: json["name"] == null ? null : Message.fromJson(json["name"]),
      phone: json["phone"] == null ? null : Message.fromJson(json["phone"]),
      avaterId: json["avaterId"] == null ? null : Message.fromJson(json["avaterId"]),
      createdAt: json["createdAt"] == null ? null : Message.fromJson(json["createdAt"]),
      updatedAt: json["updatedAt"] == null ? null : Message.fromJson(json["updatedAt"]),
      v: json["__v"] == null ? null : Message.fromJson(json["__v"]),
    );
  }

}

class Message {
  Message({
    required this.type,
  });

  final String? type;

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      type: json["type"],
    );
  }

}
