import 'package:flutter/material.dart';
import 'tool.dart';
import 'package:flutter/services.dart';

import 'home.dart';
import 'report.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State{
  static const methodChannel = const MethodChannel("com.pages.your/native_get"); 
  static const eventChannel = const EventChannel("com.pages.your/native_post");

  Widget homeWidget = PlaceholderPage();

  @override
  void initState() {
    super.initState();

    eventChannel.receiveBroadcastStream('route').listen(_onEvent,onError: _onError);
    //NativeTool.receiveMessage('route', _onEvent,onError: _onError);
  }

  _onEvent(Object event){
    print('Native message:${event.toString()}');
    Widget current;
    switch (event.toString()) {
      case "MethodChannel":
        current = HomePageWidget(title: event.toString(),);
        break;
      case "EventChannel":
        current = ReportPageWidget(title: event.toString(),);
        break;
      default:
        current = PlaceholderPage();
    }

    setState(() {
      homeWidget = current;
    });

  }
  _onError(Object err){
    print('Native error:$err');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: homeWidget,
    );
  }
}


class PlaceholderPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
      ),
      body: Container(
        child: Center(
          child: MaterialButton(
            color: Colors.redAccent,
            onPressed: (){
              NativeTool.postMessage("naviToBack", {"animate":"1"});
            },
            child: Text('返回'),
          ),
        ),
      ),
    );
  }
}

