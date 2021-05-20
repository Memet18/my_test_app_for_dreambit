import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_app_for_dreambit/bloc/search_beer/search_beer_bloc.dart';
import 'package:my_test_app_for_dreambit/bloc/search_beer/search_beer_event.dart';
import 'package:my_test_app_for_dreambit/bloc/search_beer/search_beer_state.dart';
import 'package:my_test_app_for_dreambit/ui/beer_detail.dart';


class BeerSearch extends SearchDelegate<List> {
  SearchBeersBloc searchBeersBloc;

  BeerSearch({@required this.searchBeersBloc});

  String queryString;

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
            child: Text('Failed To Load'),
          );
        }
        if (state is SearchLoaded) {
          if (state.beers.isEmpty) {
            return Center(
              child: Text('No Results'),
            );
          }
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BeerDetailPage(beers: state.beers[index])));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 90,
                            width: 100,
                            child: Image.network(state.beers[index].imageUrl)),
                        Text(state.beers[index].name),
                        Text(state.beers[index].tagline),
                        Text(state.beers[index].firstBrewed),
                      ],
                    ),
                  ),
                );
              },
              itemCount: state.beers.length);
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
