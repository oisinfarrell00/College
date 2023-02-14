import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:pointing_experiment/task_two.dart';

class FeedbackTypes extends StatefulWidget {
  const FeedbackTypes({super.key});

  @override
  State<FeedbackTypes> createState() => _FeedbackTypesState();
}

class _FeedbackTypesState extends State<FeedbackTypes> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    setAduio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text("No feedback")),
            ElevatedButton(
                onPressed: () async {
                  await player.resume();
                },
                child: const Text("Audio Feedback")),
            ElevatedButton(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                },
                child: const Text("Vibration")),
            ElevatedButton(
                onPressed: () async {
                  await player.resume();
                  HapticFeedback.mediumImpact();
                },
                child: const Text("Audio and Vibration")),
            ElevatedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  side: const BorderSide(width: 2.0),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const TaskTwo();
                  }));
                },
                child: const Text("Begin Task 2")),
          ],
        ),
      ),
    );
  }

  Future setAduio() async {
    final audioCache = AudioCache(prefix: 'assets/');
    final url = await audioCache.load('button-30.mp3');
    player.setUrl(url.path);
  }
}
