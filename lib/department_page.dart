import 'package:flutter/material.dart';

class DepartmentsPage extends StatelessWidget {
  const DepartmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> departments = [
      {'name': 'Artificial Intelligence & Data Science', 'avatar': 'assets/ai.png'},
      {'name': 'Mechanical Engineering', 'avatar': 'assets/mech.png'},
      {'name': 'Civil Engineering', 'avatar': 'assets/civil.png'},
      {'name': 'Information Technology', 'avatar': 'assets/it.png'},
      {'name': 'Computer Engineering', 'avatar': 'assets/comp.png'},
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              padding: const EdgeInsets.only(left: 0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 5),
            const Text(
              'Select Departments',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(color: Colors.grey, thickness: 0.3, height: 1),
        ),
      ),
      body: ListView.builder(
        itemCount: departments.length,
        itemBuilder: (context, index) {
          final department = departments[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(department['avatar']),
            ),
            title: Text(department['name'], style: const TextStyle(fontSize: 18, color: Colors.white)),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${department['name']} selected!')),
              );
            },
          );
        },
      ),
    );
  }
}