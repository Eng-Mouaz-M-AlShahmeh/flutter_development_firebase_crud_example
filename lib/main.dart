/* Developed by Eng Mouaz M. AlShahmeh */
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/controllers/providers/todo.dart';
import 'package:firebase_example/controllers/services/firebase/firebase_options.dart';
import 'package:firebase_example/views/screens/crud/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // TODO: add this line above run app
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: add this line above run app
  await Firebase.initializeApp(
    // TODO: DefaultFirebaseOptions was given automatic from new flutter fire project
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Development Firebase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(),
    );
  }
}
