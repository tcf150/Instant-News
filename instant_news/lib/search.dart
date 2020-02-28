import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<StatefulWidget> {
  final keywordField = TextField(
    decoration: InputDecoration(
        labelText: "Keyword",
        hintText: "Input search keywords",
        filled: true,
        border: OutlineInputBorder()),
  );

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

  final fromField = TextField(
    decoration: InputDecoration(
      icon: Icon(Icons.calendar_today),
      hintText: "news from: ",
      filled: false,
    ),
    onTap: () {
      //TODO open date time picker
    },
  );

  final toField = TextField(
    decoration: InputDecoration(
      icon: Icon(Icons.calendar_today),
      hintText: "news to: ",
      filled: false,
    ),
    onTap: () {
      //TODO open date time picker
    },
  );

  final sortByLabel = Text("SortBy: ",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));

  // Single option for sort
  final sortByField = Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Radio(
        value: 1,
        groupValue: "groupvalue1",
        onChanged: (val) {},
      ),
      Text("publishedAt"),
      Radio(
        value: 2,
        groupValue: "groupvalue2",
        onChanged: (val) {},
      ),
      Text("relevancy"),
      Radio(
        value: 1,
        groupValue: "groupvalue3",
        onChanged: (val) {},
      ),
      Text("popularity"),
    ],
  );

  final preferenceLabel = Text("Preference: ",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));

  // Single option for sort
  final apiField = Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Radio(
        value: 1,
        groupValue: "Top Trending",
        onChanged: (val) {},
      ),
      Text("Top Trending"),
      Radio(
        value: 2,
        groupValue: "Everything",
        onChanged: (val) {},
      ),
      Text("Everything"),
    ],
  );

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
            children: <Widget>[
              keywordField,
              SizedBox(
                height: 10,
              ),
              sourcesField,
              SizedBox(
                height: 10,
              ),
              fromField,
              SizedBox(
                height: 10,
              ),
              toField,
              SizedBox(
                height: 10,
              ),
              sortByLabel,
              sortByField,
              SizedBox(
                height: 10,
              ),
              preferenceLabel,
              apiField,
              SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }
}
