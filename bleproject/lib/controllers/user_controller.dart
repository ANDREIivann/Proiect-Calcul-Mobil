import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bleproject/models/user_model.dart';
import 'package:bleproject/controllers/stepgoal_recommended_controller.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class UserController {
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController ageController = TextEditingController();
  late final TextEditingController weightController = TextEditingController();
  late final TextEditingController heightController = TextEditingController();
  late final TextEditingController stepGoalSetController = TextEditingController();
  late ActivityLevel activityLevel = ActivityLevel.low;
  late Genders genders = Genders.male;
  late int stepGoalRecommended = 0;

Future<void> setStepsToday(int steps) async {
  try {
    await saveToDatabase({'steps_today': steps});
    await saveDailyStepToWeeklyHistory(steps);
  } catch (e) {
    print('Error setting steps today: $e');
  }
}

Future<void> saveDailyStepToWeeklyHistory(int steps) async {
  final Database db = await getDatabase();
  final currentDayOfWeek = DateTime.now().weekday; 
  final dayOfWeekColumns = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];
  final currentDayIndex = currentDayOfWeek - 1;

  try {
    
    final List<Map<String, dynamic>> existingData = await db.query(
      'weekly_step_history',
      where: 'id = ?',
      whereArgs: [1], 
    );

    if (existingData.isNotEmpty) {
      
      await db.update(
        'weekly_step_history',
        {dayOfWeekColumns[currentDayIndex]: steps},
        where: 'id = ?',
        whereArgs: [1], 
      );
      print('Daily step count updated for ${dayOfWeekColumns[currentDayIndex]}');
    } else {
      
      final Map<String, dynamic> newData = {
        'id': 1, 
        for (var column in dayOfWeekColumns) column: 0, 
      };
      newData[dayOfWeekColumns[currentDayIndex]] = steps; 
      await db.insert(
        'weekly_step_history',
        newData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Daily step count saved to weekly history for ${dayOfWeekColumns[currentDayIndex]}');
    }
    printWeeklyStepHistory();
  } catch (e) {
    print('Error saving daily step count to weekly history: $e');
  }
}


Future<void> printWeeklyStepHistory() async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> history = await db.query('weekly_step_history');
    print('Weekly Step History:');
    for (var entry in history) {
      print(entry);
    }
  } catch (e) {
    print('Error printing weekly step history: $e');
  }
}


Future<void> setStepGoalSet(int stepGoal) async {
  try {
    await saveToDatabase({'step_goal_set': stepGoal});
  } catch (e) {
    print('Error setting step goal: $e');
  }
}
  Future<void> setName(String name) async {
    nameController.text = name;
    await saveNameToDatabase(name);
  }

  Future<void> saveNameToDatabase(String name) async {
    final Database db = await getDatabase();
    try {
      await db.insert(
        'users',
        {'name': name},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('User name saved to database');
    } catch (e) {
      print('Error saving user name to database: $e');
    }
  }

  Future<void> setAge(int age) async {
    ageController.text = age.toString();
    await saveToDatabase({'age': age});
  }

  Future<void> setHeight(int height) async {
    heightController.text = height.toString();
    await saveToDatabase({'height': height});
  }

  Future<void> setWeight(int weight) async {
    weightController.text = weight.toString();
    await saveToDatabase({'weight': weight});
  }

  Future<void> setActivityLevel(ActivityLevel level) async {
    activityLevel = level;
    await saveToDatabase({'activity_level': level.toString().split('.').last});
  }

  Future<void> setGender(Genders gender) async {
    genders = gender;
    await saveToDatabase({'gender': gender.toString().split('.').last});
  }

  ActivityLevel getActivityLevel() {
    return activityLevel;
  }

  Genders getGender() {
    return genders;
  }

 Future<void> calculateAndSetStepGoalRecommended(
    UserModel user, int age, int height, int weight, bool isFirstForm) async {
  if (isFirstForm) {
   
    stepGoalRecommended = StepGoalRecommendedController.calculateStepGoal(
      user,
      genders,
      activityLevel,
      age,
      height,
      weight,
    );
  } else {
   
    int? stepGoalSet = await getStepGoalSetFromDatabase();
    stepGoalRecommended = stepGoalSet ?? 11;
  }

  print('Step Goal Recommended: $stepGoalRecommended');

 
  await saveToDatabase({'step_goal_recommended': stepGoalRecommended});
}

Future<void> saveToDatabase(Map<String, dynamic> userData) async {
  final Database db = await getDatabase();
  try {
    final List<Map<String, dynamic>> existingRows = await db.query(
      'users',
      where: 'id = ?', 
      whereArgs: [1], 
    );

    if (existingRows.isNotEmpty) {
      await db.update(
        'users',
        userData,
        where: 'id = ?', 
        whereArgs: [1],
      );
      print('User data updated in the database');
    } else {
      await db.insert(
        'users',
        userData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('New user data inserted into the database');
    }
  } catch (e) {
    print('Error saving user data to database: $e');
  }
}


Future<int?> getStepGoalSetFromDatabase() async {
  final Database db = await getDatabase();
  try {
    final List<Map<String, dynamic>> maps = await db.query('users');
    if (maps.isNotEmpty) {
      return maps.first['step_goal_set'];
    } else {
      return null;
    }
  } catch (e) {
    print('Error retrieving step goal set from database: $e');
    return null;
  }
}


  Future<String> getName() async {
    final Database db = await getDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query('users');
      if (maps.isNotEmpty) {
        return maps.first['name'];
      } else {
        return '';
      }
    } catch (e) {
      print('Error retrieving user name from database: $e');
      return '';
    }
  }

  Future<int?> getAge() async {
    final Database db = await getDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query('users');
      if (maps.isNotEmpty) {
        return maps.first['age'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving user age from database: $e');
      return null;
    }
  }

  Future<ActivityLevel> getActivityLevelFromDatabase() async {
    final Database db = await getDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query('users');
      if (maps.isNotEmpty) {
        return ActivityLevel.values.firstWhere((level) =>
            level.toString().split('.').last == maps.first['activity_level']);
      } else {
        return ActivityLevel.low;
      }
    } catch (e) {
      print('Error retrieving user activity level from database: $e');
      return ActivityLevel.low;
    }
  }

  Future<Genders> getGenderFromDatabase() async {
    final Database db = await getDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query('users');
      if (maps.isNotEmpty) {
        return Genders.values.firstWhere((gender) =>
            gender.toString().split('.').last == maps.first['gender']);
      } else {
        return Genders.male;
      }
    } catch (e) {
      print('Error retrieving user gender from database: $e');
      return Genders.male;
    }
  }

