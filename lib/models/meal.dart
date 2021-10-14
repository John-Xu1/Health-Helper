class Meal {
  final String name, imagePath, kiloCaloriesBurnt, timeTaken;
  final String preparation;
  final List<String> ingredients;
  final int id;
  final String sourceUrl;
  Map<String, dynamic> nutrients = {};

  Meal({
    this.id,
    this.name,
    this.imagePath,
    this.kiloCaloriesBurnt,
    this.timeTaken,
    this.preparation,
    this.ingredients,
    this.sourceUrl,
  });

  void setNutrients(Map<String, dynamic> map) {
    this.nutrients['calories'] =
        map['calories'].replaceAll((new RegExp(r'[^0-9]')), '');
    this.nutrients['carbs'] =
        map['carbs'].replaceAll((new RegExp(r'[^0-9]')), '');
    this.nutrients['fat'] = map['fat'].replaceAll((new RegExp(r'[^0-9]')), '');
    this.nutrients['protein'] =
        map['protein'].replaceAll((new RegExp(r'[^0-9]')), '');
  }

  void getNutrients(Map<String, dynamic> map) {
    this.nutrients['calories'] = int.parse(map['calories']);
    this.nutrients['carbs'] = int.parse(map['carbs']);
    this.nutrients['fat'] = int.parse(map['fat']);
    this.nutrients['protein'] = int.parse(map['protein']);
  }

  factory Meal.fromMap(Map map) {
    return Meal(
      id: map['id'],
      name: map['title'],
      imagePath:
          'https://spoonacular.com/recipeImages/${map['id']}-636x393.${map['imageType']}',
      sourceUrl: map['sourceUrl'],
      timeTaken: '${map['readyInMinutes']} min',
    );
  }
}
