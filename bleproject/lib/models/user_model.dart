
class UserModel {
  final int id;
  final String name;
  final int age;
  final int height;
  final int weight;
  final ActivityLevel activityLevel;
  final Genders genders;
  final int stepGoalRecommended; 
  final int stepGoalSet;
   bool isUsingFirstForm;
  int stepsToday;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.genders,
    required this.stepGoalRecommended,
    required this.stepGoalSet,
    this.stepsToday = 0,
    this.isUsingFirstForm = true,
  });
  
  
}

enum ActivityLevel { low, light, medium, active, intense }
enum Genders{male, female}