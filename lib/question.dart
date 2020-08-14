import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'score.dart';
import 'dart:async';

class Item{
  String question;
  String A;
  String B;
  String C;
  String D;
  String ans;
  String explanation;
  Item(this.question,this.A,this.B,this.C,this.D,this.ans,this.explanation);
}

class question extends StatefulWidget {
  String set="";
  question(this.set);



  @override
  _questionState createState() => _questionState(set);
}

class _questionState extends State<question> {
  bool loading=true;
  String set="";
  Map map;
  String ques="loading";
  String a="loading";
  String b="loading";
  String c="loading";
  String d="loading";
  String exp="loading";
  String quescount;
  QuerySnapshot snapshot;
  List list=[];
  List choice=[];
  int no=0;
  String nextOrFinish="Next";

  //timer implimentation

  Timer _timer;
  int _start = 15;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  var textstyle=TextStyle(fontSize: 25,color: Colors.white);

  _questionState(this.set);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Firestore.instance.collection("QUIZ").document("ORnKQaCKuSZzTrYNCVy5").collection(set).getDocuments().then((snapshot){
      snapshot.documents.forEach((result) {
        //print(result.data);
        if(result.data["A"]!=null)
          {
            list.add(Item(result.data["QUESTION"], result.data["A"], result.data["B"], result.data["C"], result.data["D"],result.data["ANSWER"],result.data["EXPLANATION"]));
          }


        if(result.data.containsKey("COUNT")){
          quescount=result.data["COUNT"];
          print(quescount);
        }
      });

      //print(snapshot.documents[0].data  );
      map=snapshot.documents[0].data;


      setState(() {
        loading=false;
        ques=map["QUESTION"];
        a=map["A"];
        b=map["B"];
        c=map["C"];
        d=map["D"];
        exp=map["EXPLANATION"];

      });

      startTimer();


    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        //color: Colors.yellow,
        width: 80,
        height: 80,
        child: FloatingActionButton(
          child: Container(
            padding: EdgeInsets.all(10),
              child: Text("$_start", style: TextStyle(fontSize: 30, color: Colors.white),textAlign: TextAlign.center,)),
        ),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Question"),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.timer),
                  Container(width: 5,),
                  Text("$_start"),
                ],
              ),
            )
          ],
        ),

      ),
      body: ListView(
        children: <Widget>[
//          Container(
//            //width: 2,
//            padding: EdgeInsets.all(20),
//            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//            child: Text("$_start", style: TextStyle(fontSize: 25, color: Colors.white),textAlign: TextAlign.center,),
//            decoration: BoxDecoration(
//              color: Colors.blue,
//              //borderRadius: BorderRadius.circular(25),
//              shape: BoxShape.circle,
//            ),
//
//          ),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueAccent[700],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(
                color: Colors.grey[600],
                blurRadius: 5.0,

              )],

            ),
            child: Text(list[no].question,style: textstyle,)
          ),
          GestureDetector(
            onTap: (){
              choice.add(1);
              print(choice.last);
              resetTimer();

              nextQues();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Colors.grey[600],
                    blurRadius: 5.0,

                  )],
                ),
                child: Text(list[no].A,style: textstyle,)
            ),
          ),
          GestureDetector(
            onTap: (){
              choice.add(2);
              print(choice.last);
              resetTimer();
              nextQues();
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Colors.grey[600],
                    blurRadius: 5.0,

                  )],
                ),
                child: Text(list[no].B,style: textstyle,)
            ),
          ),
          GestureDetector(
            onTap: (){
              choice.add(3);
              print(choice.last);
              resetTimer();
              nextQues();
            },
            child: Container(

                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Colors.grey[600],
                    blurRadius: 5.0,

                  )],
                ),
                child: Text(list[no].C,style: textstyle,)
            ),
          ),
          GestureDetector(
            onTap: (){
              choice.add(4);
              print(choice.last);
              resetTimer();
              nextQues();
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Colors.grey[600],
                    blurRadius: 5.0,

                  )],
                ),
                child: Text(list[no].D,style: textstyle,)
            ),
          ),
          FlatButton(
            padding: EdgeInsets.all( 10),
            //color: Colors.red,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                //margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Colors.grey[600],
                    blurRadius: 5.0,

                  )],
                ),
                child: Text("Explanation",style: textstyle,textAlign: TextAlign.center,)
            ),
            onPressed: (){
              showdialog();
            },
          ),
          FlatButton(
            padding: EdgeInsets.all(10),
            onPressed: (){
                resetTimer();
                nextQues();
              },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              //margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
              child: Text(nextOrFinish, style:  textstyle,textAlign: TextAlign.center,),
            ),
          ),

        ],
      ),
    );
  }

  showdialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Explanation",style: TextStyle(fontSize: 50,color: Colors.grey[200]),),
            backgroundColor: Colors.blue,
            content: Text(exp,style: TextStyle(color: Colors.grey[200],fontSize: 20),),

          );
        }
    );
  }

  void resetTimer(){
    if (_timer != null) {
      _timer.cancel();
      _start = 15;
    }
    startTimer();
  }

  void nextQues(){

    if(nextOrFinish=="Finish"){
      print("no more question");
      //return;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>score(list,choice)));
    }

    setState(() {
      no++;
      print(no);
      print(list[no].D);

      if(list[no].question==null){
        no++;
      }
    });

    if((no+1).toString()==(quescount)){
      print("lastquestion");
      setState(() {
        nextOrFinish="Finish";
      });
    }

  }
}

