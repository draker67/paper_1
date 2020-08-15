import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'score.dart';
import 'dart:async';
import 'loading.dart';

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

class PrimitiveWrapper{
  var value;
  PrimitiveWrapper(this.value);
}

class question extends StatefulWidget {
  String str="";
  String set="";
  question(this.str,this.set);



  @override
  _questionState createState() => _questionState(str,set);
}

class _questionState extends State<question> {
  bool tappedA=false;
  bool tappedB=false;
  bool tappedC=false;
  bool tappedD=false;

  bool loading=true;
  String str="";
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
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            choice.add(5);
            //timer.cancel();
            resetTimer();
            nextQues();
            //startTimer();
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

  _questionState(this.str,this.set);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Firestore.instance.collection("QUIZ").document(str).collection(set).getDocuments().then((snapshot){
      snapshot.documents.forEach((result) {
        if(result.data["A"]!=null)
          {
            list.add(Item(result.data["QUESTION"], result.data["A"], result.data["B"], result.data["C"], result.data["D"],result.data["ANSWER"],result.data["EXPLANATION"]));
          }


        if(result.data.containsKey("COUNT")){
          quescount=result.data["COUNT"];
        }
      });

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
      body: loading?Loading():ListView(
        children: <Widget>[
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
              setState(() {
                tappedA=true;
              });

              Timer(Duration(seconds: 1), (){
                resetTimer();
                nextQues();
                tappedA=false;
              });

            },
            child: Container(
              width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: tappedA?check(1, list[no].ans):Colors.blue,
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


              setState(() {
                tappedB=true;
              });
              Timer(Duration(seconds: 1), (){
                resetTimer();
                nextQues();
                tappedB=false;
              });

            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: tappedB?check(2, list[no].ans):Colors.blue,
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
              setState(() {
                tappedC=true;
              });
              Timer(Duration(seconds: 1), (){
                resetTimer();
                nextQues();
                tappedC=false;
              });
            },
            child: Container(

                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: tappedC?check(3, list[no].ans):Colors.blue,
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
              setState(() {
                tappedD=true;
              });
              Timer(Duration(seconds: 1), (){
                resetTimer();
                nextQues();
                tappedD=false;
              });
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: tappedD?check(4, list[no].ans):Colors.blue,
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
            padding: EdgeInsets.all(10),
            onPressed: (){
              choice.add(5);
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


  Color check(choice,ans){
    if(choice.toString()==ans){
      return Colors.green;
    }
    else{
      return Colors.red;
    }
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
      _start = 30;
    }
    startTimer();
  }

  void nextQues(){

    if(nextOrFinish=="Finish"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>score(list,choice)));
    }

    setState(() {
      no++;

      if(list[no].question==null){
        no++;
      }
    });

    if((no+1).toString()==(quescount)){
      setState(() {
        nextOrFinish="Finish";
      });
    }

  }
}

