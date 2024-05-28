import 'package:flutter/material.dart';
import 'package:runtime_parser/pages/_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Runtime parser'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const RFWPage(),
                  ),
                );
              },
              child: const Text('rfw package'),
            ),
            const SizedBox.square(dimension: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const FlutterEvalPage(),
                  ),
                );
              },
              child: const Text('flutter_eval package'),
            ),
          ],
        ),
      ),
    );
  }
}
