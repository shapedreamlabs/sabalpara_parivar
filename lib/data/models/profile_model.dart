import 'package:sabalpara_family/sabalpara_family.dart';

class ProfileModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? age;
  final String? occupation;
  final String? roles;
  final String? businessName;
  final String? workTypeId;
  final String? standardId;
  final String? relation;
  final String? villageId;
  final String? cityId;
  final String? address;
  final String? accessToken;
  final String? villageName;
  final String? cityName;
  final String? worktypeName;
  final String? standardName;
  final String? roleName;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.age,
    this.occupation,
    this.roles,
    this.businessName,
    this.workTypeId,
    this.standardId,
    this.relation,
    this.villageId,
    this.cityId,
    this.address,
    this.accessToken,
    this.villageName,
    this.cityName,
    this.worktypeName,
    this.standardName,
    this.roleName,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    name: json["name"]?.toString(),
    email: json["email"]?.toString(),
    phone: json["phone"]?.toString(),
    avatar: json["avatar"]?.toString(),
    age: json["age"]?.toString(),
    occupation: json["occupation"]?.toString(),
    roles: json["roles"]?.toString(),
    businessName: json["business_name"]?.toString(),
    workTypeId: json["work_type_id"]?.toString(),
    standardId: json["standard_id"]?.toString(),
    relation: json["relation"]?.toString(),
    villageId: json["village_id"]?.toString(),
    cityId: json["city_id"]?.toString(),
    address: json["address"]?.toString(),
    accessToken: json["access_token"]?.toString(),
    villageName: json["village_name"]?.toString(),
    cityName: json["city_name"]?.toString(),
    worktypeName: json["worktype_name"]?.toString(),
    standardName: json["standard_name"]?.toString(),
    roleName: json["role_name"]?.toString(),
  );

  UserModel toUserModel() => UserModel(
    id: id?.toString(),
    name: name,
    email: email,
    phone: phone,
    image: avatar,
    occupation: occupation,
    age: age,
    village: villageName ?? villageId,
    address: address,
    city: cityName ?? cityId,
  );
}
