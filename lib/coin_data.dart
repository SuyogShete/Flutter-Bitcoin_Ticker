import 'package:http/http.dart' as http;
import 'dart:convert';

const url = 'https://rest.coinapi.io/v1/exchangerate';
const apikey = '0CCF64DD-F071-4ED3-BC0B-E0F00254F2D8';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<dynamic> getCoinData(
      String dropDownValue, String bitcoinValue) async
  {
    var response = await http.get(Uri.parse('$url/$bitcoinValue/$dropDownValue/?apikey=$apikey'));

    dynamic decoded = jsonDecode(response.body);

    return decoded;

  }
}
