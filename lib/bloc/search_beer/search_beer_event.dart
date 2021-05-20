import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchQueryEvent extends SearchEvent {
  final String query;

  SearchQueryEvent({@required this.query});

}

class QueryEmptyEvent extends SearchEvent {
  final int page;

  QueryEmptyEvent({@required this.page});
}