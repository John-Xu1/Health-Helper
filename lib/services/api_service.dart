import 'dart:convert';
import 'dart:io';
import 'package:health_helper/models/meal.dart';
import 'package:health_helper/models/meal_plan.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._instantiate();

  static final ApiService instance = ApiService._instantiate();

  static final url = 'api.spoonacular.com';
  static const String API_KEY = '8bcdd3d5d349452f89250c7c54757f12';

  Future<MealPlan> generateMealPlan({int targetCalories, String diet}) async {
    if (diet == 'None') {
      diet = '';
    }
    Map<String, String> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      url,
      '/recipes/mealplans/generate',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      MealPlan mealPlan = MealPlan.fromMap(data);
      return mealPlan;
    } catch (e) {
      print('error with api: $e');
    }
  }

  void getMealNutrients(Meal meal) async {
    print('ran getmealnutrients method');
    Map<String, String> parameters = {
      'apiKey': API_KEY,
    };
    Uri uri =
        Uri.https(url, '/recipes/${meal.id}/nutritionWidget.json', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      meal.setNutrients(data);
    } catch (e) {
      print(e);
    }
  }
}
