
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StudentPage(),
  ));
}

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List students = [];

  List<String> names = [
    'Anjali', 'Rahul', 'Priya', 'Ravi', 'Sneha',
    'Arun', 'Neha', 'Kiran', 'Divya', 'Akash'
  ];

  Future<void> fetchStudents() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      setState(() {
        students = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: students.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(names[index]),
                  subtitle: Text(students[index]['email']),
                );
              },
            ),
    );
  }
}
