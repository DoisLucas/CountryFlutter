import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/blocs/country.bloc.dart';
import 'package:countryapp/blocs/fav.bloc.dart';
import 'package:countryapp/blocs/navigation.bloc.dart';
import 'package:countryapp/blocs/theme.bloc.dart';
import 'package:countryapp/pages/favorites/favorite.page.dart';
import 'package:countryapp/pages/home/widgets/infotile.dart';
import 'package:countryapp/shared/models/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countryBloc = BlocProvider.getBloc<CountryBloc>();
    final favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();
    final navigationBloc = BlocProvider.getBloc<NavigationBloc>();
    final themeBloc = BlocProvider.getBloc<ThemeBloc>();

    Widget topBar() {
      return Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Olá, viajante.",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'SF-Pro-Bold',
                    color: Theme.of(context).textTheme.title.color),
              ),
              Text("Desbrave o mundo!",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SF-Pro-SemiBold',
                    color: Theme.of(context).textTheme.subtitle.color,
                  )),
            ],
          ),
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        themeBloc.toogleTheme();
                      },
                      child: Icon(
                        themeBloc.themeActive == ThemeOptions.DARK.toString()
                            ? Icons.brightness_5
                            : Icons.brightness_2,
                        color: Theme.of(context).iconTheme.color,
                        size: 26,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigationBloc.getPageController().animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      child: Icon(
                        Icons.sort,
                        color: Theme.of(context).iconTheme.color,
                        size: 26,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      );
    }

    Widget searchBar() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        height: 45,
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
            ),
            Icon(Icons.search,
                color: Theme.of(context).textTheme.subtitle.color),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextField(
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) {
                    countryBloc.searchValue.add(value);
                  },
                  cursorColor: Theme.of(context).textTheme.title.color,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.title.color,
                      fontFamily: 'SF-Pro-SemiBold',
                      fontSize: 16),
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: PageView(
        controller: navigationBloc.getPageController(),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        topBar(),
                        searchBar(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 170,
                  height: MediaQuery.of(context).size.height - 170,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: StreamBuilder<Country>(
                      stream: countryBloc.countryChoose,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.search,
                                    size: 130,
                                    color: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .color
                                        .withAlpha(65),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      "Procure por um pais na barra de pesquisa.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'SF-Pro-Bold',
                                        color: Theme.of(context)
                                            .textTheme
                                            .subtitle
                                            .color
                                            .withAlpha(65),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        Country country = snapshot.data;

                        return SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(
                                      top: 25, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          height: 70,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: country.bandeiraUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 15),
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                165,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  country.nome,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'SF-Pro-Bold',
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .title
                                                        .color,
                                                  ),
                                                ),
                                                Text(
                                                  country.capital,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'SF-Pro-Bold',
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .subtitle
                                                        .color,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 20),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      favoriteBloc
                                                          .toggleFavorite(
                                                              country);
                                                    },
                                                    child: StreamBuilder<
                                                        Map<String, Country>>(
                                                      stream:
                                                          favoriteBloc.outFav,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Container(
                                                            width: 40,
                                                            height: 40,
                                                            child: Icon(
                                                              snapshot.data.containsKey(
                                                                      country
                                                                          .nome)
                                                                  ? Icons
                                                                      .favorite
                                                                  : Icons
                                                                      .favorite_border,
                                                              size: 37,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .title
                                                                  .color,
                                                            ),
                                                          );
                                                        } else {
                                                          return Container();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 15, left: 20, right: 20, bottom: 25),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 15,
                                          bottom: 20,
                                          left: 20,
                                          right: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          InfoTile(
                                              title: "Área: ",
                                              value: "${country.area} km²"),
                                          InfoTile(
                                              title: "População: ",
                                              value: "${country.populacao}"),
                                          InfoTile(
                                              title: "Governo: ",
                                              value: country.governo),
                                          InfoTile(
                                              title: "Lema: ",
                                              value: country.lema),
                                          InfoTile(
                                              title: "Hino: ",
                                              value: country.hino),
                                          InfoTile(
                                              title: "Linguas: ",
                                              value: country.linguas),
                                          InfoTile(
                                              title: "Moeda: ",
                                              value: country.moeda),
                                          InfoTile(
                                              title: "Paises Vizinhos: ",
                                              value: country.vizinhos),
                                          InfoTile(
                                              title: "Fronteiras Matitimas: ",
                                              value: country.fMaritimas),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: Container(
                                              child: Text(
                                                "Powered by SimplePiece",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'SF-Pro-Bold',
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .subtitle
                                                      .color,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          FavoritePage(),
        ],
      ),
    );
  }
}
