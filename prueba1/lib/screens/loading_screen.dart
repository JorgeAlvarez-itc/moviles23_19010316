import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prueba1/models/card_clash_model.dart';

class LoadingScreen extends StatefulWidget {
  final Future<List<ClashCard>?> future;

  const LoadingScreen({Key? key, required this.future}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late final Timer _timer;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1000), (timer) {
      setState(() {
        _progressValue += 0.01;
      });
      if (_progressValue >= 1.0) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://pbs.twimg.com/media/ESLYB5pXUAIRiEl?format=jpg&name=large',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                value: _progressValue,
                color: Colors.white,
                backgroundColor: Colors.transparent,
                strokeWidth: 4.0,
              ),
              SizedBox(height: 16.0),
              Text(
                'Cargando',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
