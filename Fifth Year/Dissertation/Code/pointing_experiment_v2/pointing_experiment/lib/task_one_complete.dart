import 'package:flutter/material.dart';
import 'package:pointing_experiment/feedback_types.dart';

class TaskOneComplete extends StatefulWidget {
  const TaskOneComplete({super.key});

  @override
  State<TaskOneComplete> createState() => _TaskOneCompleteState();
}

class _TaskOneCompleteState extends State<TaskOneComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                  "Thank you for completing the first task. In your own time you may continue to the next task by clikcing the button below"),
              Text(
                  "In task two you may experience feedback such as a click or a vibration to let you know that you have not clicked the button."),
              Text(
                  " Please click below to familiarise yourself with the feedback types."),
            ],
          ),
          Center(
            child: ElevatedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  side: const BorderSide(width: 2.0),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const FeedbackTypes();
                  }));
                },
                child: const Text("Test Feedback Types")),
          ),
        ],
      ),
    );
  }
}
