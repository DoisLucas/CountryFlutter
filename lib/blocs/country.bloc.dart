import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/shared/models/country.dart';
import 'package:countryapp/shared/repositories/general.api.dart';
import 'package:rxdart/rxdart.dart';

class CountryBloc implements BlocBase {
  final GeneralApi api;

  CountryBloc(this.api) {
    _searchController.listen(_search);
  }

  final BehaviorSubject<Country> _countryCotroller = BehaviorSubject<Country>();
  Stream<Country> get countryChoose => _countryCotroller.stream;

  final BehaviorSubject<String> _searchController = BehaviorSubject<String>();
  Sink<String> get searchValue => _searchController.sink;

  void _search(String name) async {
    if (name != null) {
      _countryCotroller.sink.add(await api.getCountry(name));
    }
  }

  @override
  void dispose() {
    _countryCotroller.close();
    _searchController.close();
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
