import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
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
  int _counter = 0;
  static const platform = MethodChannel('channel'); // name of channel
  Future<void> _generateRandomNumber() async {
    int random;
    try {
      random = await platform.invokeMethod('getRandomNumber');
    } on PlatformException catch (e) {
      random = 0;
    }
    setState(() {
      _counter = random;
    });
  }

  void printFunction() async {
    await platform.invokeMethod("helloWorld",
        {"text": "Hello Salama , You are great person."}).then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Kotlin generates the following number:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: _generateRandomNumber,
            child: const Icon(Icons.refresh),
          ),
          //
          FloatingActionButton(
            onPressed: printFunction,
            tooltip: 'Generate',
            child: const Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}
