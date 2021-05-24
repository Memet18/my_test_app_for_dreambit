import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_app_for_dreambit/bloc/search_beer/search_beer_bloc.dart';
import 'package:my_test_app_for_dreambit/bloc/search_beer/search_beer_event.dart';
import 'package:my_test_app_for_dreambit/bloc/search_beer/search_beer_state.dart';
import 'package:my_test_app_for_dreambit/core/widgets/list_widget.dart';
import 'package:my_test_app_for_dreambit/generated/l10n.dart';

class BeerSearch extends SearchDelegate<List> {
  SearchBeersBloc searchBeersBloc;

  BeerSearch({@required this.searchBeersBloc});

  String queryString;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.blueGrey,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    queryString = query;
    if (queryString.isEmpty) {
      searchBeersBloc.add(QueryEmptyEvent(page: 1));
    } else {
      searchBeersBloc.add(SearchQueryEvent(query: query));
    }
    return BlocBuilder<SearchBeersBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is SearchUninitialized) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SearchError) {
          return Center(
            child: Text(S.of(context).failed_to_load),
          );
        }
        if (state is SearchLoaded) {
          if (state.beers.isEmpty) {
            return Center(
              child: Text(S.of(context).no_result),
            );
          }
          return buildBeerList(state.beers);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
