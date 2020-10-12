import 'package:http/http.dart' as http;
import 'dart:convert';

const apikey = '05C3DC6D-2CB8-49FB-9741-1424355D5260';

class ApiRequest{

  Future<int> getResult(String selectedCoin, String selectedCurrency) async {
    http.Response response = await http.get('https://rest.coinapi.io/v1/exchangerate/$selectedCoin/$selectedCurrency?apikey=$apikey');
    var data = response.body;
    var apiData = jsonDecode(data);
    int rate = apiData['rate'].toInt();
    return rate;
    
  }
}