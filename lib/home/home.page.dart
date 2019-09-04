import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/blocs/country.bloc.dart';
import 'package:countryapp/blocs/fav.bloc.dart';
import 'package:countryapp/shared/models/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//TODO Handle erros: no flag and wrong search
//TODO Change themeData colors
//TODO Favorites countries
//TODO Splash intro
//TODO Info app with important links
//TODO Animations

class _HomePageState extends State<HomePage> {
  final viewController = PageController();
  final myController = TextEditingController();
  final countryBloc = BlocProvider.getBloc<CountryBloc>();
  final favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111731),
      body: PageView(
        controller: viewController,
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
                        Row(
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
                                    color: Colors.white,
                                  ),
                                ),
                                Text("Desbrave o mundo!",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'SF-Pro-SemiBold',
                                      color: Color(0xff909fb4),
                                    )),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    viewController.animateToPage(1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 45,
                          decoration: BoxDecoration(
                              color: Color(0xff1d233b),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                              ),
                              Icon(Icons.search, color: Color(0xff909fb4)),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: TextField(
                                    textInputAction: TextInputAction.go,
                                    onSubmitted: (value) {
                                      countryBloc.searchValue.add(value);
                                    },
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'SF-Pro-SemiBold',
                                        fontSize: 16),
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
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
                        color: Color(0xff1d233b),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
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
                                    color: Color(0xff909fb4).withAlpha(80),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      "Procure por um pais na barra de pesquisa.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'SF-Pro-Bold',
                                        color: Color(0xff909fb4).withAlpha(80),
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
                                              color: Colors.white.withAlpha(20),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
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
                                            color: Colors.white.withAlpha(20),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
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
                                                    fontSize: 20,
                                                    fontFamily: 'SF-Pro-Bold',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  country.capital,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'SF-Pro-Bold',
                                                    color: Color(0xff909fb4),
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
                                                            child: snapshot.data
                                                                    .containsKey(
                                                                        country
                                                                            .nome)
                                                                ? like_animation(
                                                                    "like")
                                                                : like_animation(
                                                                    "deslike"),
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
                                      color: Colors.white.withAlpha(20),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                                          infoTile(
                                              "Área: ", "${country.area} km²"),
                                          infoTile(
                                              "População: ", country.populacao),
                                          infoTile(
                                              "Governo: ", country.governo),
                                          infoTile("Lema: ", country.lema),
                                          infoTile("Hino: ", country.hino),
                                          infoTile(
                                              "Linguas: ", country.linguas),
                                          infoTile("Moeda: ", country.moeda),
                                          infoTile("Paises Vizinhos: ",
                                              country.vizinhos),
                                          infoTile("Fronteiras Matitimas: ",
                                              country.fMaritimas),
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
                                                color: Color(0xff909fb4)
                                                    .withAlpha(70),
                                              ),
                                            ),
                                          )),
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
          Container(
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
                        color: Colors.white,
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
                                    Country c =
                                        snapshot.data.values.toList()[index];

                                    return Dismissible(
                                      direction: DismissDirection.startToEnd,
                                      key: Key(c.nome),
                                      onDismissed: (direction) {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                duration: Duration(seconds: 2),
                                                action: SnackBarAction(
                                                  label: 'Desfazer',
                                                  disabledTextColor:
                                                      Colors.white,
                                                  textColor: Colors.white,
                                                  onPressed: () {},
                                                ),
                                                content: Text(
                                                    "${c.nome} foi removido dos favoritos")));
                                      },
                                      background: Container(
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        padding: EdgeInsets.only(right: 5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withAlpha(20),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.delete_forever,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("Remover",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'SF-Pro-Bold',
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ),
                                      child: FavoriteTile(context, c),
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
        ],
      ),
    );
  }
}

Widget FavoriteTile(context, Country country) {
  return Container(
    margin: EdgeInsets.only(top: 5, bottom: 5),
    width: MediaQuery.of(context).size.width,
    height: 60,
    decoration: BoxDecoration(
        color: Color(0xff1d233b),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    child: Row(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Opacity(
                opacity: 0.35,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: country.bandeiraUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(country.nome,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'SF-Pro-Bold',
                        color: Colors.white,
                      )),
                  Text(country.capital,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'SF-Pro-Bold',
                        color: Colors.white.withAlpha(130),
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget infoTile(title, value) {
  return Padding(
    padding: EdgeInsets.only(top: 5),
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'SF-Pro-Bold',
          color: Color(0xff909fb4),
        ),
        children: <TextSpan>[
          TextSpan(text: title, style: TextStyle(color: Colors.white)),
          TextSpan(text: "$value", style: TextStyle(fontSize: 15))
        ],
      ),
    ),
  );
}

Widget like_animation(animation) {
  return FlareActor('assets/like.flr', animation: animation);
}
