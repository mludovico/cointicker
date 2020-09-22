//TO-DO: Add your imports here.
import 'dart:convert';
import 'package:bitcoin_ticker/api_fallback.dart';
import 'package:bitcoin_ticker/secrets/api_key.dart' as Secrets;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as Http;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const coinAPIIconsURL = 'https://rest.coinapi.io/v1/assets/icons/32';
const headers = {
  'X-CoinAPI-Key': Secrets.apiKey
};

class CoinData {

  Future<Map> getIconData () async {
    Http.Response response = await Http.get(coinAPIIconsURL);
    List list = [];
    if(response.statusCode == 200)
      list = jsonDecode(response.body)..retainWhere((item)=>cryptoList.contains(item['asset_id']));
    Map data = {};
    for(var item in list)
      data[item['asset_id']] = NetworkImage(item['url']);
    return data;
  }

  //TO-DO: Create your getCoinData() method here.

  Future<Map> getCoinData() async {
    Map rates = {};
    for(String crypto in cryptoList){
      rates[crypto] = [];
      Http.Response response = await Http.get(
        '$coinAPIURL/$crypto',
        headers: headers,
      );
      //print(response.statusCode);
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        //print(data);
        rates[crypto] = data['rates'];
      }else
        rates[crypto] =  fallbackData;
    }
    return rates;
  }

  }

