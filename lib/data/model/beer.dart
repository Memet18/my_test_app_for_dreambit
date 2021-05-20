// To parse this JSON data, do
//
//     final beer = beerFromJson(jsonString);

import 'dart:convert';

List<Beer> beerFromJson(String str) => List<Beer>.from(json.decode(str).map((x) => Beer.fromJson(x)));

String beerToJson(List<Beer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Beer {
  Beer({
    this.id,
    this.name,
    this.tagline,
    this.firstBrewed,
    this.description,
    this.imageUrl,
    this.foodPairing,
    this.brewersTips,
    this.contributedBy,
  });

  int id;
  String name;
  String tagline;
  String firstBrewed;
  String description;
  String imageUrl;
  List<String> foodPairing;
  String brewersTips;
  ContributedBy contributedBy;

  factory Beer.fromJson(Map<String, dynamic> json) => Beer(
    id: json["id"],
    name: json["name"],
    tagline: json["tagline"],
    firstBrewed: json["first_brewed"],
    description: json["description"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    foodPairing: List<String>.from(json["food_pairing"].map((x) => x)),
    brewersTips: json["brewers_tips"],
    contributedBy: contributedByValues.map[json["contributed_by"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tagline": tagline,
    "first_brewed": firstBrewed,
    "description": description,
    "image_url": imageUrl == null ? null : imageUrl,
    "food_pairing": List<dynamic>.from(foodPairing.map((x) => x)),
    "brewers_tips": brewersTips,
    "contributed_by": contributedByValues.reverse[contributedBy],
  };
}



enum ContributedBy { SAM_MASON_SAMJBMASON, MATT_BALL_GEORDIE_MATT, JOHN_JENKMAN_JOHNJENKMAN }

final contributedByValues = EnumValues({
  "John Jenkman <johnjenkman>": ContributedBy.JOHN_JENKMAN_JOHNJENKMAN,
  "Matt Ball <GeordieMatt>": ContributedBy.MATT_BALL_GEORDIE_MATT,
  "Sam Mason <samjbmason>": ContributedBy.SAM_MASON_SAMJBMASON
});



class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
