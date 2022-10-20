import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  Future<List<String>> getCurrencies() async {
    var client = http.Client();
    var currencyURL = Uri.parse(
        'https://api.currencyapi.com/v3/latest?apikey=9iGwf09yGFaQhoRMgYtNKx3ZZE41L7MLkNGa3LO2');
    var response = await client.get(currencyURL);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var list = body["data"];
      List<String> currencies = (list.keys).toList();
      print(currencies);
      return currencies;
    } else {
      throw Exception("Failed to convert");
    }
  }

  Future<double> getRate(String from, String to) async {
    var rateUrl =
        "https://api.currencyapi.com/v3/latest?apikey=9iGwf09yGFaQhoRMgYtNKx3ZZE41L7MLkNGa3LO2&";

    Map<String, String> queryParams = {
      'currencies': '${to}',
      'base_currency': '${from}'
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = Uri.parse(rateUrl + queryString);

    http.Response res = await http.get(requestUrl);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var result = body["data"]["${to}"]["value"];
      return result;
    } else {
      throw Exception("Failed to convert");
    }
  }
}
