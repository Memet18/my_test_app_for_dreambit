import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_app_for_dreambit/theme.dart';
import 'package:my_test_app_for_dreambit/ui/home_page.dart';

import 'bloc/list_beer/beer_bloc.dart';
import 'bloc/search_beer/search_beer_bloc.dart';
import 'data/repositories/beer_repository.dart';
import 'data/repositories/search_beer_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBeersBloc(
              searchRepository: SearchRepositoryImpl(),beerRepository: BeerRepositoryImpl()
          ),
        ),
        BlocProvider(
            create: (context) => BeerBloc(
              repository: BeerRepositoryImpl(),
            )),
      ],
      child: AdaptiveTheme(
          light: lightTheme,
          initial: AdaptiveThemeMode.light,
          builder: (light, dark) => MaterialApp(
            theme: light,
            darkTheme: dark,
            home: ListPage(),
          )),
    );
  }
}
