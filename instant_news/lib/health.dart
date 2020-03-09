import 'dart:developer';

import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HealthState();
}

class HealthState extends State<StatefulWidget> {
  final _dataController = TextEditingController();
  List<FitData> _list = List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    final list = await FitKit.read(DataType.STEP_COUNT);

    setState(() {
      _list = list;
      isLoading = false;
    });
  }

  Widget _buildDataResultWidget() {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(_list[index].toString()),
              );
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // TODO clear all the filters
            },
            textColor: Colors.white,
            child: Text("Clear"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Revoke Permission!",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  FitKit.revokePermissions();
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Get Permission!",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  List<DataType> list = [
                    DataType.DISTANCE,
                    DataType.ENERGY,
                    DataType.HEART_RATE,
                    DataType.HEIGHT,
                    DataType.SLEEP,
                    DataType.STEP_COUNT,
                    DataType.WATER,
                    DataType.WEIGHT,
                  ];
                  FitKit.requestPermissions(list);
                },
              ),
            ),
            // todo a button and text view to show data.
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Get DataType",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  _fetchData();
                  log("fetch data is called.");
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: new Text(_list[index].toString()),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
