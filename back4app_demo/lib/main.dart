import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Back4App Parse Server credentials
  const keyApplicationId = '8lVnZJWP7p4KyaZb1L9yDuIUo82tNR4E1aeefBiz';
  const keyClientKey = 'FkaJF1rOa6oWlpBMBC3BH1RmKWq9kA8MvqOy71Ke';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  // Initialize Parse SDK
  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
    debug: true,  // Set false in production
  );

  runApp(StudentManagementApp());
}

class StudentManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
