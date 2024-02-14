
import 'dart:convert';

Todo todoFromMap(String str) => Todo.fromMap(json.decode(str));

String todoToMap(Todo data) => json.encode(data.toMap());

class Todo {
  final String? id;
  final String title;
  final String content;
  final bool isCompleted;

  Todo({
    this.id,
    required this.title,
    required this.content,
    required this.isCompleted,
  });

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    isCompleted: json["iscompleted"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "content": content,
    "iscompleted": isCompleted,
  };
}
