import 'package:flutter/material.dart';
import 'package:flutter_video_player_test/video_player_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _link =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child:
                  _link.isEmpty ? const SizedBox() : VideoPlayerScreen(_link)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      )),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _link = _controller.text;
                        });
                      },
                      child: const Text('LOAD')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
