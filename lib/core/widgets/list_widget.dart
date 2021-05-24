import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_test_app_for_dreambit/constants.dart';
import 'package:my_test_app_for_dreambit/data/model/beer.dart';
import 'package:my_test_app_for_dreambit/ui/beer_detail.dart';

Widget buildBeerList(List<Beer> beers) {
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
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 90,
                        width: 100,
                        child: beers[index].imageUrl == null
                            ? Image.asset(LOCAL_IMAGE_URL)
                            : Image.network(beers[index].imageUrl)),
                    Expanded(
                      child: Column(
                          children: [
                            Text(
                              beers[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: TEXT_SIZE_14
                              ),
                            ),
                            SizedBox(height: 4,),
                            Text(beers[index].tagline),
                            SizedBox(height: 4,),
                            Text(beers[index].firstBrewed),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
