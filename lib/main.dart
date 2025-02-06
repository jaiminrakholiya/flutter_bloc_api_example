import 'package:flutter/material.dart';
import 'package:flutter_bloc_api_example/features/home_page/home_page.dart';
import 'package:flutter_bloc_api_example/features/posts/ui/posts_page.dart';

void main() async{
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const PostsPage(),
    );
  }
}
