import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:bleproject/pages/menupage.dart';
import 'package:bleproject/controllers/user_controller.dart';
import 'package:bleproject/models/user_model.dart';

class FormsPage extends StatefulWidget {
  @override
  _FormsPageState createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final isNumeric = int.tryParse(value);
    if (isNumeric == null) {
      return 'Age must be a number';
    }
    return null; 
  }

  String? validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final isNumeric = int.tryParse(value);
    if (isNumeric == null) {
      return 'Age must be a number';
    }
    return null; 
  }

  String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final isNumeric = int.tryParse(value);
    if (isNumeric == null) {
      return 'Age must be a number';
    }
    return null; 
  }
  
  final UserController userController = UserController();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  late String name = '';
  Genders _selectedGender = Genders.male;
  ActivityLevel _selectedActivityLevel = ActivityLevel.low;

  bool showFirstForm = true;
  void toggleForms() {
    setState(() {
      showFirstForm = !showFirstForm;
    });
  }

 
     @override
  void initState() {
    super.initState();
    userController.getAge().then((value) => userController.ageController.text = value.toString());
    userController.getHeight().then((value) => userController.heightController.text = value.toString());
    userController.getWeight().then((value) => userController.weightController.text = value.toString());
    userController.getActivityLevelFromDatabase().then((value) => userController.activityLevel = value);
    userController.getGenderFromDatabase().then((value) => userController.genders = value);
    userController.getRecommendedSteps().then((value) {
      if (value != null) {
        setState(() {
          userController.stepGoalRecommended = value;
        });
      }
    });
    UserController().getName().then((value) {
      setState(() {
        name = value; 
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (showFirstForm)
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.045,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.79,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 170, 98, 76),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hello,$name',
                              style: TextStyle(
                                color: Color.fromARGB(255, 246, 222, 186),
                                fontSize: MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Complete this form to see how many steps do you need to do daily',
                              style: TextStyle(
                                color: Color.fromARGB(255, 246, 222, 186),
                                fontSize: MediaQuery.of(context).size.width * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            

Container(
  margin: EdgeInsets.symmetric(vertical: 8.0), 
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 197, 129, 108),
    borderRadius: BorderRadius.circular(10),
  ),
  height: MediaQuery.of(context).size.height * 0.08,
  width: MediaQuery.of(context).size.width * 0.7,
  child: TextFormField(
    controller: userController.ageController,
    style: TextStyle(
      color: Color.fromARGB(255, 246, 222, 186),
      fontSize: MediaQuery.of(context).size.height * 0.02, 
    ),
    decoration: InputDecoration(
      labelText: 'Age',
      labelStyle: TextStyle(
        color: Color.fromARGB(255, 246, 222, 186),
        fontSize: MediaQuery.of(context).size.height * 0.02, 
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), 
      border: InputBorder.none, 
    ),
    validator: validateAge,
  ),
),


Container(
  margin: EdgeInsets.symmetric(vertical: 8.0), 
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 197, 129, 108),
    borderRadius: BorderRadius.circular(10),
  ),
  height: MediaQuery.of(context).size.height * 0.08,
  width: MediaQuery.of(context).size.width * 0.7,
  child: TextFormField(
    controller: userController.heightController,
    style: TextStyle(
      color: Color.fromARGB(255, 246, 222, 186),
      fontSize: MediaQuery.of(context).size.height * 0.02, 
    ),
    decoration: InputDecoration(
      labelText: 'Height',
      labelStyle: TextStyle(
        color: Color.fromARGB(255, 246, 222, 186),
        fontSize: MediaQuery.of(context).size.height * 0.02,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), 
      border: InputBorder.none, 
    ),
    validator: validateHeight,
  ),
),


Container(
  margin: EdgeInsets.symmetric(vertical: 8.0), 
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 197, 129, 108),
    borderRadius: BorderRadius.circular(10),
  ),
  height: MediaQuery.of(context).size.height * 0.08,
  width: MediaQuery.of(context).size.width * 0.7,
  child: TextFormField(
    controller: userController.weightController,
    style: TextStyle(
      color: Color.fromARGB(255, 246, 222, 186),
      fontSize: MediaQuery.of(context).size.height * 0.02, 
    ),
    decoration: InputDecoration(
      labelText: 'Weight',
      labelStyle: TextStyle(
        color: Color.fromARGB(255, 246, 222, 186),
        fontSize: MediaQuery.of(context).size.height * 0.02,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      border: InputBorder.none, 
    ),
    validator: validateWeight,
  ),
),

Container(
  margin: EdgeInsets.symmetric(vertical: 8.0), 
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 197, 129, 108),
    borderRadius: BorderRadius.circular(10),
  ),
  height: MediaQuery.of(context).size.height * 0.085,
  width: MediaQuery.of(context).size.width * 0.7,
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    child: DropdownButtonFormField<Genders>(
      value: _selectedGender,
      style: TextStyle(
        color: Color.fromARGB(255, 246, 222, 186), 
        fontSize: MediaQuery.of(context).size.height * 0.02, 
      ),
      decoration: InputDecoration(
        labelText: 'Gender',
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 246, 222, 186),
          fontSize: MediaQuery.of(context).size.height * 0.02, 
        ),
        border: InputBorder.none, 
      ),
      onChanged: (Genders? value) {
        if (value != null) {
          setState(() {
            _selectedGender = value;
          });
        }
      },
      items: Genders.values.map((Genders gender) {
        return DropdownMenuItem<Genders>(
          value: gender,
          child: Text(
            gender.toString().split('.').last,
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.height * 0.02, 
            ),
          ),
        );
      }).toList(),
    ),
  ),
),


