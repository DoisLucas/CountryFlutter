import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';

class NavigationBloc implements BlocBase {
  PageController _pageController = PageController();

  void setPageController(PageController pageController) {
    _pageController = pageController;
  }

  PageController getPageController() {
    return _pageController;
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
