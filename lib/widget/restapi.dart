import 'dart:convert';
import 'package:restapi/widget/postapi.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestAPI extends StatefulWidget {
  const RestAPI({super.key});

  @override
  State<RestAPI> createState() => _RestAPIState();
}

class _RestAPIState extends State<RestAPI> {
  List users = [];
  bool isLoading = false;
  int _currentIndex = 0;

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
    });

    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      setState(() {
        users = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ✅ Moved AppBar here
        title: Text(
          _currentIndex == 0 ? 'User List' : 'Post API', // Dynamic title
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _currentIndex == 0
          ? UserLists(isLoading: isLoading, users: users)
          : const PostAPI(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Users"),
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add), label: "Post API"),
        ],
      ),
    );
  }
}

class UserLists extends StatelessWidget {
  const UserLists({
    super.key,
    required this.isLoading,
    required this.users,
  });

  final bool isLoading;
  final List users;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Card(
                  color: Colors.deepPurple.shade100,
                  margin: const EdgeInsets.all(10),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 5,
                  child: const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      radius: 24,
                    ),
                    title: SizedBox(
                      width: 100,
                      height: 15,
                      child: Card(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        SizedBox(
                          width: 150,
                          height: 12,
                          child: Card(color: Colors.white),
                        ),
                        SizedBox(height: 4),
                        SizedBox(
                          width: 120,
                          height: 12,
                          child: Card(color: Colors.white),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                color: Colors.deepPurple.shade100,
                margin: const EdgeInsets.all(10),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      user['name'][0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    user['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.deepPurple),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text("User Name: ${user['username']}"),
                      const SizedBox(height: 4),
                      Text("Email: ${user['email']}"),
                      const SizedBox(height: 4),
                      Text("Phone: ${user['phone']}"),
                      const SizedBox(height: 4),
                      Text("Website: ${user['website']}"),
                      const SizedBox(height: 4),
                      Text(
                          "Address: ${user['address']['city']} , ${user['address']['street']}"),
                      const SizedBox(height: 4),
                      Text("Company: ${user['company']['name']}"),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
