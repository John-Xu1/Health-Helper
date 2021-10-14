import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_helper/constants.dart';
import 'package:health_helper/models/meal.dart';

class FirestoreProvider {
  FirebaseUser user;

  FirestoreProvider(this.user);

  void createUserDocument() async {
    await db.collection('users').document(user.uid).get().then((doc) {
      if (!doc.exists) {
        db.collection('users').document(user.uid).setData({
          'name': user.displayName,
          'email': user.email,
          'photoUrl': user.photoUrl,
        });
      }
    });
  }

  void addMeal(Meal meal) async {
    await db
        .collection('users')
        .document(user.uid)
        .collection('meals')
        .document('${meal.id}')
        .setData({
      'name': meal.name,
      'imagePath': meal.imagePath,
      'sourceUrl': meal.sourceUrl,
      'timeTaken': meal.timeTaken,
      'calories': meal.nutrients['calories'],
      'carbs': meal.nutrients['carbs'],
      'fat': meal.nutrients['fat'],
      'protein': meal.nutrients['protein'],
      'id': meal.id,
    });
  }

  void deleteMeal(Meal meal) async {
    await db
        .collection('users')
        .document(user.uid)
        .collection('meals')
        .document('${meal.id}')
        .delete();

    print('document deleted');
  }

  void updateNutritionStats(Meal meal) async {
    print('meal nutrients for update meal statas');
    print(meal.nutrients);
    var dateRef = db
        .collection('users')
        .document(user.uid)
        .collection('dates')
        .document(
            '${DateTime.now().month}${DateTime.now().day}${DateTime.now().year}');

    // dateRef.setData({
    //   'calories': meal.nutrients['calories'],
    //   'fat': meal.nutrients['carbs'],
    //   'carbs': meal.nutrients['fat'],
    //   'protein': meal.nutrients['protein'],
    // });

    dateRef.get().then((value) => {
          if (value.exists)
            {
              print('exists'),
              dateRef.updateData({
                'calories': FieldValue.increment(meal.nutrients['calories']),
                'fat': FieldValue.increment(meal.nutrients['fat']),
                'carbs': FieldValue.increment(meal.nutrients['carbs']),
                'protein': FieldValue.increment(meal.nutrients['protein']),
              })
            }
          else
            {
              print('does not exists'),
              dateRef.setData({
                'calories': meal.nutrients['calories'],
                'fat': meal.nutrients['carbs'],
                'carbs': meal.nutrients['fat'],
                'protein': meal.nutrients['protein'],
              })
            }
        });
  }
}
