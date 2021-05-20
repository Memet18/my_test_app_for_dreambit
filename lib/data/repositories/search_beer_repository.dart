


import 'package:http/http.dart' as http;
import 'package:my_test_app_for_dreambit/data/model/beer.dart';

abstract class SearchRepository {
  Future<List<Beer>> searchBeers(String query);
}

class SearchRepositoryImpl extends SearchRepository {
  @override
  Future<List<Beer>> searchBeers(String query) async {
    var response =
        await http.get('https://api.punkapi.com/v2/beers?beer_name=$query');
    if (response.statusCode == 200) {
      List<Beer> beers = beerFromJson(response.body);
      return beers;
    } else {
      throw Exception('Failed');
    }
  }
}
