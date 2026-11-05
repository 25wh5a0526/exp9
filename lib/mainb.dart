
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StudentPage(),
  ));
}

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  Future<List> fetchStudents() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load students');
    }
  }

  final List<String> names = const [
    'Rahul', 'Anjali', 'Priya', 'Ravi', 'Sneha',
    'Arun', 'Neha', 'Kiran', 'Divya', 'Akash'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetched Student Data'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List>(
        future: fetchStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          final students = snapshot.data!;

          return ListView.separated(
            itemCount: students.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  names[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Student ID: ${students[index]['id']}\n'
                  'Email: ${students[index]['email']}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
