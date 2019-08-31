import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:countryapp/home/home.bloc.dart';
import 'package:flutter/cupertino.dart';
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
      backgroundColor: Color(0xff111731),
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
                        "Olá, viajante.",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'SF-Pro-Bold',
                          color: Colors.white,
                        ),
                      ),
                      Text("Desbrave o mundo!",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SF-Pro-SemiBold',
                            color: Color(0xff909fb4),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 45,
                        decoration: BoxDecoration(
                            color: Color(0xff1d233b),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                            ),
                            Icon(Icons.search, color: Color(0xff909fb4)),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.3,
                                child: TextField(
                                  textInputAction: TextInputAction.go,
                                  onSubmitted: (value) {
                                    bloc.searchValue.add(value);
                                  },
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'SF-Pro-SemiBold',
                                      fontSize: 16),
                                  decoration:
                                  InputDecoration(border: InputBorder.none),
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
                top: 190,
                height: MediaQuery.of(context).size.height - 190,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Color(0xff1d233b),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
