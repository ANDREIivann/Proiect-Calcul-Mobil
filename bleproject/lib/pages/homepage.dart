import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bleproject/controllers/user_controller.dart';
import 'formspage.dart';
import '../bluetooth/bluetooth.dart';


class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final UserController userController = UserController();
  final MyBluetoothManager bluetoothManager = MyBluetoothManager(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 170, 98, 76),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 109, 48, 63),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text(
                      'Hello,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextField(
                        controller: userController.nameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'your name',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        bluetoothManager.startScanning(); 
                        await userController.setName(userController.nameController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormsPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
