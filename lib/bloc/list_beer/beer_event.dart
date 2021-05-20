import 'package:equatable/equatable.dart';

abstract class BeerEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class BeerEventStart extends BeerEvent {}

class FetchBeerEvent extends BeerEvent {}

class BeerEventFetchMore extends BeerEvent {}
