import 'dart:convert';

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    return new Post(
      userId: parsedJson['userId'],
      id: parsedJson['id'],
      title: parsedJson['title'],
      body: parsedJson['body'],
    );
  }
}

Post postFromJson(String jsonString) {
  /// decode raw JSON String
  final jsonResponse = json.decode(jsonString);

  /// fed jsonResponse into [Post.fromJson] so that this factory method can create a new Post object
  return Post.fromJson(jsonResponse);
}
