import 'package:flutter/material.dart';
import 'package:pointing_experiment/task_two.dart';

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
          const Text(
              "Thank you for completing the first task. In your own time you may continue to the next task by clikcing the button below"),
          Center(
            child: ElevatedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  side: const BorderSide(width: 2.0),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const TaskTwo();
                  }));
                },
                child: const Text("Start Task 2")),
          ),
        ],
      ),
    );
  }
}
