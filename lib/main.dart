import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/home/home.bloc.dart';
import 'package:countryapp/home/home.page.dart';
import 'package:countryapp/shared/repositories/general.api.dart';
import 'package:flutter/material.dart';

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
        Bloc((i) => HomeBloc(i.get<GeneralApi>())),
      ],
    );
  }
}
