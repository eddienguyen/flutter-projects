import 'package:working_with_api/models/post_model.dart';
import 'dart:async' show Future;
import 'package:http/http.dart' as http;

String url = "https://jsonplaceholder.typicode.com/posts/";

Future<Post> getPost() async {
  var response = await http.get('$url/1');
  return postFromJson(response.body);
}
