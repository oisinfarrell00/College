import 'package:flutter/material.dart';
import 'package:pointing_experiment/main.dart';

class TaskTwoComplete extends StatefulWidget {
  const TaskTwoComplete({super.key});

  @override
  State<TaskTwoComplete> createState() => _TaskTwoCompleteState();
}

class _TaskTwoCompleteState extends State<TaskTwoComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
              "Thank you for completing both tasks. Your participation is greatly appreciated",
              style: TextStyle(fontSize: 20)),
          Center(
            child: ElevatedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  side: const BorderSide(width: 2.0),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const RootPage();
                  }));
                },
                child: const Text("Click to complete experiment")),
          ),
        ],
      ),
    );
  }
}
