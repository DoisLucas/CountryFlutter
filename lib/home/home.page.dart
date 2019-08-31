import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/home/home.bloc.dart';
import 'package:countryapp/shared/models/country.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();
  final bloc = BlocProvider.getBloc<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Bem vindo",
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'SF-Pro-Bold',
                          color: Colors.white,
                        ),
                      ),
                      Text("Ao seu paískipédia!",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'SF-Pro-Bold',
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 500,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              )

//              TextField(
//                controller: myController,
//              ),
//              RaisedButton(
//                onPressed: () {
//                  bloc.searchValue.add(myController.text);
//                },
//                color: Colors.pink,
//              ),
//              StreamBuilder<Country>(
//                stream: bloc.countryChoose,
//                builder: (context, snapshot) {
//                  if (!snapshot.hasData) {
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                  }
//                  Country country = snapshot.data;
//                  return Column(
//                    children: <Widget>[
//                      Text(country.nome),
//                      Text(country.capital),
//                      Image.network(country.bandeiraUrl),
//                    ],
//                  );
//                },
//              ),
            ],
          )),
    );
  }
}
