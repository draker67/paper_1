import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int count=0;
  Map map;
  String str="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fstore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index){
            str=map["CAT"+"$index"+"_NAME"];
            if(str!=null){
              return Text(str);
            }
            else{
              return Text("loading");
            }

          }
      ),
    );
  }

  void fstore() async
  {
    Firestore.instance.collection("QUIZ").document("Categories").get().then((value){
      //print(value.data);
      map=value.data;
      print(map["CAT"+"1"+"_NAME"]);
      count=value.data["COUNT"];
    });
  }
}
