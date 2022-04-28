import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'exchange.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  int cryptoPricesOfBTC = 0;
  int cryptoPricesOfETH = 0;
  int cryptoPricesOfLTC = 0;
  List<String> cryptocurrencyList = ['BTC', 'ETH', 'LTC'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPriceOfCrypto('USD');
  }

  void getPriceOfCrypto(String selectedCurrency) async {
    List pricesOFCryptoCurrencies = [];
    for (int i = 0; i < cryptocurrencyList.length; i++) {
      Exchange exchange = Exchange(cryptocurrencyList[i], selectedCurrency);
      var price = await exchange.getPriceOfCryptoCurrency();
      pricesOFCryptoCurrencies.add(price);
    }
    upDataUi(pricesOFCryptoCurrencies, selectedCurrency);
  }

  void upDataUi(List pricesOFCryptoCurrencies, String SelectedCurrency) {
    setState(() {
      cryptoPricesOfBTC = pricesOFCryptoCurrencies[0].toInt();
      cryptoPricesOfETH = pricesOFCryptoCurrencies[1].toInt();
      cryptoPricesOfLTC = pricesOFCryptoCurrencies[2].toInt();
      selectedCurrency = SelectedCurrency;
    });
  }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItem.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItem,
      onChanged: (currencySelected) async {
        selectedCurrency = currencySelected;
        getPriceOfCrypto(selectedCurrency);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> CupertinoPickerItems = [];
    for (String currency in currenciesList) {
      CupertinoPickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 30.0,
      backgroundColor: Colors.lightBlue,
      children: CupertinoPickerItems,
      onSelectedItemChanged: (Currency) {
        getPriceOfCrypto(cryptocurrencyList[Currency]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          exchangeCard('BTC', cryptoPricesOfBTC),
          SizedBox(height: 20),
          exchangeCard('ETH', cryptoPricesOfETH),
          SizedBox(height: 20),
          exchangeCard('LTC', cryptoPricesOfLTC),
          SizedBox(height: 230),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidDropDown() : iOSPicker(),
          ),
        ],
      ),
    );
  }

  Card exchangeCard(String Cryptocurrency, int rate) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $Cryptocurrency = $rate $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
