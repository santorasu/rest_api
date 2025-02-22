import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostAPI extends StatefulWidget {
  const PostAPI({super.key});

  @override
  State<PostAPI> createState() => _PostAPIState();
}

class _PostAPIState extends State<PostAPI> {
  List posts = [];
  bool isLoading = false;

  Future<void> fetchPost() async {
    setState(() {
      isLoading = true;
    });

    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (response.statusCode == 200) {
      setState(() {
        posts = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load posts');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  color: Colors.deepPurple.shade100,
                  margin: const EdgeInsets.all(10),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  post['id'].toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple),
                                ),
                              ),
                              Text(
                                "Title: ${post['title']}",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),
                              ),
                              Text(
                                "Post: ${post['body']}",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.deepPurple),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
