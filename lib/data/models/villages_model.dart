class VillagesModel {
  final String? name;
  final String? phone;
  final String? village;
  final String? business;

  VillagesModel({this.name, this.phone, this.village, this.business});

  VillagesModel copyWith({
    String? name,
    String? phone,
    String? village,
    String? business,
  }) => VillagesModel(
    name: name ?? this.name,
    phone: phone ?? this.phone,
    village: village ?? this.village,
    business: business ?? this.business,
  );

  factory VillagesModel.fromJson(Map<String, dynamic> json) => VillagesModel(
    name: json["name"],
    phone: json["phone"],
    village: json["village"],
    business: json["business"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "village": village,
    "business": business,
  };
}
