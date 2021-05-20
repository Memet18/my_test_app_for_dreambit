import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_test_app_for_dreambit/data/model/beer.dart';
import 'package:my_test_app_for_dreambit/ui/beer_detail.dart';


Widget buildHintsList(List<Beer> beers) {
  return ListView.builder(
            itemCount: beers.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BeerDetailPage(beers: beers[index])));
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 90,
                            width: 100,
                            child: Image.network(beers[index].imageUrl)),

                        Text(beers[index].name),
                        Text(beers[index].tagline),
                        Text(beers[index].firstBrewed),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              );
            }
  );
}
