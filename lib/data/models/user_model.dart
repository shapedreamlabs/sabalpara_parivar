import 'package:sabalpara_family/sabalpara_family_extra.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? occupation;
  final String? age;
  final String? village;
  final String? address;
  final String? city;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.occupation,
    this.age,
    this.village,
    this.address,
    this.city,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? occupation,
    String? age,
    String? village,
    String? address,
    String? city,
  }) => UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    image: image ?? this.image,
    occupation: occupation ?? this.occupation,
    age: age ?? this.age,
    village: village ?? this.village,
    address: address ?? this.address,
    city: city ?? this.city,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    occupation: json["occupation"],
    age: json["age"],
    village: json["village"],
    address: json["address"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "occupation": occupation,
    "age": age,
    "village": village,
    "address": address,
    "city": city,
  };
}
