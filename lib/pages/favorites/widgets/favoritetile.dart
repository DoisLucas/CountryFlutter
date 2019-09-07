import 'package:countryapp/shared/models/country.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoriteTile extends StatelessWidget {
  final Country country;

  const FavoriteTile({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  opacity: 0.45,
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
}
