import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointing_experiment/task_two_complete.dart';

import 'main.dart';

const int none = 0;
const int audio = 1;
const int tactile = 2;
const int audioTactile = 3;

int feedbackType = 0;
int taskTwoTrial = 0;
int errors = 0;
int startTime = 0;
int totalTime = 0;
bool started = false;

var participantData = {
  'FeedbackType 1': {
    'Trial 1': {},
    'Trial 2': {},
    'Trial 3': {},
  },
  'FeedbackType 2': {
    'Trial 1': {},
    'Trial 2': {},
    'Trial 3': {},
  },
  'FeedbackType 3': {
    'Trial 1': {},
    'Trial 2': {},
    'Trial 3': {},
  },
  'FeedbackType 4': {
    'Trial 1': {},
    'Trial 2': {},
    'Trial 3': {},
  },
};

void _updateParticipantData(
    int feedbackTypeIndex, int trialIndex, int position) {
  participantData['FeedbackType $feedbackTypeIndex']!['Trial $trialIndex'] = {
    'Errors': errors,
    'Time': totalTime,
    'Position': position
  };
}

void _updateTrial(BuildContext context, int position) {
  _updateParticipantData(
      (feedbackType + 1), ((taskTwoTrial % 3) + 1), position);
  taskTwoTrial = (taskTwoTrial + 1);
  errors = 0;
  if (taskTwoTrial % 3 == 0) {
    // changing to next feedback type
    feedbackType = (feedbackType + 1) % 4;
  }
  if (taskTwoTrial % 12 == 0) {
    _uploadData();
    participant = participant + 1;

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const TaskTwoComplete();
    }));
  }
}

Future<void> _incrementErrors(player) async {
  if (started) {
    errors++;
    if (feedbackType == audio) {
      await player.resume();
    } else if (feedbackType == tactile) {
      HapticFeedback.mediumImpact();
    } else if (feedbackType == audioTactile) {
      await player.resume();
      HapticFeedback.mediumImpact();
    }
  }
}

void _startTimer() {
  startTime = DateTime.now().millisecondsSinceEpoch;
}

void _endTimer() {
  int endTime = DateTime.now().millisecondsSinceEpoch;
  totalTime = endTime - startTime;
}

Future _uploadData() async {
  DateTime now = DateTime.now();
  String uniqueID =
      "${now.hour}:${now.minute}:${now.second} ${now.day}:${now.month}";
  final docUser = FirebaseFirestore.instance
      .collection("Experiment Data Young")
      .doc("Participant ${(participant + 1)}: Task 2 $uniqueID");
  await docUser.set(participantData);
}

class TaskTwo extends StatefulWidget {
  const TaskTwo({super.key});

  @override
  State<TaskTwo> createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {
  double spacing = 6;
  double buttonSize = 30;
  int selected = -1;
  double borderThickness = 2.0;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    setAduio();
  }

  void _onButtonPressed(int index) {
    if (selected == index) {
      _endTimer();
      _updateTrial(context, selected);
      started = false;
      setState(() {
        selected = -1;
      });
    } else {
      _incrementErrors(player);
    }
  }

  Widget _buildButton(int index) {
    return SizedBox(
      height: buttonSize,
      width: buttonSize,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: selected == index ? Colors.blue : Colors.white,
          side: BorderSide(width: borderThickness),
        ),
        child: const Text(""),
        onPressed: () => _onButtonPressed(index),
      ),
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      height: buttonSize,
      width: buttonSize,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: borderThickness),
          backgroundColor: Colors.green,
        ),
        child: const Text(
          "",
          style: TextStyle(
            fontSize: 6.0,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          if (!started) {
            setState(() {
              selected = Random().nextInt(8);
            });
            started = true;
            _startTimer();
          } else {
            _incrementErrors(player);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _incrementErrors(player);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("Trial: ${(taskTwoTrial % 3) + 1}"),
            // Text("Layout: ${feedbackType + 1}"),
            const Text(
              "Click the green button to begin trial!",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(0),
                  SizedBox(
                    width: spacing,
                  ),
                  _buildButton(1),
                  SizedBox(
                    width: spacing,
                  ),
                  _buildButton(2)
                ],
              ),
              SizedBox(
                height: spacing,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(3),
                  SizedBox(
                    width: spacing,
                  ),
                  _buildStartButton(),
                  SizedBox(
                    width: spacing,
                  ),
                  _buildButton(4)
                ],
              ),
              SizedBox(
                height: spacing,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(5),
                  SizedBox(
                    width: spacing,
                  ),
                  _buildButton(6),
                  SizedBox(
                    width: spacing,
                  ),
                  _buildButton(7)
                ],
              ),
            ]),
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
