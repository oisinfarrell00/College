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
            const Text("Feedback types you will encounter in task 2",
                style: TextStyle(fontSize: 20)),
            const Text("Please familiarise yourself with them!",
                style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text("No feedback")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    onPressed: () async {
                      await player.resume();
                    },
                    child: const Text("Audio Feedback")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                    },
                    child: const Text("Vibration")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    onPressed: () async {
                      await player.resume();
                      HapticFeedback.mediumImpact();
                    },
                    child: const Text("Audio and Vibration")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      side: const BorderSide(width: 2.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const TaskTwo();
                      }));
                    },
                    child: const Text("Begin Task 2")),
              ),
            ),
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
