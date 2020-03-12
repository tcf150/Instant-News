import 'dart:developer';

import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instant_news/NewsBloc.dart';

class HealthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HealthState();
}

class HealthState extends State<StatefulWidget> {
  List<FitData> _list = List();
  var isLoading = false;
  var _uploadButtonVisible = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    final list = await FitKit.read(DataType.STEP_COUNT,
        dateFrom: DateTime.now().subtract(Duration(days: 5)),
        dateTo: DateTime.now(),
        limit: 50);

    if (list.length == 0) {
      _list.add(FitData(10, null, null, "source", true));
    } else {
      _list.addAll(list);
    }

    setState(() {
      _list = _list;
      isLoading = false;
      if (_list.length > 1) {
        _uploadButtonVisible = true;
      }
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
              child: _buildDataResultWidget(),
            ),
            Visibility(
              visible: _uploadButtonVisible,
              child: RaisedButton(
                  child: Text("Upload Data",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    // todo upload the data to server
                    newsBloc.postHealthData(_list);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
