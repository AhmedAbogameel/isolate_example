import 'dart:isolate';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCounter(),
    );
  }
}

class MyCounter extends StatefulWidget {
  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {

  @override
  void initState() {
    startIsolate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('press'),
          onPressed: ()async{
            receivePort.sendPort.send('pressed');
          },
        ),
      ),
    );
  }
}

ReceivePort receivePort = ReceivePort();

void startIsolate()async {
  await Isolate.spawn(isolate, receivePort.sendPort);
  receivePort.listen((message) {
    print('i\'m listening from isolate!');
    print('message from isolate : ' + message);
  });
}

void isolate(message) async {
  print('start your isolate');
}