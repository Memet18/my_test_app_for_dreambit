import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_test_app_for_dreambit/data/model/beer.dart';


abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchUninitialized extends SearchState {}
class SearchLoaded extends SearchState {
  final List<Beer> beers;
  SearchLoaded({@required this.beers});

}

class SearchError extends SearchState {}
