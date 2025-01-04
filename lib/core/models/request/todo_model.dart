
class TodoModel {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'] == 1,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted ? 1 : 0,
      };
}
