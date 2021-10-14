import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:health_helper/models/user.dart';
import 'package:health_helper/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:health_helper/models/meal.dart';

class MealPlanTile extends StatefulWidget {
  final int index;
  final Meal meal;
  final Function removeFromList;
  MealPlanTile({this.meal, this.index, this.removeFromList});

  @override
  _MealPlanTileState createState() => _MealPlanTileState();
}

class _MealPlanTileState extends State<MealPlanTile> {
  bool _added = false;
  String mealType() {
    switch (widget.index) {
      case 0:
        return 'Breakfast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Dinner';
      default:
        return 'Breakfast';
    }
  }

  @override
  Widget build(BuildContext context) {
    final length = MediaQuery.of(context).size.shortestSide;
    return Container(
      height: 200,
      width: length,
      margin: EdgeInsets.only(
        right: 20,
        bottom: 10,
        left: 20,
      ),
      child: !_added
          ? GestureDetector(
              onTap: () async {
                String url = widget.meal.sourceUrl;
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw ('Error with launching url');
                }
              },
              child: Material(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                elevation: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image(
                          width: length,
                          image: NetworkImage(
                            widget.meal.imagePath,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              mealType(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: length,
                              height: 20,
                              child: AutoSizeText(
                                widget.meal.name,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _added = true;
                                });
                                FirestoreProvider(Provider.of<User>(
                                  context,
                                  listen: false,
                                ).user)
                                    .addMeal(this.widget.meal);
                                Future.delayed(Duration(seconds: 2), () {
                                  widget.removeFromList;
                                });
                              },
                              child: Container(
                                width: length,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'ADD TO MEALS',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
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
            )
          : Stack(
              children: [
                Material(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  elevation: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image(
                            width: length,
                            image: NetworkImage(
                              widget.meal.imagePath,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                mealType(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: length,
                                height: 20,
                                child: AutoSizeText(
                                  widget.meal.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: length,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'ADD TO MEALS',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.green.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Text(
                      'Added!',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
