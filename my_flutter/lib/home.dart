import 'package:flutter/material.dart';
import 'tool.dart';

class HomePageWidget extends StatelessWidget{

  HomePageWidget({Key key,this.title = ""}):super(key : key);

  String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>NativeTool.postMessage("naviToBack", {"animate":"1"})),
      ),
      body: Container(
        color: Colors.red[100],
        child: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                onPressed: (){
                  NativeTool.postMessage("Hello world", {"needLogin":"1"});
                },
                child: Text('向Native发送一条消息'),
              )
            ],
          ),
        ),
      ),
    );
  }

}