Future<int?> getRecommendedSteps() async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [1],
    );
    
    print('Number of rows returned: ${maps.length}');
    print('Data: $maps');

    if (maps.isNotEmpty) {
      final int? recommendedSteps = maps.first['step_goal_recommended'];
      print('Recommended Steps: $recommendedSteps');
      return recommendedSteps;
    } else {
      print('No data found for the current user');
      return null;
    }
  } catch (e) {
    print('Error retrieving recommended steps from database: $e');
    return null;
  }
}

Future<int?> getStepsToday() async {
  try {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('users');
    if (maps.isNotEmpty) {
      return maps.first['steps_today'];
    } else {
      return null;
    }
  } catch (e) {
    print('Error retrieving steps today: $e');
    return null;
  }
}

Future<List<int>> getWeeklySteps() async {
    final Database db = await getDatabase();
    final List<int> weeklySteps = List.filled(7, 0);
    final List<String> dayOfWeekColumns = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];

    try {
      final List<Map<String, dynamic>> result = await db.query('weekly_step_history');

      if (result.isNotEmpty) {
        for (int i = 0; i < dayOfWeekColumns.length; i++) {
          weeklySteps[i] = result[0][dayOfWeekColumns[i]];
        }
      }
    } catch (e) {
      print('Error retrieving weekly steps: $e');
    }

    return weeklySteps;
  }

Future<int?> getHeight() async {
    final Database db = await getDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query('users');
      if (maps.isNotEmpty) {
        return maps.first['height'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving user height from database: $e');
      return null;
    }
  }



  Future<int?> getWeight() async {
    final Database db = await getDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db.query('users');
      if (maps.isNotEmpty) {
        return maps.first['weight'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving user weight from database: $e');
      return null;
    }
  }
  
  Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'your_database.db'),
    onCreate: (db, version) {
  
db.execute(
  'CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, height INTEGER, weight INTEGER, activity_level TEXT, gender TEXT, step_goal_recommended INTEGER, step_goal_set INTEGER, steps_today INTEGER)',
);


      
      db.execute(
        'CREATE TABLE IF NOT EXISTS weekly_step_history (id INTEGER PRIMARY KEY AUTOINCREMENT, monday INTEGER, tuesday INTEGER, wednesday INTEGER, thursday INTEGER, friday INTEGER, saturday INTEGER, sunday INTEGER)',
      );
    },
    version: 1,
  );
}

}
