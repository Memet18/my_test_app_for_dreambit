import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_test_app_for_dreambit/data/model/beer.dart';


abstract class BeerState extends Equatable {
  @override
  List<Object> get props => [];
}

class BeerInitialState extends BeerState {}

class BeerLoadingState extends BeerState {}

class BeerLoadedState extends BeerState {
  final List<Beer> beers;

  BeerLoadedState({
    @required this.beers,
  });

  @override
  List<Object> get props => [beers];
}

class BeerLoadedEmptyState extends BeerState {}

class BeerErrorState extends BeerState {
  final String message;

  BeerErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}
