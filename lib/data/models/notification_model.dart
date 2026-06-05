class NotificationModel {
  final String? title;
  final String? image;
  final String? message;
  final String? createdAt;

  NotificationModel({this.title, this.image, this.message, this.createdAt});

  NotificationModel copyWith({
    String? title,
    String? image,
    String? message,
    String? createdAt,
  }) => NotificationModel(
    title: title ?? this.title,
    image: image ?? this.image,
    message: message ?? this.message,
    createdAt: createdAt ?? this.createdAt,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json["title"],
        image: json["image"],
        message: json["message"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "message": message,
    "createdAt": createdAt,
  };
}
