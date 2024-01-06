import 'dart:convert';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropDownValue = 'USD';
  int exchangeRate = 0;
  List <int> exchangeRateMapping = [0,0,0];

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() async {
    List <int> temp = [];
    for (String bitCoinValue in cryptoList)
      {
        dynamic decoded = await CoinData().getCoinData(dropDownValue, bitCoinValue);
        double rate = decoded['rate'];
        temp.add(rate.toInt());
      }
    setState(() {
      exchangeRateMapping = temp;
    });

  }

  Widget bitcoinCardDisplay() {
    List<Widget> child = [];
    int i = 0;
    for (String bitcoin in cryptoList) {
      child.add(bitcoinDisplayCard(
        exchangeRate: exchangeRateMapping[i++],
        dropDownValue: dropDownValue,
        bitcoin: bitcoin,
      ));
    }
    return Column(children: child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          bitcoinCardDisplay(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: dropDownValue,
              items: currenciesList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(
                  () {
                    dropDownValue = newValue!;
                    updateUI();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class bitcoinDisplayCard extends StatelessWidget {
  const bitcoinDisplayCard({
    super.key,
    required this.exchangeRate,
    required this.dropDownValue,
    required this.bitcoin,
  });

  final int exchangeRate;
  final String dropDownValue;
  final String bitcoin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $bitcoin = $exchangeRate $dropDownValue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
