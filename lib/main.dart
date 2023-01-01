import 'package:flutter/material.dart';
import 'package:new_pp/convert_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amps converter',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:const Color(0xffA6170A),
        title: const Text("Volts/Watts/Amps calculator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.offline_bolt,
            size: 35,
            ),
            onPressed: () => {},
          ),
        ],
      ),
      body: const connverter_page(),
    );
  }
}
