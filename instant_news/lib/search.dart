import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:instant_news/model/SearchRequest.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<StatefulWidget> {

  @override
  void initState() {
    setState(() {
      _sortBy = "publishedAt";
      _preference = "Everything";
    });
    super.initState();
  }

  final _keywordController = TextEditingController();
  TextField buildKeywordTextField() {
    return TextField(
      controller: _keywordController,
      decoration: InputDecoration(
          labelText: "Keyword",
          hintText: "Input search keywords",
          filled: true,
          border: OutlineInputBorder()),
    );
  }

  // multi options for source
  final sourcesField = TextField(
    decoration: InputDecoration(
      labelText: "Sources",
      hintText: "Select News sources",
      filled: false,
      border: OutlineInputBorder(),
    ),
    onTap: () {
      //todo open a dialog with sources checkboxes
    },
  );

  String _date = "";
  final fromTimeLabel = Text("Search from time: (Optional)",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));

  Container buildDateTimePicker() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 4.0,
            onPressed: () {
              DatePicker.showDatePicker(
                  context, theme: DatePickerTheme(containerHeight: 200),
                  showTitleActions: true,
                  onConfirm: (date) {
                    _date = '${date.year}-${date.month}-${date.day}';
                    setState(() {});
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.en);
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 18.0,
                              color: Colors.teal,
                            ),
                            Text(
                              " $_date",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                    "  Change",
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ],
              ),
            ),
            color: Colors.white,
          )
        ],
      ),
    );
  }


  String _sortBy = "publishedAt";
  final sortByLabel = Text("SortBy: ",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));

  Row buildSortByRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value: "publishedAt",
          groupValue: _sortBy,
          onChanged: _sortByRadioButtonChanges,
        ),
        Text("publishedAt"),
        Radio(
          value: "relevancy",
          groupValue: _sortBy,
          onChanged: _sortByRadioButtonChanges,
        ),
        Text("relevancy"),
        Radio(
          value: "popularity",
          groupValue: _sortBy,
          onChanged: _sortByRadioButtonChanges,
        ),
        Text("popularity"),
      ],
    );
  }

  void _sortByRadioButtonChanges(String value) {
    setState(() {
      _sortBy = value;
    });
  }

  final preferenceLabel = Text("Preference: ",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));

  static String _preference = "test";

  // Single option for sort
  Row buildPreferenceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value: "Top-Trending",
          groupValue: _preference,
          onChanged: (val) {
            _preference = val;
          },
        ),
        Text("Top-Trending"),
        Radio(
          value: "Everything",
          groupValue: _preference,
          onChanged: (val) {
            _preference = val;
          },
        ),
        Text("Everything"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
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
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                buildKeywordTextField(),
                SizedBox(
                  height: 10,
                ),
                fromTimeLabel,
                SizedBox(
                  height: 10,
                ),
                buildDateTimePicker(),
                SizedBox(
                  height: 10,
                ),
                sortByLabel,
                buildSortByRow(),
                SizedBox(
                  height: 10,
                ),
                preferenceLabel,
                buildPreferenceRow(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Search!",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context, SearchRequest(
                      _keywordController.text, _date, _sortBy, _preference, "en"
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
