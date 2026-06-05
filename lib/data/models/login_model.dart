import 'package:sabalpara_family/data/models/user_model.dart';

class LoginModel {
  final int? id;
  final String? provider;
  final String? providerId;
  final int? isSocialEmailExist;
  final String? parentId;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? bio;
  final String? age;
  final String? occupation;
  final dynamic roles;
  final String? businessName;
  final int? workTypeId;
  final int? standardId;
  final String? relation;
  final int? villageId;
  final int? cityId;
  final String? address;
  final int? roleId;
  final String? urlFb;
  final String? urlInsta;
  final String? urlTwitter;
  final String? urlLinkedin;
  final int? newsLetter;
  final String? emailVerifiedAt;
  final String? accessToken;
  final String? rememberCode;
  final String? lastLogin;
  final String? socialUpdateDate;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  LoginModel({
    this.id,
    this.provider,
    this.providerId,
    this.isSocialEmailExist,
    this.parentId,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.bio,
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
    this.roleId,
    this.urlFb,
    this.urlInsta,
    this.urlTwitter,
    this.urlLinkedin,
    this.newsLetter,
    this.emailVerifiedAt,
    this.accessToken,
    this.rememberCode,
    this.lastLogin,
    this.socialUpdateDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json["id"],
    provider: json["provider"]?.toString(),
    providerId: json["provider_id"]?.toString(),
    isSocialEmailExist: json["is_social_email_exist"],
    parentId: json["parent_id"]?.toString(),
    name: json["name"]?.toString(),
    email: json["email"]?.toString(),
    phone: json["phone"]?.toString(),
    avatar: json["avatar"]?.toString(),
    bio: json["bio"]?.toString(),
    age: json["age"]?.toString(),
    occupation: json["occupation"]?.toString(),
    roles: json["roles"],
    businessName: json["business_name"]?.toString(),
    workTypeId: json["work_type_id"],
    standardId: json["standard_id"],
    relation: json["relation"]?.toString(),
    villageId: json["village_id"],
    cityId: json["city_id"],
    address: json["address"]?.toString(),
    roleId: json["role_id"],
    urlFb: json["url_fb"]?.toString(),
    urlInsta: json["url_insta"]?.toString(),
    urlTwitter: json["url_twitter"]?.toString(),
    urlLinkedin: json["url_linkedin"]?.toString(),
    newsLetter: json["news_letter"],
    emailVerifiedAt: json["email_verified_at"]?.toString(),
    accessToken: json["access_token"]?.toString(),
    rememberCode: json["remember_code"]?.toString(),
    lastLogin: json["last_login"]?.toString(),
    socialUpdateDate: json["social_update_date"]?.toString(),
    status: json["status"],
    createdAt: json["created_at"]?.toString(),
    updatedAt: json["updated_at"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider": provider,
    "provider_id": providerId,
    "is_social_email_exist": isSocialEmailExist,
    "parent_id": parentId,
    "name": name,
    "email": email,
    "phone": phone,
    "avatar": avatar,
    "bio": bio,
    "age": age,
    "occupation": occupation,
    "roles": roles,
    "business_name": businessName,
    "work_type_id": workTypeId,
    "standard_id": standardId,
    "relation": relation,
    "village_id": villageId,
    "city_id": cityId,
    "address": address,
    "role_id": roleId,
    "url_fb": urlFb,
    "url_insta": urlInsta,
    "url_twitter": urlTwitter,
    "url_linkedin": urlLinkedin,
    "news_letter": newsLetter,
    "email_verified_at": emailVerifiedAt,
    "access_token": accessToken,
    "remember_code": rememberCode,
    "last_login": lastLogin,
    "social_update_date": socialUpdateDate,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  UserModel toUserModel() => UserModel(
    id: id?.toString(),
    name: name,
    email: email,
    phone: phone,
    image: avatar,
    occupation: occupation,
    age: age,
    village: villageId?.toString(),
    address: address,
    city: cityId?.toString(),
  );
}
