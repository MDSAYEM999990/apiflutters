// In home.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = [];

  @override
  void initState() {
    super.initState();
    // Call the function to fetch posts when the widget initializes
    getPostApi();
  }

  Future<void> getPostApi() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        // Clear the list before adding new items
        postList.clear();
        // Add each post to the list
        for (Map<String, dynamic> i in data) {
          postList.add(PostModel.fromJson(i));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Text")),
      body: postList.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
          : ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          final post = postList[index];
          return Container(
           
            child: ListTile(


              title: Text(post.title ?? ''), // Handle null values
              subtitle: Text(post.body ?? ''), // Handle null values
            ),
          );
        },
      ),
    );
  }
}
