import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paper1/question.dart';
import 'loading.dart';

class Sets extends StatefulWidget {
  String str="";

  Sets(this.str);

  @override
  _SetsState createState() => _SetsState(str);


}

class _SetsState extends State<Sets> {
  bool loading=true;
  String str="";
  int setcount=1;
  Map map;
  var textstyle=TextStyle(fontSize: 25,color: Colors.white);
  _SetsState(this.str);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Firestore.instance.collection("QUIZ").document(str).get().then((value){
      map=value.data;
      setcount=value.data["SETS"];

      setState(() {
        map=map;
        loading=false;
        setcount=setcount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sets"),
      ),
      body: (loading)?Loading():Container(
        margin: EdgeInsets.only(top: 10),
        child: GridView.builder(
          itemCount: setcount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index){
            int i=index+1;
            if(map==null){
              return Text("loading");
            }
            else{
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [BoxShadow(
                      color: Colors.grey[600],
                      blurRadius: 5.0,

                    )],
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),

                  child: Center(child:Text(i.toString(),style: textstyle) ,)
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>question(str,map["SET"+i.toString()+"_ID"])));
                },
              );
            }


          }
        ),
      ),
    );
  }
}
