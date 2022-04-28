import 'network_helper.dart';
import 'dart:convert';

const apiKey = 'EBED2E8C-D35E-4E6B-AD15-F456CCF89B2C';

class Exchange {
  final String cryptoCurrncy;
  final String selectedCurrncy;
  Exchange(this.cryptoCurrncy, this.selectedCurrncy);
  Future getPriceOfCryptoCurrency() async {
    String url =
        'https://rest.coinapi.io/v1/exchangerate/$cryptoCurrncy/$selectedCurrncy?apiKey=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url);
    try {
      var data = await networkHelper.getData();
      var rate = jsonDecode(data)['rate'];
      return rate;
    } catch (e) {
      print(e);
    }
    ;
  }

  void getExchange() {}
}
