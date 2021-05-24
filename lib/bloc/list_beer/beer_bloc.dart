import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_app_for_dreambit/data/model/beer.dart';
import 'package:my_test_app_for_dreambit/data/repositories/beer_repository.dart';

import 'beer_event.dart';
import 'beer_state.dart';


class BeerBloc extends Bloc<BeerEvent, BeerState> {
  BeerRepository repository;
  int page = 1;
  List<Beer> beersLoaded = <Beer>[];

  BeerBloc({@required this.repository}) : super(null);

  @override
  Stream<BeerState> mapEventToState(BeerEvent event) async* {
    if (event is FetchBeerEvent) {
      yield BeerLoadingState();
      try {
        List<Beer> beers = await repository.getBeersList(page);
        beersLoaded.addAll(beers);
        if (beers.length == 0) {
          yield BeerLoadedEmptyState();
        } else {
          yield BeerLoadedState(beers: beers);
        }
      } catch (e) {
        yield BeerErrorState(message: e.toString());
      }
    }
    if (event is BeerEventFetchMore) {
      yield BeerLoadingState();
      try {
        page++;
        List<Beer> beers = await repository.getBeersList(page);
        beersLoaded.addAll(beers);
        yield BeerLoadedState(beers: beers);
      } catch (e) {
        yield BeerErrorState(message: e.toString());
      }
    }
  }
}
