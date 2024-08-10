import 'package:flutter/material.dart';
import 'package:flutter_practice/fields_screen.dart';
import 'package:get_storage/get_storage.dart';

///Here I implement getStorage
final GetStorage getStorage = GetStorage();

void main() async {

  ///Here I initialize my getStorage
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FieldsScreen(),
    );
  }
}
