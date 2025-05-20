import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  // List to store fetched Student objects
  List<ParseObject> students = [];

  // Holds the student being edited, if any
  ParseObject? editingStudent;

  @override
  void initState() {
    super.initState();
    fetchStudents(); // Load students when screen initializes
  }

  /// Fetches the list of students from Parse Server
  Future<void> fetchStudents() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Student'));
    final response = await query.query();

    if (response.success && response.results != null) {
      setState(() => students = response.results!.cast<ParseObject>());
    }
  }

  /// Saves a new student or updates an existing one
  Future<void> saveStudent() async {
    final name = nameController.text.trim();
    final ageText = ageController.text.trim();

    // Basic validation: name must not be empty, age must be a valid number
    if (name.isEmpty || ageText.isEmpty || int.tryParse(ageText) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter valid Name and numeric Age.")),
      );
      return;
    }

    final age = int.parse(ageText);

    if (editingStudent != null) {
      // Update existing student
      editingStudent!
        ..set('name', name)
        ..set('age', age);

      await editingStudent!.save();
      editingStudent = null;
    } else {
      // Create new student
      final student = ParseObject('Student')
        ..set('name', name)
        ..set('age', age);

      await student.save();
    }

    // Clear input fields and refresh the student list
    nameController.clear();
    ageController.clear();
    fetchStudents();
  }

  /// Deletes a student from the database
  Future<void> deleteStudent(ParseObject student) async {
    await student.delete();
    fetchStudents();
  }

  /// Prepares the form for editing a selected student
  void startEdit(ParseObject student) {
    nameController.text = student.get<String>('name') ?? '';
    ageController.text = (student.get<int>('age') ?? 0).toString();
    editingStudent = student;
  }

  /// Logs out the current user and navigates back to login page
  Future<void> logout() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) await user.logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Name input field
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),

            // Age input field (numeric keyboard)
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 10),

            // Button text changes depending on add/update mode
            ElevatedButton(
              onPressed: saveStudent,
              child: Text(editingStudent == null ? "Add a Student" : "Update Student Details"),
            ),

            Divider(),

            // List of students
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (_, i) {
                  final student = students[i];
                  return ListTile(
                    title: Text("${student.get<String>('name')} (Age: ${student.get<int>('age')})"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => startEdit(student),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteStudent(student),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
