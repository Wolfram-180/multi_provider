import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Test app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
  );
}

String now() => DateTime.now().toIso8601String();

@immutable
class Seconds {
  final String value;
  Seconds() : value = now();
}

class SecondsWidget extends StatelessWidget {
  const SecondsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seconds = context.watch<Seconds>();
    return Expanded(
      child: Container(
        color: Colors.blue,
        height: 100,
        child: Text(seconds.value),
      ),
    );
  }
}

@immutable
class Minutes {
  final String value;
  Minutes() : value = now();
}

class MinutesWidget extends StatelessWidget {
  const MinutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final minutes = context.watch<Minutes>();
    return Expanded(
      child: Container(
        color: Colors.green,
        height: 100,
        child: Text(minutes.value),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: MultiProvider(
        providers: [
          StreamProvider.value(
            initialData: Seconds(),
            value: Stream<Seconds>.periodic(
              const Duration(seconds: 1),
              (_) => Seconds(),
            ),
          ),
          StreamProvider.value(
            initialData: Minutes(),
            value: Stream<Minutes>.periodic(
              const Duration(seconds: 5),
              (_) => Minutes(),
            ),
          ),
        ],
        child: const Column(
          children: [
            Row(
              children: [
                SecondsWidget(),
                MinutesWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
