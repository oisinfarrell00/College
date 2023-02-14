import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointing_experiment/task_one_complete.dart';

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
      return const TaskOneComplete();
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
      .collection("Experiment Data")
      .doc("Participant ${(participant + 1)}: Task 1 $uniqueID");
  await docUser.set(participantData);
}

class TaskOne extends StatefulWidget {
  const TaskOne({super.key});

  @override
  State<TaskOne> createState() => _TaskOneState();
}

double convertMMToPixel(double mm) {
  return mm * 1;
}

class _TaskOneState extends State<TaskOne> {
  List<double> spacings = [
    convertMMToPixel(6),
    convertMMToPixel(6),
    convertMMToPixel(6),
    convertMMToPixel(18),
    convertMMToPixel(18),
    convertMMToPixel(18)
  ];
  List<double> buttonSizes = [
    convertMMToPixel(30),
    convertMMToPixel(46),
    convertMMToPixel(70),
    convertMMToPixel(30),
    convertMMToPixel(46),
    convertMMToPixel(70)
  ];
  int selected = -1;
  double borderThickness = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _incrementErrors();
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Participant: ${(participant + 1)}"),
            Text("Trial: ${(taskOneTrial % 3) + 1}"),
            Text("Layout: ${layout + 1}"),
            Text("Errors: $errors"),
            const Text("Click the green button to begin trial!"),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: buttonSizes[layout],
                    width: buttonSizes[layout],
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            selected == 0 ? Colors.blue : Colors.white,
                        side: BorderSide(width: borderThickness),
                      ),
                      child: const Text(""),
                      onPressed: () {
                        setState(() {
                          if (selected == 0) {
                            _endTimer();
                            _updateTrial(context, selected);
                            started = false;
                            selected = -1;
                          } else {
                            _incrementErrors();
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  SizedBox(
                    height: buttonSizes[layout],
                    width: buttonSizes[layout],
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            selected == 1 ? Colors.blue : Colors.white,
                        side: BorderSide(width: borderThickness),
                      ),
                      child: const Text(""),
                      onPressed: () {
                        setState(() {
                          if (selected == 1) {
                            _endTimer();
                            _updateTrial(context, selected);
                            started = false;
                            selected = -1;
                          } else {
                            _incrementErrors();
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  SizedBox(
                    height: buttonSizes[layout],
                    width: buttonSizes[layout],
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            selected == 2 ? Colors.blue : Colors.white,
                        side: BorderSide(width: borderThickness),
                      ),
                      child: const Text(""),
                      onPressed: () {
                        setState(() {
                          if (selected == 2) {
                            _endTimer();
                            _updateTrial(context, selected);
                            started = false;
                            selected = -1;
                          } else {
                            _incrementErrors();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: spacings[layout],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: buttonSizes[layout],
                    width: buttonSizes[layout],
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            selected == 3 ? Colors.blue : Colors.white,
                        side: BorderSide(width: borderThickness),
                      ),
                      child: const Text(""),
                      onPressed: () {
                        setState(() {
                          if (selected == 3) {
                            _endTimer();
                            _updateTrial(context, selected);
                            started = false;
                            selected = -1;
                          } else {
                            _incrementErrors();
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  SizedBox(
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
                        setState(() {
                          if (!started) {
                            selected = Random().nextInt(8);
                            started = true;
                            _startTimer();
                          } else {
                            _incrementErrors();
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  SizedBox(
                    height: buttonSizes[layout],
                    width: buttonSizes[layout],
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            selected == 4 ? Colors.blue : Colors.white,
                        side: BorderSide(width: borderThickness),
                      ),
                      child: const Text(""),
                      onPressed: () {
                        setState(() {
                          if (selected == 4) {
                            _endTimer();
                            _updateTrial(context, selected);
                            started = false;
                            selected = -1;
                          } else {
                            _incrementErrors();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: spacings[layout],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: buttonSizes[layout],
                    width: buttonSizes[layout],
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            selected == 5 ? Colors.blue : Colors.white,
                        side: BorderSide(width: borderThickness),
                      ),
                      child: const Text(""),
                      onPressed: () {
                        setState(() {
                          if (selected == 5) {
                            _endTimer();
                            _updateTrial(context, selected);
                            started = false;
                            selected = -1;
                          } else {
                            _incrementErrors();
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  SizedBox(
                    height: buttonSizes[layout],
                    width: buttonSizes[layout],
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            selected == 6 ? Colors.blue : Colors.white,
                        side: BorderSide(width: borderThickness),
                      ),
                      child: const Text(""),
                      onPressed: () {
                        setState(() {
                          if (selected == 6) {
                            _endTimer();
                            _updateTrial(context, selected);
                            started = false;
                            selected = -1;
                          } else {
                            _incrementErrors();
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacings[layout],
                  ),
                  SizedBox(
                    height: buttonSizes[layout],
                    width: buttonSizes[layout],
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            selected == 7 ? Colors.blue : Colors.white,
                        side: BorderSide(width: borderThickness),
                      ),
                      child: const Text(""),
                      onPressed: () {
                        setState(() {
                          if (selected == 7) {
                            _endTimer();
                            _updateTrial(context, selected);
                            started = false;
                            selected = -1;
                          } else {
                            _incrementErrors();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ]),
            if (!started) Text("$totalTime"),
          ],
        ),
      ),
    );
  }
}
