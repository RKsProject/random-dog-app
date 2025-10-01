import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const DogApp());
}

class DogApp extends StatelessWidget {
  const DogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Dog App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DogHomePage(),
    );
  }
}

class DogHomePage extends StatefulWidget {
  const DogHomePage({super.key});

  @override
  State<DogHomePage> createState() => _DogHomePageState();
}

class _DogHomePageState extends State<DogHomePage> {
  String? imageUrl;

  Future<void> fetchDogImage() async {
    final response = await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        imageUrl = data["message"];
      });
    } else {
      throw Exception("Failed to load dog image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🐶 Random Dog Image")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl == null
                ? const Text("Click the button to see a dog!")
                : Image.network(imageUrl!, height: 250, fit: BoxFit.cover),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchDogImage,
              child: const Text("Show Me a Dog 🐾"),
            ),
          ],
        ),
      ),
    );
  }
}
