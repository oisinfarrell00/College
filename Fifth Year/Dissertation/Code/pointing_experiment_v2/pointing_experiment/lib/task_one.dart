import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointing_experiment/feedback_types.dart';

import 'main.dart';

int layout = 0;
int errors = 0;
int startTime = 0;
int totalTime = 0;
int taskOneTrial = 0;
bool started = false;

var participantData = {
  'Layout 1': {
    'Trial 1': {},
    'Trial 2': {},
    'Trial 3': {},
  },
  'Layout 2': {
    'Trial 1': {},
    'Trial 2': {},
    'Trial 3': {},
  },
  'Layout 3': {
    'Trial 1': {},
    'Trial 2': {},
    'Trial 3': {},
  },
  'Layout 4': {
    'Trial 1': {},
    'Trial 2': {},
    'Trial 3': {},
  },
  'Layout 5': {
    'Trial 1': {},
    'Trial 2': {},
    'Trial 3': {},
  },
  'Layout 6': {
    'Trial 1': {},
    'Trial 2': {},
    'Trial 3': {},
  },
};

void _updateParticipantData(int layoutIndex, int trialIndex, int selected) {
  debugPrint("$errors|$totalTime|$selected");
  participantData['Layout $layoutIndex']!['Trial $trialIndex'] = {
    'Errors': errors,
    'Time': totalTime,
    'Position': selected,
  };
}

void _updateTrial(BuildContext context, int selected) {
  _updateParticipantData((layout + 1), ((taskOneTrial % 3) + 1), selected);
  taskOneTrial = (taskOneTrial + 1);
  errors = 0;
  if (taskOneTrial % 3 == 0) {
    // changing to next layout
    layout = (layout + 1) % 6;
  }
  if (taskOneTrial % 18 == 0) {
    _uploadData();

    // move onto task two
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const FeedbackTypes();
    }));
  }
}

void _incrementErrors() {
  if (started) {
    errors++;
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
      .doc("Participant ${(participant + 1)}: Task 1 $uniqueID");
  await docUser.set(participantData);
}

class TaskOne extends StatefulWidget {
  const TaskOne({super.key});

  @override
  State<TaskOne> createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  List<double> spacings = [6, 6, 6, 18, 18, 18];
  List<double> buttonSizes = [30, 46, 70, 30, 46, 70];
  int selected = -1;
  double borderThickness = 2.0;

  void _onButtonPressed(int index) {
    if (selected == index) {
      _endTimer();
      _updateTrial(context, selected);
      started = false;
      setState(() {
        selected = -1;
      });
    } else {
      _incrementErrors();
    }
  }

  Widget _buildButton(int index) {
    return SizedBox(
      height: buttonSizes[layout],
      width: buttonSizes[layout],
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
      height: buttonSizes[layout],
      width: buttonSizes[layout],
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: borderThickness),
          backgroundColor: Colors.green,
        ),
        child: const Text(
          "",
          style: TextStyle(
            fontSize: 4.0,
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
            _incrementErrors();
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
          _incrementErrors();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("Trial: ${(taskOneTrial % 3) + 1}"),
            // Text("Layout: ${layout + 1}"),
            const Text("Click the green button to begin trial!",
                style: TextStyle(fontSize: 20)),
            const SizedBox(
              height: 15,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(0),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  _buildButton(1),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  _buildButton(2)
                ],
              ),
              SizedBox(
                height: spacings[layout],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(3),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  _buildStartButton(),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  _buildButton(4)
                ],
              ),
              SizedBox(
                height: spacings[layout],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(5),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  _buildButton(6),
                  SizedBox(
                    width: spacings[layout],
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
}
