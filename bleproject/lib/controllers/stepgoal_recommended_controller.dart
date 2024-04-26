import 'package:bleproject/models/user_model.dart';

class StepGoalRecommendedController{
  static int calculateStepGoal(UserModel user,Genders genders, activityLevel,int age,int height,int weight){
  int bmr = 0;
  double tdee=0;
  int stepGoalRecommended;
    if(genders == Genders.male){
      bmr = ((10 * weight) + (6.25 * height) - (5 * age) + 5).toInt();

    }
    else if(genders == Genders.female ){
      bmr = ((10 * weight)+(6.25 * height) - (5*age )-161).toInt();
    
    }

   switch (activityLevel) {
      case ActivityLevel.low:
        tdee = bmr * 1.2;
        break;
      case ActivityLevel.light:
        tdee = bmr * 1.375;
        break;
      case ActivityLevel.medium:
        tdee = bmr * 1.55;
        break;
      case ActivityLevel.active:
       tdee = bmr * 1.725;
        break;
      case ActivityLevel.intense:
        tdee = bmr * 1.9;
        break;
    }
    stepGoalRecommended = ((0.2 * tdee) / 0.05).round();

    return stepGoalRecommended.toInt();
  }
 
}