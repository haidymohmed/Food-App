import '../Data/Models/bmr_model.dart';

class CalcBMR{
  calcForMan(BMR bmr){
    return (88.362 + (13.397 * bmr.weight) + (4.799 * bmr.height) - (5.677 * bmr.age));
  }
  calcForWoman(BMR bmr){
    return (447.593 + (9.247 * bmr.weight) + (3.098 * bmr.height) - (4.330 * bmr.age));
  }
}