import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'formspage.dart';
import '../widgets/progressbar.dart';
import 'historypage.dart';
import 'steppage.dart';
import 'package:bleproject/controllers/user_controller.dart';
class MenuPage extends StatefulWidget {
  MenuPage({Key? key}) : super(key: key);
  

 

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

late int totalSteps;
  late int currentSteps;
   late int recommendedSteps = 19;
  late UserController userController; 

_MenuPageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height * 0.1,
              child: Container(
                width: MediaQuery.of(context).size.height * 0.25,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 170, 98, 76),
                  borderRadius: BorderRadius.circular(
                      40), 
                ),
                child: MaterialButton(
                  onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StepPage()),
                                  );
                                },
                child: Padding(
                  
                  padding:EdgeInsets.all(20.0) ,
                   child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
            'Steps',
            textAlign: TextAlign.center,
            style: TextStyle(
                        color: Color.fromARGB(255, 246, 222, 186),
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
          ),
                    ProgressBar(
  
                  )

                          ],
                 
                
          ),
          ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: MediaQuery.of(context).size.height * 0.35,
              child: Container(
                width: MediaQuery.of(context).size.height * 0.25,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 109, 48, 63),
                  borderRadius: BorderRadius.circular(
                      40), 
                ),
                child: MaterialButton(
                   onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FormsPage()),
                                  );
                                },
                                child: Text(
            'Forms',
            textAlign: TextAlign.center,
            style: TextStyle(
                        color: Color.fromARGB(255, 246, 222, 186),
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
          ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: MediaQuery.of(context).size.height * 0.05,
              child: Container(
                width: MediaQuery.of(context).size.height * 0.25,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 156, 134),
                  borderRadius: BorderRadius.circular(
                      40), 
                ),
                 child: MaterialButton(
                   onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HistoryPage()),
                                  );
                                },
                    child: Text(
            'History',
            textAlign: TextAlign.center,
            style: TextStyle(
                        color: Color.fromARGB(255, 246, 222, 186),
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
          ),
                ),
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}