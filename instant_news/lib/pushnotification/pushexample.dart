import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PushExampleState();
}

class PushExampleState extends State<PushExample> {
  String _homeScreenText = "Waiting for token...";
  int _bottomBarSelectedIndex = 0;
  bool _newNotification = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _newNotification = true;
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        _navigateToItemDetail(message);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: \n\n $token";
      });
      print(_homeScreenText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Push Demo'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: _newNotification
                  ? Stack(
                      children: <Widget>[
                        Icon(Icons.notifications),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 13,
                              minHeight: 13,
                            ),
                            child: Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    )
                  : Icon(Icons.notifications),
              title: Text('Notifications'),
            ),
          ],
          currentIndex: _bottomBarSelectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
        body: Material(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                _homeScreenText,
                style: TextStyle(fontSize: 19),
              ),
            ),
          ),
        ));
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final MessageBean item = _itemForMessage(message);

    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomBarSelectedIndex = index;
      if (index == 1) {
        _newNotification = false;
      }
    });
  }
}

final Map<String, MessageBean> _items = <String, MessageBean>{};

MessageBean _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message["data"] ?? message;
  final String itemId = data["data"];
  final MessageBean item =
      _items.putIfAbsent(itemId, () => MessageBean(itemId: itemId));

  return item;
}

class MessageBean {
  MessageBean({this.itemId});

  final String itemId;

  StreamController<MessageBean> _controller =
      StreamController<MessageBean>.broadcast();

  Stream<MessageBean> get onChanged => _controller.stream;

  String _status;

  String get status => _status;

  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};

  Route<void> get route {
    final String routeName = "/detail/$itemId";
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => PushDetailPage(itemId),
      ),
    );
  }
}

class PushDetailPage extends StatefulWidget {
  PushDetailPage(this.itemId);

  final String itemId;

  @override
  _PushDetailPageState createState() => _PushDetailPageState();
}

class _PushDetailPageState extends State<PushDetailPage> {
  MessageBean _item;
  StreamSubscription<MessageBean> _subscription;

  @override
  void initState() {
    super.initState();
    _item = _items[widget.itemId];
    _subscription = _item.onChanged.listen((MessageBean item) {
      if (!mounted) {
        _subscription.cancel();
      } else {
        setState(() {
          _item = item;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item ${_item.itemId}"),
      ),
      body: Material(
        child: Center(child: Text("Item status: ${_item.status}")),
      ),
    );
  }
}
