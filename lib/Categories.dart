import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paper1/Sets.dart';
import 'loading.dart';



class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  bool loading=true;

  int count=0;
  Map map;
  String str="";
  var textstyle=TextStyle(fontSize: 25,color: Colors.white);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firestore.instance.collection("QUIZ").document("Categories").get().then((value){
      //print(value.data);
      map=value.data;
      setState(() {
        loading=false;
      });
      count=value.data["COUNT"];
    });
//    //quiz question
//    Firestore.instance.collection("QUIZ").document("ORnKQaCKuSZzTrYNCVy5").collection("1").document("IUjJajO5PVa99vHsVgLH").get().then((value){
//      print(value.data);
//      //map=value.data;
//    });

//    Firestore.instance.collection("QUIZ").document("ORnKQaCKuSZzTrYNCVy5").get().then((value){
//      print(value.data["SETS"]);
//      int c=value.data["SETS"];
//      for(int i=1;i<=c;i++){
//        print(value.data["SET"+i.toString()+"_ID"]);
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: (loading)?Loading():Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
            itemCount: count,
            itemBuilder: (BuildContext context, int index){
              String id=(index+1).toString();
              return Container(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                  child: Container(
                      //height: 60,
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(
                          color: Colors.grey[600],
                          blurRadius: 5.0,

                        )],
                      ),

                      child: Center(child: Text(map["CAT"+"$id"+"_NAME"],style: textstyle,))
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Sets(map["CAT"+"$id"+"_ID"])));
                  },
                ),
              );

            }
        ),
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