import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:volume_control/volume_control.dart';

void main() {
  runApp(MaterialApp(
    home: MyScreen(),
  ));
}

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  var audioPlayer = AudioPlayer();
  var audioPath = "audio/audioFile.mp3";

  Duration _duration = Duration();
  Duration _position = Duration();

  String operation = "Play";
  double currentVolume = 0.1;
  @override
  Widget build(BuildContext context) {
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        _position = event;
      });
    });

    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        _duration = event;
      });
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("ListView"),
        ),
        body: Column(
          children: [
            Center(child: Image.asset("assets/images/image.jpg")),
            Row(
              children: [
                SizedBox(
                  width: 100.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (operation == "Play") {
                        await audioPlayer.play(AssetSource(audioPath));
                        setState(() {
                          operation = "Pause";
                        });
                      } else if (operation == "Pause") {
                        await audioPlayer.pause();
                        setState(() {
                          operation = "Resume";
                        });
                      } else if (operation == "Resume") {
                        await audioPlayer.resume();
                        setState(() {
                          operation = "Pause";
                        });
                      }
                    },
                    child: Text(operation)),
                ElevatedButton(
                    onPressed: () async {
                      await audioPlayer.stop();
                      setState(() {
                        operation = "Play";
                      });
                    },
                    child: Text("Stop"))
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Text("Volume"),
                Expanded(
                  child: Slider(
                      value: currentVolume,
                      max: 1.0,
                      divisions: 10,
                      onChanged: (value) {
                        VolumeControl.setVolume(value);
                        setState(() {
                          currentVolume = value;
                        });
                      }),
                ),
              ],
            ),
            Slider.adaptive(
              onChanged: (double value) {
                setState(() {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                });
              },
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds.toDouble(),
            ),
          ],
        ));
  }
}
