import 'package:bitcoin_ticker/widgets/android_dropdown.dart';
import 'package:bitcoin_ticker/widgets/ios_picker.dart';
import 'package:bitcoin_ticker/widgets/rate_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  Map rates = {};
  Map iconData = {};
  CoinData coinData;

  //TO-DO: Create a method here called getData() to get the coin data from coin_data.dart
  void getData() async {
    var data = await coinData.getCoinData();
    if (data != null) {
      setState(() {
        //print('data = $data');
        rates = data..forEach((key, value) {
          value.retainWhere((item)=>currenciesList.contains(item['asset_id_quote']));
        });
        //print('rates = $rates');
      });
    }
  }

  void getIconData() async {
    iconData = await coinData.getIconData();
  }

  @override
  void initState() {
    super.initState();
    //TO-DO: Call getData() when the screen loads up.
    coinData = CoinData();
    getData();
    getIconData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rates == null || rates.isEmpty
          ?
        [
          Expanded(
            child: Center(
              //padding: EdgeInsets.only(top: 80),
              child: Platform.isIOS
                ?
              CupertinoActivityIndicator()
                :
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
          )
        ]
          :
        cryptoList.map<Widget>((crypto){
            return RateCard(
              currency: selectedCurrency,
              coin: crypto,
              rate: rates[crypto].firstWhere((element) => element['asset_id_quote'] == selectedCurrency)['rate'],
              image: iconData[crypto],
            );
          }).toList()..add(
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS
                ?
              IosPicker(
                currenciesList: currenciesList,
                onChange: (index){
                  setState(() {
                    selectedCurrency = currenciesList[index];
                  });
                },
              )
                :
              AndroidDropDown(
              currenciesList: currenciesList,
              selectedCurrency: selectedCurrency,
              onChange: (value){
                setState(() {
                  selectedCurrency = value;
                });
                print(selectedCurrency);
              },
            ),
            ),
          )
      ),
    );
  }
}


