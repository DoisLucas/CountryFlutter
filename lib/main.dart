import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/blocs/country.bloc.dart';
import 'package:countryapp/blocs/fav.bloc.dart';
import 'package:countryapp/blocs/navigation.bloc.dart';
import 'package:countryapp/pages/home/home.page.dart';
import 'package:countryapp/shared/repositories/general.api.dart';
import 'package:flutter/material.dart';

import 'blocs/theme.bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
      dependencies: [
        Dependency((i) => GeneralApi()),
      ],
      blocs: [
        Bloc((i) => CountryBloc(i.get<GeneralApi>())),
        Bloc((i) => FavoriteBloc()),
        Bloc((i) => NavigationBloc()),
        Bloc((i) => ThemeBloc()),
      ],
    );
  }
}
