class InstructionsModel {
  final String? title;
  final String? description;

  InstructionsModel({this.title, this.description});

  InstructionsModel copyWith({String? title, String? description}) =>
      InstructionsModel(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  List<Object?> get props => [title, description];
}
