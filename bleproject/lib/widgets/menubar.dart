import 'package:flutter/material.dart';
import '../pages/formspage.dart';
import '../pages/historypage.dart';
import '../pages/menupage.dart';
import '../pages/steppage.dart';
class CustomMenuBar extends StatelessWidget{
   CustomMenuBar();
  @override
  Widget build(BuildContext context){
    return  Positioned(
              bottom: MediaQuery.of(context).size.height * 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.height * 0.09,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 170, 98, 76),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                         
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StepPage()),
                          );
                        },
                        child: Text(
                          'Steps',
                          style: TextStyle(
                            color: Color.fromARGB(255, 201, 201, 201),
                            fontSize: MediaQuery.of(context).size.height * 0.01,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.height * 0.09,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 156, 134),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HistoryPage()),
                          );
                        },
                        child: Text(
                          'History',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: MediaQuery.of(context).size.height * 0.01,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.height * 0.09,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 109, 48, 63),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                         
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FormsPage()),
                          );
                        },
                        child: Text(
                          'Forms',
                          style: TextStyle(
                            color: Color.fromARGB(255, 201, 201, 201),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.011,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.height * 0.09,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 246, 222, 186),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MenuPage()),
                          );
                        },
                        child: Text(
                          'Menu',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.012,
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