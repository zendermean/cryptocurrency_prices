import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CCData.dart';
import 'dart:convert';

class CCList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State<CCList> {
  List<CCData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cryptocurrency prices'),
      ),
      body: Container(
          child: ListView(
        children: _buildList(),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCC(),
      ),
    );
  }

  _loadCC() async {
    final response =
        await http.get('https://api.coinmarketcap.com/v2/ticker/?limit=100');
    if (response.statusCode == 200) {
      var allData =
          (json.decode(response.body) as Map)['data'] as Map<String, dynamic>;

      var dataList = List<CCData>();
      allData.forEach((String key, dynamic val) {
        var record = CCData(
            name: val['name'],
            symbol: val['symbol'],
            rank: val['rank'],
            price: val['quotes']['USD']['price']);

        dataList.add(record);
      });

      setState(() {
        data = dataList;
      });
    }
  }

  List<Widget> _buildList() {
    return data
        .map((CCData f) => ListTile(
              subtitle: Text(f.symbol),
              title: Text(f.name),
              leading: CircleAvatar(child: Text(f.rank.toString())),
              trailing: Text('\$${f.price.toStringAsFixed(2)}'),
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadCC();
  }
}
