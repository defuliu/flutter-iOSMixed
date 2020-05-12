import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tool.dart';

class ReportPageWidget extends StatelessWidget{
  ReportPageWidget({Key key,this.title = ""}):super(key : key);
  String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>NativeTool.postMessage("naviToBack", {"animate":"1"})),
      ),
      body: Container(
        color: Colors.yellow[100],
        child: Center(
          child: Column(
            children: <Widget>[
              
            ],
          ),
        ),
      ),
    );
  }
}