import 'package:flutter/material.dart';
import 'package:bleproject/controllers/user_controller.dart';
import 'package:bleproject/bluetooth/bluetooth.dart'; 

class ProgressBar extends StatefulWidget {
  ProgressBar();

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  late int recommendedSteps = 19;
  late int stepsFromDatabase = 0;

  @override
  void initState() {
    super.initState();

    UserController().getRecommendedSteps().then((value) {
      setState(() {
        recommendedSteps = value ?? 15;
      });
    });
    
    UserController().getStepsToday().then((value) {
      setState(() {
        stepsFromDatabase = value ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: MyBluetoothManager().receivedValueStream,
      builder: (context, snapshot) {
        double progress = 0.0;
        int receivedValue = 0;
        if (snapshot.hasData) {
          receivedValue = int.tryParse(snapshot.data ?? "") ?? 0;
        }
       
        if (receivedValue > 0) {
          progress = receivedValue.toDouble() / recommendedSteps;
        } else {
          progress = stepsFromDatabase.toDouble() / recommendedSteps;
        }
        return Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Color.fromARGB(255, 187, 128, 110),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 246, 222, 186),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '${(progress * 100).toStringAsFixed(1)}% of $recommendedSteps steps',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 246, 222, 186),
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
