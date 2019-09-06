import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/shared/models/country.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Country> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Country>>.seeded({});
  Stream<Map<String, Country>> get outFav => _favController.stream;
  
  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites = json.decode(prefs.getString("favorites")).map((k, v) {
          return MapEntry(k, Country.fromJson(v));
        }).cast<String, Country>();

        _favController.add(_favorites);
      }
    });
  }

  void toggleFavorite(Country country){
    if(_favorites.containsKey(country.nome)) _favorites.remove(country.nome);
    else _favorites[country.nome] = country;
    _favController.sink.add(_favorites);
    print(_favorites);
    _saveFav();
  }

  void _saveFav(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("favorites", json.encode(_favorites));
    });
  }

  void removeFav(Country c){
    _favorites.remove(c.nome);
    _favController.sink.add(_favorites);
    _saveFav();
  }

  void addFav(Country c){
    _favorites[c.nome] = c;
    _favController.sink.add(_favorites);
    _saveFav();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _favController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
}
