import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Your custom screen
import 'notifications/notification_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications(); // Initialize notifications
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Expiration Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}