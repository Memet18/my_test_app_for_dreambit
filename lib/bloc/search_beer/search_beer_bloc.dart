import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_app_for_dreambit/bloc/search_beer/search_beer_event.dart';
import 'package:my_test_app_for_dreambit/bloc/search_beer/search_beer_state.dart';
import 'package:my_test_app_for_dreambit/data/model/beer.dart';
import 'package:my_test_app_for_dreambit/data/repositories/beer_repository.dart';
import 'package:my_test_app_for_dreambit/data/repositories/search_beer_repository.dart';


class SearchBeersBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository;
  BeerRepository beerRepository;

  SearchBeersBloc({@required this.searchRepository,@required this.beerRepository}) : super(null);

  SearchState get initialState => SearchUninitialized();
  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is QueryEmptyEvent) {
      yield SearchUninitialized();
      try {
        List<Beer> beers = await beerRepository.getBeersList(event.page);
        yield SearchLoaded(beers: beers);
      } catch (e) {
        yield SearchError();
      }
    }
    if (event is SearchQueryEvent) {
      yield SearchUninitialized();

      try {
        List<Beer> beers = await searchRepository.searchBeers(event.query);
        yield SearchLoaded(beers: beers);
      } catch (e) {
        yield SearchError();
      }
    }

  }
}
