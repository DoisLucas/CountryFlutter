import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/blocs/country.bloc.dart';
import 'package:countryapp/blocs/fav.bloc.dart';
import 'package:countryapp/blocs/navigation.bloc.dart';
import 'package:countryapp/pages/favorites/favorite.page.dart';
import 'package:countryapp/pages/home/home.page.dart';
import 'package:countryapp/shared/repositories/general.api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'blocs/theme.bloc.dart';

//TODO Handle erros: no flag and wrong search
//TODO Splash intro
//TODO Info app with important links
//TODO Flare no favorites fix

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: App(),
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

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.getBloc<ThemeBloc>();
    return StreamBuilder<ThemeData>(
        stream: themeBloc.theme,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (themeBloc.themeActive == ThemeOptions.DARK.toString()) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light));
            } else {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark));
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Home(),
              theme: snapshot.data,
            );
          } else {
            return Container();
          }
        });
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.getBloc<NavigationBloc>();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: PageView(
        controller: navigationBloc.getPageController(),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          HomePage(),
          FavoritePage(),
        ],
      ),
    );
  }
}
