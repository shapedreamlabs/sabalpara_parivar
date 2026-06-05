import 'package:sabalpara_family/core/utils/enums.dart';

class FamilyMembersModel {
  final int? id;
  final String? name;
  final String? email;
  final FamilyMemberOccupation? occupation;
  final FamilyMemberWorkType? workType;
  final String? workTypeId;
  final String? businessName;
  final FamilyMemberOccupationRole? role;
  final String? age;
  final String? standard;
  final String? phone;
  final FamilyMemberRelation? relation;

  FamilyMembersModel({
    this.id,
    this.name,
    this.email,
    this.occupation,
    this.workType,
    this.workTypeId,
    this.businessName,
    this.role,
    this.age,
    this.standard,
    this.phone,
    this.relation,
  });

  FamilyMembersModel copyWith({
    int? id,
    String? name,
    String? email,
    FamilyMemberOccupation? occupation,
    FamilyMemberWorkType? workType,
    String? workTypeId,
    String? businessName,
    FamilyMemberOccupationRole? role,
    String? age,
    String? standard,
    String? phone,
    FamilyMemberRelation? relation,
  }) => FamilyMembersModel(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    occupation: occupation ?? this.occupation,
    workType: workType ?? this.workType,
    workTypeId: workTypeId ?? this.workTypeId,
    businessName: businessName ?? this.businessName,
    role: role ?? this.role,
    age: age ?? this.age,
    standard: standard ?? this.standard,
    phone: phone ?? this.phone,
    relation: relation ?? this.relation,
  );

  factory FamilyMembersModel.fromJson(Map<String, dynamic> json) =>
      FamilyMembersModel(
        id: json["id"],
        name: json["name"]?.toString(),
        email: json["email"]?.toString(),
        occupation: FamilyMemberOccupation.values.firstWhere(
          (e) => e.name == (json["occupation"]?.toString() ?? ""),
          orElse: () => FamilyMemberOccupation.none,
        ),
        workType: _workTypeFromId(json["work_type_id"]),
        workTypeId: json["work_type_id"]?.toString(),
        businessName: json["business_name"]?.toString(),
        role: _roleFromValue(json["roles"]),
        age: json["age"]?.toString(),
        standard: json["standard_id"]?.toString(),
        phone: json["phone"]?.toString(),
        relation: _relationFromValue(json["relation"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "occupation": occupation?.name,
    "work_type_id": workType == null ? null : workType!.index + 1,
    "business_name": businessName,
    "roles": role?.name,
    "age": age,
    "standard_id": standard,
    "phone": phone,
    "relation": relation?.name,
  };

  static FamilyMemberOccupationRole? _roleFromValue(dynamic value) {
    final raw = value?.toString();
    if (raw == null || raw.isEmpty) return null;
    return FamilyMemberOccupationRole.values.firstWhere(
      (e) => e.name == raw.toLowerCase(),
      orElse: () => FamilyMemberOccupationRole.worker,
    );
  }

  static FamilyMemberRelation? _relationFromValue(dynamic value) {
    final raw = value?.toString();
    if (raw == null || raw.isEmpty) return null;
    return FamilyMemberRelation.values.firstWhere(
      (e) => e.name == raw.toLowerCase(),
      orElse: () => FamilyMemberRelation.father,
    );
  }

  static FamilyMemberWorkType? _workTypeFromId(dynamic value) {
    final id = int.tryParse("${value ?? ''}");
    if (id == null || id <= 0) return null;
    if (id > FamilyMemberWorkType.values.length) {
      return FamilyMemberWorkType.values.first;
    }
    return FamilyMemberWorkType.values[id - 1];
  }

  List<Object?> get props => [
    id,
    name,
    email,
    occupation,
    workType,
    workTypeId,
    businessName,
    role,
    age,
    standard,
    phone,
    relation,
  ];
}
