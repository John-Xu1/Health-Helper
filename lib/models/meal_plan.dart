import 'meal.dart';
import 'package:health_helper/services/api_service.dart';

class MealPlan {
  final List<Meal> meals;
  final double calories, carbs, fat, protein;

  MealPlan({this.meals, this.calories, this.carbs, this.fat, this.protein});

  factory MealPlan.fromMap(Map<String, dynamic> map) {
    List<Meal> meals = [];
    map['meals'].forEach((mealMap) {
      Meal meal = Meal.fromMap(mealMap);
      ApiService.instance.getMealNutrients(meal);
      meals.add(meal);
    });
    return MealPlan(
      meals: meals,
      calories: map['nutrients']['calories'],
      carbs: map['nutrients']['carbohydrates'],
      fat: map['nutrients']['fat'],
      protein: map['nutrients']['protein'],
    );
  }
}
