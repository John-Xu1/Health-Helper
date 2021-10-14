import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_helper/constants.dart';
import 'package:health_helper/models/meal.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:health_helper/models/user.dart';
import 'package:health_helper/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MealTile extends StatefulWidget {
  final Meal meal;
  bool eaten;
  MealTile(this.meal, this.eaten);

  @override
  _MealTileState createState() => _MealTileState();
}

class _MealTileState extends State<MealTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String url = widget.meal.sourceUrl;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw ('Error with launching url');
        }
      },
      onLongPress: () async {
        setState(() {
          widget.eaten = true;
        });

        Future.delayed(Duration(seconds: 3), () {
          FirestoreProvider firestoreProvider =
              FirestoreProvider(Provider.of<User>(
            context,
            listen: false,
          ).user);
          firestoreProvider.updateNutritionStats(widget.meal);
          firestoreProvider.deleteMeal(widget.meal);
        });
      },
      child: !widget.eaten
          ? Container(
              margin: EdgeInsets.only(
                right: 20,
                bottom: 10,
              ),
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
                          image: NetworkImage(widget.meal.imagePath),
                          width: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 30,
                              child: AutoSizeText(
                                widget.meal.name,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              '${widget.meal.nutrients['calories']} cal',
                              style: TextStyle(
                                color: Colors.black38,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.black38,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  widget.meal.timeTaken,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
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
                Container(
                  margin: EdgeInsets.only(
                    right: 20,
                    bottom: 10,
                  ),
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
                              image: NetworkImage(widget.meal.imagePath),
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 30,
                                  child: AutoSizeText(
                                    widget.meal.name,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  '${widget.meal.nutrients['calories']} cal',
                                  style: TextStyle(
                                    color: Colors.black38,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: Colors.black38,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      widget.meal.timeTaken,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Eaten!',
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
