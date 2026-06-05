class CityModel {
  final int? id;
  final String? name;

  CityModel({this.id, this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    name: json["name"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
