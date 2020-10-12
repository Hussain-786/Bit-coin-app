import 'api_request.dart';
import 'package:flutter/material.dart';
import 'coindata.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  ApiRequest apiRequest = ApiRequest();
  String selectedCurrency = 'USD';
  String selectedCoin = 'ETH';
  @override
  void initState() {
    super.initState();
    getData();
  }
  int rate;
  final kTextStyle = TextStyle(
    fontSize: 20.0,
  );

  DropdownButton getCurrenciesList(){
    List<DropdownMenuItem<String>> listItem = [];
    for(int i=0; i< currenciesList.length; i++){
      var item = DropdownMenuItem(
          child: Text(
            currenciesList[i],
          ),
          value: currenciesList[i],
        );
      listItem.add(item);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: listItem,
      onChanged: (value){
        setState(() async{
          selectedCurrency = value;
          getData();
        });
      },
    );
  }
  DropdownButton getCoinList(){
    List<DropdownMenuItem<String>> listItem = [];
    for(int i=0; i< cryptoList.length; i++){
      var item = DropdownMenuItem(
          child: Text(
            cryptoList[i],
          ),
          value: cryptoList[i],
        );
      listItem.add(item);
    }
    return DropdownButton(
      value: selectedCoin,
      items: listItem,
      onChanged: (value){
        setState(() {
          selectedCoin = value;
          getData();
        });
      },
    );
  }
  
  void getData() async {
    int value = await apiRequest.getResult(selectedCoin, selectedCurrency);
    setState(() {
      rate = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Center(
                child: Text(
                  '1 $selectedCoin = $rate $selectedCurrency',
                  style: kTextStyle,
                ),
              ),
            ),
            color: Colors.lightBlueAccent,
            elevation: 7.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Container(
          height: 150.0,
          color: Colors.lightBlueAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: getCoinList(),
              ),
              SizedBox(
                width: 40.0,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: getCurrenciesList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}