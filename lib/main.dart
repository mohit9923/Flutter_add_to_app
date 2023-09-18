import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  static const platform = MethodChannel('isMyVCPresented');
  static const platform2 = MethodChannel('isMyVCPresented2');

  String messageFromAndroid = 'No message yet';
  String messageFromAndroid2 = '';

  @override
  void initState() {
    super.initState();

    getMyVcPresentedCallback();
    getMyVcPresentedCallback2();
  }

  getMyVcPresentedCallback() {
    platform2.setMethodCallHandler((call) async {
      if (call.method == 'messageFromAndroid') {
        final String message = call.arguments;
        print("platform2 message is $message");
        setState(() {
          messageFromAndroid = message;
        });
      }
    });
  }

  getMyVcPresentedCallback2() {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'messageFromAndroid2') {
        final String message = call.arguments;
        print("platform1 message is $message");
        setState(() {
          messageFromAndroid2 = message;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              messageFromAndroid,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                messageFromAndroid2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
