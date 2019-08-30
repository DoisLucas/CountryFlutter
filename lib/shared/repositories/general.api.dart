import 'package:countryapp/shared/constants.dart';
import 'package:countryapp/shared/models/country.dart';
import 'package:dio/dio.dart';

class GeneralApi {
  Dio dio;

  GeneralApi() {
    dio = Dio();
    dio.options.baseUrl = URL_BASE_API;
  }

  Future<Country> getCountry(String name) async {
    Response response = await dio.get("/paises?nome=$name");
    print(response.data);
    return Country.fromJson(response.data[0]);
  }
}
