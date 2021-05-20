
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_app_for_dreambit/bloc/list_beer/beer_bloc.dart';
import 'package:my_test_app_for_dreambit/bloc/list_beer/beer_event.dart';
import 'package:my_test_app_for_dreambit/bloc/list_beer/beer_state.dart';
import 'package:my_test_app_for_dreambit/bloc/search_beer/search_beer_bloc.dart';
import 'package:my_test_app_for_dreambit/core/widgets/error.dart';
import 'package:my_test_app_for_dreambit/core/widgets/loading.dart';
import 'package:my_test_app_for_dreambit/core/widgets/search_beer_widget.dart';



import 'beer_detail.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  BeerBloc beerBloc;

  @override
  void initState() {
    beerBloc = BlocProvider.of<BeerBloc>(context);
    beerBloc.add(FetchBeerEvent());
    super.initState();
  }
  @override
  void dispose() {
    beerBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: BeerSearch(
                        searchBeersBloc: BlocProvider.of<SearchBeersBloc>(context)));
              }),
        ],
      ),
      body: Container(
          child: BlocBuilder<BeerBloc, BeerState>(builder: (context, state) {
            if (state is BeerInitialState) {
              return buildLoading();
            } else if (state is BeerLoadingState) {
              return buildLoading();
            } else if(state is BeerLoadedEmptyState){
              return buildError("List Empty");
            }
            else if (state is BeerLoadedState) {
              return  ListView.builder(
                  itemCount: state.beers.length,
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BeerDetailPage(beers: state.beers[index])));
                        },
                        child: Container(
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
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              );
            } else if (state is BeerErrorState) {
              return buildError(state.message);
            }
            return buildLoading();
          }),
        ),
    );
  }

}
