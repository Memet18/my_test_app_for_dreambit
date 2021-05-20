

import 'package:flutter/material.dart';
import 'package:my_test_app_for_dreambit/data/model/beer.dart';

class BeerDetailPage extends StatelessWidget {
  final Beer beers;
  BeerDetailPage({@required this.beers});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(beers.name),
      ),
      body: Column(
        children: [
          Container(
              height: 300,
              child:FadeInImage.assetNetwork(
                  placeholder: 'images/beer_img.png',
                  image:beers.imageUrl,)),
          Text(beers.name),
          Text(beers.tagline),
          Text(beers.firstBrewed),
          Text(beers.description),
          SizedBox(height: 10),
          Text(beers.foodPairing.toString()),
          SizedBox(height: 10),
          Text(beers.brewersTips),
          SizedBox(height: 10),
          Text(beers.contributedBy.toString()),
        ],
      ),
    );
  }
}
