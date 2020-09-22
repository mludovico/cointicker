import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosPicker extends StatelessWidget {

  final List currenciesList;
  final Function (int index)onChange;
  IosPicker({@required this.currenciesList, @required this.onChange});

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: onChange,
      children: currenciesList.map<Widget>((currency){
        return Text(currency);
      }),
    );
  }
}
