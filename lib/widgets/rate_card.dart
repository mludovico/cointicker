import 'package:flutter/material.dart';

class RateCard extends StatelessWidget {

  String coin;
  String currency;
  double rate;
  ImageProvider image;
  RateCard({this.coin, this.currency, this.rate, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: image,
              ),
              Text(
                //TODO: Update the Text Widget with the live bitcoin data here.
                '1 $coin = ${rate.toStringAsFixed(2)} $currency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}