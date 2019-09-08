import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/blocs/country.bloc.dart';
import 'package:countryapp/blocs/fav.bloc.dart';
import 'package:countryapp/blocs/navigation.bloc.dart';
import 'package:countryapp/pages/favorites/widgets/favoritetile.dart';
import 'package:countryapp/shared/models/country.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {

  final countryBloc = BlocProvider.getBloc<CountryBloc>();
  final favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();
  final navigationBloc = BlocProvider.getBloc<NavigationBloc>();

  Future<bool> _willPopCallback() async {
    await navigationBloc.getPageController().animateToPage(0, duration: Duration(milliseconds:
    500), curve: Curves.ease);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Favoritos",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'SF-Pro-Bold',
                    color: Theme.of(context).textTheme.title.color,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder<Map<String, Country>>(
                    initialData: {},
                    stream: favoriteBloc.outFav,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                Country c = snapshot.data.values.toList()[index];

                                return Dismissible(
                                  direction: DismissDirection.endToStart,
                                  key: Key(c.nome),
                                  onDismissed: (direction) {
                                    favoriteBloc.removeFav(c);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        duration: Duration(seconds: 2),
                                        action: SnackBarAction(
                                          label: 'Desfazer',
                                          disabledTextColor: Colors.white,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            favoriteBloc.addFav(c);
                                          },
                                        ),
                                        content: Text(
                                            "${c.nome} foi removido dos favoritos")));
                                  },
                                  background: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    padding: EdgeInsets.only(right: 5),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text("Remover",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'SF-Pro-Bold',
                                              color: Theme.of(context).textTheme.title.color,
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.delete_forever,
                                          size: 20,
                                          color: Theme.of(context).textTheme.title.color,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: GestureDetector(
                                      onTap: () {
                                        navigationBloc
                                            .getPageController()
                                            .animateToPage(0,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.ease);
                                        countryBloc.injectCountry(c);
                                      },
                                      child: FavoriteTile(country: c)),
                                );
                              }),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
