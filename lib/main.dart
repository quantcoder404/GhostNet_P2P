import 'package:flutter/material.dart';


import 'login_page.dart';
import 'home_page.dart';
import 'department_page.dart';

void main() {
  runApp(const GhostNetApp());
}

class GhostNetApp extends StatefulWidget {
  const GhostNetApp({super.key});

  @override
  State<GhostNetApp> createState() => _GhostNetAppState();
}

class _GhostNetAppState extends State<GhostNetApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GhostNet',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
            )
          : ThemeData.light().copyWith(

            ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => RecentChatsPage(
              isDarkMode: isDarkMode,
              toggleTheme: toggleTheme,
            ),
        '/departments': (context) => const DepartmentsPage(),
      },
    );
  }
}
