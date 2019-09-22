import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeOptions { LIGHT, DARK }

class ThemeBloc implements BlocBase {
  String themeActive;

  List<ThemeData> _availableThemes = [themeDark, themeLight];

  BehaviorSubject<ThemeData> _themeController = BehaviorSubject();
  Stream<ThemeData> get theme => _themeController.stream;

  ThemeBloc() {
    getTheme().then((f) => setTheme(f));
  }

  toogleTheme() {
    if (themeActive == ThemeOptions.DARK.toString()) {
      setTheme(ThemeOptions.LIGHT);
      themeActive = ThemeOptions.LIGHT.toString();
    } else if (themeActive == ThemeOptions.LIGHT.toString()) {
      setTheme(ThemeOptions.DARK);
      themeActive = ThemeOptions.DARK.toString();
    }
  }

  setTheme(ThemeOptions option) {
    switch (option) {
      case ThemeOptions.DARK:
        _themeController.add(_availableThemes[0]);
        _saveState(
          option.toString(),
        );
        themeActive = option.toString();
        break;
      case ThemeOptions.LIGHT:
        _themeController.add(_availableThemes[1]);
        _saveState(
          option.toString(),
        );
        themeActive = option.toString();
        break;
    }
  }

  Future<ThemeOptions> getTheme() async {
    ThemeOptions store;

    await SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("themeSelected")) {
        String themeStore = prefs.getString("themeSelected");

        if (themeStore == ThemeOptions.DARK.toString()) {
          store = ThemeOptions.DARK;
        } else if (themeStore == ThemeOptions.LIGHT.toString()) {
          store = ThemeOptions.LIGHT;
        }
      } else {
        store = ThemeOptions.DARK;
      }
    });

    return store;
  }

  _saveState(value) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("themeSelected", value);
    });
  }

  static ThemeData themeDark = ThemeData(
    backgroundColor: Color(0xff111731),
    accentColor: Color(0xff1d233b),
    primaryColorLight: Color(0xff2f344a),
    textSelectionHandleColor: Colors.white,
    textSelectionColor: Color(0xff909fb4),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      title: TextStyle(color: Colors.white),
      subtitle: TextStyle(
        color: Color(0xff909fb4),
      ),
    ),
  );

  static ThemeData themeLight = ThemeData(
    backgroundColor: Color(0xffffffff),
    accentColor: Color(0xffC6CFD6),
    textSelectionHandleColor: Color(0xff003031),
    textSelectionColor: Color(0xff003031).withAlpha(120),
    primaryColorLight: Colors.black.withAlpha(20),
    iconTheme: IconThemeData(
      color: Color(
        0xff003031,
      ),
    ),
    textTheme: TextTheme(
      title: TextStyle(
        color: Color(0xff003031),
      ),
      subtitle: TextStyle(
        color: Color(0xff003031).withAlpha(120),
      ),
    ),
  );

  @override
  void dispose() {
    _themeController.close();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
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
