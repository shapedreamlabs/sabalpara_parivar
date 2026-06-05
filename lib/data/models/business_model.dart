class BusinessModel {
  final String? name;
  final String? phone;
  final String? village;
  final String? business;

  BusinessModel({this.name, this.phone, this.village, this.business});

  BusinessModel copyWith({
    String? name,
    String? phone,
    String? village,
    String? business,
  }) => BusinessModel(
    name: name ?? this.name,
    phone: phone ?? this.phone,
    village: village ?? this.village,
    business: business ?? this.business,
  );

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
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
