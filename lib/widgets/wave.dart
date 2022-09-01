import 'package:flutter/material.dart';
import 'package:flutter_wioso/const.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveAnimationWidget extends StatelessWidget {
  const WaveAnimationWidget({Key? key}) : super(key: key);

  static const _gradients = [
    [primaryColor, Colors.lightBlueAccent],
    [Color.fromARGB(255, 150, 171, 182), Colors.blue],
    [Colors.blueAccent, primaryColor],
    [primaryColor, Color(0xb8b8b8)]
  ];

  static const _durations = [35000, 19440, 10800, 6000];

  static const _heightPercentages = [0.14, 0.23, 0.20, 0.11];

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: _gradients,
        durations: _durations,
        heightPercentages: _heightPercentages,
      ),
      size: const Size(double.infinity, double.infinity),
      waveAmplitude: 0,
    );
  }
}
