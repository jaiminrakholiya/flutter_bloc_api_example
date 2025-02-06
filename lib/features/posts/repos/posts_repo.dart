import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc_api_example/features/posts/models/post_data_ui_model.dart';

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];

    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        posts = jsonData.map((item) => PostDataUiModel.fromJson(item)).toList();
      }
    } catch (e) {
      print("Error fetching posts: $e");
      return [];
    } finally {
      client.close(); // Close the client to prevent memory leaks.
    }

    return posts;
  }

  static Future<bool> addPost() async {
    var client = http.Client();

    try {
      var response = await client.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {"Content-Type": "application/json"}, // Added headers
        body: jsonEncode({ // Convert body to JSON
          "title": "flutter is good",
          "body": "flutter makes good apps",
          "userId": "34" // Converted to string
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error adding post: $e");
      return false;
    } finally {
      client.close(); // Close the client to prevent memory leaks.
    }
  }
}
