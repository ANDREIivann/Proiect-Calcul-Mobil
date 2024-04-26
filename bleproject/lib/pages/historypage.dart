import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/menubar.dart';
import '../controllers/user_controller.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int historystate = 0;
  late List<int> weeklySteps;

  @override
  void initState() {
    super.initState();
    fetchWeeklySteps();
  }

  Future<void> fetchWeeklySteps() async {
    List<int> steps = await UserController().getWeeklySteps();
    setState(() {
      weeklySteps = steps;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: screenHeight * 0.1,
              top: screenHeight * 0.017,
              child: Text(
                'History',
                style: TextStyle(
                  color: Color.fromARGB(255, 188, 175, 157),
                  fontSize: screenWidth * 0.2,
                ),
              ),
            ),
            Positioned(
              left: screenHeight * 0.03,
              bottom: 0,
              child: Container(
                width: screenHeight * 0.5,
                height: screenHeight * 0.87,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 246, 222, 186),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton(context, 'Today', Color.fromARGB(255, 246, 222, 186), Colors.black, 1),
                        SizedBox(width: screenHeight * 0.03),
                        _buildButton(context, 'Week', Color.fromARGB(255, 246, 222, 186), Colors.black, 2),
                        SizedBox(width: screenHeight * 0.03),
                        _buildButton(context, 'Month', Color.fromARGB(255, 246, 222, 186), Colors.black, 3),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      width: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (historystate == 2)
                            _buildWeeklyHistory(),
                         
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomMenuBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color colora, Color textColor, int val) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.05,
      width: screenHeight * 0.1,
      decoration: BoxDecoration(
        color: colora,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            historystate = val;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: screenHeight * 0.014,
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyHistory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Weekly History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
          for (int i = 0; i < weeklySteps.length; i++)
            _buildWeeklyHistoryItem(weekdayToString(i + 1), weeklySteps[i]),
      ],
    );
  }

  Widget _buildWeeklyHistoryItem(String day, int steps) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(width: 20),
          Text(
            '$steps steps',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  String weekdayToString(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
