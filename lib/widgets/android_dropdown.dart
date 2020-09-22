import 'package:flutter/material.dart';

class AndroidDropDown extends StatefulWidget {

  List currenciesList;
  String selectedCurrency;
  Function (String value) onChange;
  AndroidDropDown({
    @required this.currenciesList,
    @required this.selectedCurrency,
    @required this.onChange
  });

  @override
  _AndroidDropDownState createState() => _AndroidDropDownState();
}

class _AndroidDropDownState extends State<AndroidDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedCurrency,
      items: widget.currenciesList.map<DropdownMenuItem<String>>((currency){
        return DropdownMenuItem<String>(
          child: Text(currency),
          value: currency,
        );
      }).toList(),
      onChanged: widget.onChange
    );
  }
}
