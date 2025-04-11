import 'package:flutter/widgets.dart';

class Post extends RestorableValue<Post> {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'userId': userId,
        'id': id,
      };

  @override
  Post createDefaultValue() => Post(userId: 0, id: 0, title: '', body: '');

  @override
  Post fromPrimitives(Object? data) {
    final json = data as Map<String, dynamic>;
    return Post.fromJson(json);
  }

  @override
  Object toPrimitives() {
    return toJson();
  }

  @override
  void didUpdateValue(Post? oldValue) {
    notifyListeners();
  }
}


class RestorablePostList extends RestorableValue<List<Post>> {
  RestorablePostList(List<Post> defaultValue) : _defaultValue = defaultValue;

  final List<Post> _defaultValue;

  @override
  List<Post> createDefaultValue() => List<Post>.from(_defaultValue);

  @override
  void didUpdateValue(List<Post>? oldValue) {
    notifyListeners();
  }

  @override
  List<Post> fromPrimitives(Object? data) {
    final list = data as List<dynamic>;
    return list.map((item) => Post.fromJson(item as Map<String, dynamic>)).toList();
  }

  @override
  Object? toPrimitives() {
    return value.map((post) => post.toJson()).toList();
  }
}


