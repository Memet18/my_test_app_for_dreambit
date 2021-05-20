

import 'package:http/http.dart' as http;
import 'package:my_test_app_for_dreambit/data/model/beer.dart';

abstract class BeerRepository {
  Future<List<Beer>> getBeersList(int page);
}

class BeerRepositoryImpl extends BeerRepository {
  @override
  Future<List<Beer>> getBeersList(int page) async {
    var response =
        await http.get('https://api.punkapi.com/v2/beers?page=2&per_page=80');
    if (response.statusCode == 200) {
      List<Beer> beers = beerFromJson(response.body);
      return beers;
    } else {
      throw Exception('Failed');
    }
  }
}
