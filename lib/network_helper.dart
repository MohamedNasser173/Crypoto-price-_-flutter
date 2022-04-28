import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);
  Future getData() async {
    var Url = Uri.parse(url);
    http.Response response = await http.get(Url);
    if (response.statusCode == 200)
      return response.body;
    else {
      print(response.statusCode);
    }
  }
}