Container(
  margin: EdgeInsets.symmetric(vertical: 8.0), 
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 197, 129, 108),
    borderRadius: BorderRadius.circular(10),
  ),
  height: MediaQuery.of(context).size.height * 0.085,
  width: MediaQuery.of(context).size.width * 0.7,
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    child: DropdownButtonFormField<ActivityLevel>(
      value: _selectedActivityLevel,
      style: TextStyle(
        color: Colors.black, 
        fontSize: MediaQuery.of(context).size.height * 0.02, 
      ),
      decoration: InputDecoration(
        labelText: 'Activity level',
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 246, 222, 186),
          fontSize: MediaQuery.of(context).size.height * 0.02, 
        ),
        border: InputBorder.none, 
      ),
      onChanged: (ActivityLevel? value) {
        if (value != null) {
          setState(() {
            _selectedActivityLevel = value;
          });
        }
      },
      items: ActivityLevel.values.map((ActivityLevel level) {
        return DropdownMenuItem<ActivityLevel>(
          value: level,
          child: Text(
            level.toString().split('.').last,
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.height * 0.02, 
            ),
          ),
        );
      }).toList(),
    ),
  ),
),


                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 197, 129, 108),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  
                                  if (_formKey1.currentState!.validate()) {
                                    
                                    await userController.setHeight(int.parse(
                                        userController.heightController.text)); 
                                        await userController.setAge(int.parse(
                                        userController.ageController.text));
                                   
                                    await userController.setWeight(int.parse(
                                        userController.weightController.text));
                                    await userController.setActivityLevel(
                                        _selectedActivityLevel);
                                    await userController
                                        .setGender(_selectedGender);

                                    
                                    await userController
                                        .calculateAndSetStepGoalRecommended(
                                      UserModel(
                                        id: 1, 
                                        name:
                                            '', 
                                        age: int.parse(
                                            userController.ageController.text),
                                        height: int.parse(userController
                                            .heightController
                                            .text), 
                                        weight: int.parse(userController
                                            .weightController.text),
                                        activityLevel: _selectedActivityLevel,
                                        genders: _selectedGender,
                                        stepGoalRecommended:
                                            0, 
                                        stepGoalSet:
                                            0, 
                                      ),
                                      int.parse(
                                          userController.ageController.text),
                                      int.parse(
                                          userController.heightController.text),
                                      int.parse(
                                          userController.weightController.text),
                                      true
                                      
                                    );

                                    
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuPage()),
                                    );
                                  }
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 246, 222, 186),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (showFirstForm)
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.02,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 109, 48, 63).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'OR',
                            style: TextStyle(
                              color: Color.fromARGB(255, 246, 204, 186),
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Text(
                            'Set your OWN GOAL to achieve',
                            style: TextStyle(
                              color: Color.fromARGB(255, 223, 184, 194),
                              fontSize: MediaQuery.of(context).size.width * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 143, 74, 91),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                              onPressed: toggleForms,
                              child: Text(
                                'Set a goal',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 223, 184, 194),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (!showFirstForm)
  Positioned(
    top: MediaQuery.of(context).size.height * 0.05,
    child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 109, 48, 63),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello, $name',
                  style: TextStyle(
                    color: Color.fromARGB(255, 223, 184, 194),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Set your goal to achieve daily',
                  style: TextStyle(
                    color: Color.fromARGB(255, 223, 184, 194),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 143, 74, 91),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: userController.stepGoalSetController, 
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Color.fromARGB(255, 223, 184, 194),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Step Goal',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 223, 184, 194),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Step Goal is required';
                        }
                        final isNumeric = int.tryParse(value);
                        if (isNumeric == null) {
                          return 'Step Goal must be a number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 197, 129, 108),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: MaterialButton(
                   onPressed: () async {
  if (_formKey2.currentState!.validate()) {
    int stepGoal = int.parse(userController.stepGoalSetController.text);

    
    bool isFirstForm = false;

   
    await userController.setStepGoalSet(stepGoal);

    
    await userController.calculateAndSetStepGoalRecommended(
      UserModel(
        id: 1,
        name: '',
        age: int.parse(userController.ageController.text),
        height: int.parse(userController.heightController.text),
        weight: int.parse(userController.weightController.text),
        activityLevel: _selectedActivityLevel,
        genders: _selectedGender,
        stepGoalRecommended: 0,
        stepGoalSet: 0,
      ),
      int.parse(userController.ageController.text),
      int.parse(userController.heightController.text),
      int.parse(userController.weightController.text),
      isFirstForm,
    );

    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuPage()),
    );
  }
},


                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Color.fromARGB(255, 246, 222, 186),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ),
              if (!showFirstForm)
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.02,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 170, 98, 76).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'OR',
                            style: TextStyle(
                              color: Color.fromARGB(255, 246, 204, 186),
                              fontSize: MediaQuery.of(context).size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Text(
                            'Complete the form',
                            style: TextStyle(
                              color: Color.fromARGB(255, 246, 222, 186),
                              fontSize: MediaQuery.of(context).size.height * 0.01,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 197, 129, 108),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                              onPressed: toggleForms,
                              child: Text(
                                'Form',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 246, 222, 186),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
