import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progress_chart/progress_chart.dart';
import 'package:progress_chart/tem.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter progress chart demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
final rng = Random();
const dayHour = 24;
class _MyHomePageState extends State<MyHomePage> {
  late List<Score> _scores;

  @override
  void initState() {
    super.initState();
    final scores = List<Score>.generate(dayHour, (index) {
      final y = rng.nextDouble()*30.0;
      //final d = DateTime.now().add(Duration(days: -dayHour + index));//1 tuan truoc
      final d = DateTime.now().add(Duration(hours: 1+ index));
      return Score(y, d);
    });

    setState(() {
      _scores = scores;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(widget.title),
      ),
      body: Container(
        // color: Colors.red,
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              child: ProgressChart(_scores),
              
            ),
            
            
            temperatureChart()
          ],
        ),
      )
    );
  }
}
