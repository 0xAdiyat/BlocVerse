import 'package:equatable/equatable.dart';

final class Post extends Equatable {
  const Post({required this.id, required this.title, required this.body});

  final int id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );

  @override
  List<Object> get props => [id, title, body];
}
