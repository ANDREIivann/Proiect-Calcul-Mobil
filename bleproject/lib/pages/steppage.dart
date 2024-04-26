import 'package:bleproject/widgets/progressbar.dart';
import 'package:flutter/material.dart';
import '../widgets/menubar.dart';
import 'package:bleproject/controllers/user_controller.dart';


class StepPage extends StatefulWidget {
  const StepPage({Key? key}) : super(key: key);

  @override
  _StepPageState createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {
  bool newSession = false;
  void toggleSession() {
    setState(() {
      newSession = !newSession;
    });
  }

  int stepsFromDatabase = 0;

  @override
  void initState() {
    super.initState();
    
    UserController().getStepsToday().then((value) {
      setState(() {
        stepsFromDatabase = value ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.02,
              child: Container(
                width: MediaQuery.of(context).size.height * 0.50,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 170, 98, 76),
                  borderRadius: BorderRadius.circular(
                    40,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Progress', 
                        style: TextStyle(
                          color: Color.fromARGB(255, 246, 222, 186),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ProgressBar(), 
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.height * 0.035,
              bottom: MediaQuery.of(context).size.height * 0.01,
              child: Container(
                width: MediaQuery.of(context).size.height * 0.50,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 109, 48, 63),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Steps Made: $stepsFromDatabase', 
                      style: TextStyle(
                        color: Color.fromARGB(255, 246, 222, 186),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
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
}
