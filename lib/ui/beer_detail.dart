import 'package:flutter/material.dart';
import 'package:my_test_app_for_dreambit/data/model/beer.dart';
import '../constants.dart';

class BeerDetailPage extends StatelessWidget {
  final Beer beers;

  BeerDetailPage({@required this.beers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(beers.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
                height: 300,
                child: FadeInImage.assetNetwork(
                  placeholder: 'images/beer_img.png',
                  image: beers.imageUrl,
                )),
            Text(
              beers.tagline,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: TEXT_SIZE_14),
            ),
            Text(beers.firstBrewed,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: TEXT_SIZE_14)),
            Text(beers.description),
            SizedBox(height: 10),
            Text(beers.foodPairing.toString()),
            SizedBox(height: 10),
            Text(beers.brewersTips),
            SizedBox(height: 10),
            Text(beers.contributedBy == null
                ? ""
                : beers.contributedBy.toString()),
          ],
        ),
      ),
    );
  }
}
