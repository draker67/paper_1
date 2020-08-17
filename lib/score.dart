import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget circularQuestion(BuildContext context,String str,Color optionColor){
  return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: optionColor,
            borderRadius: BorderRadius.circular(20)
          ),

          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(20),
          child: Text(str,style: TextStyle(fontSize: 20),)
        );
}

Widget circularAnswer(BuildContext context,String str,Color optionColor){
  return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: optionColor,
          borderRadius: BorderRadius.circular(20)
      ),

      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(20),
      child: Text(str,style: TextStyle(fontSize: 20),)
  );
}

class score extends StatefulWidget {
  List list = [];
  List choice=[];

  score(this.list,this.choice);

  @override
  _scoreState createState() => _scoreState(list,choice);
}

class _scoreState extends State<score> {
  List list = [];
  List choice=[];
  var optionColor=Colors.grey[200];
  bool ans1=false;
  bool ans2=false;
  bool ans3=false;
  bool ans4=false;
  int correct=0;

  _scoreState(this.list,this.choice);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("list");
    print(list[2].A);

  }

  void returnHome(BuildContext context){
    //pop to first screen
    //Navigator.of(context).popUntil((route) => route.isFirst);

    //pop specific count
    int count = 0;
    Navigator.popUntil(context, (route) {
      return count++ == 2;
    });
  }

  Color wrongchoice(opt,i){
    print("opt:"+opt.toString()+" choice: "+choice[i].toString());
    if(opt==choice[i]){
      return Colors.red;
    }
    else{
      return optionColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        returnHome(context);
      },
      child: Scaffold(
        body: ListView.builder(
            itemCount: list.length+1,
            itemBuilder: (BuildContext context, int index) {



              if(index==list.length){

                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: <Widget>[
                        Center(child: Text("Score",style: TextStyle(fontSize: 60,color: Colors.white),),),
                        Center(child: Text("$correct"+"/"+list.length.toString(),style: TextStyle(fontSize: 45,color: Colors.white))),
                      ],
                    )
                  ),
                );
              }

              ans1=false;
              ans2=false;
              ans3=false;
              ans4=false;

              if(list[(index)].ans=="1") {ans1=true;}
              if(list[(index)].ans=="2") {ans2=true;}
              if(list[(index)].ans=="3") {ans3=true;}
              if(list[(index)].ans=="4") {ans4=true;}

              print(index.toString()+"::"+list[(index)].question);
              print(index.toString()+"::"+list[(index)].ans);
              print(index.toString()+"::"+choice[index].toString());
              if(list[(index)].ans==choice[index].toString() && index<list.length){
                correct++;
              }


              return Container(

                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20)
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    circularQuestion(context, list[(index)].question, optionColor),
                    circularAnswer(context, "1. "+list[(index)].A, ans1?Colors.green: wrongchoice(1,index)),
                    circularAnswer(context, "2. "+list[(index)].B, ans2?Colors.green: wrongchoice(2,index)),
                    circularAnswer(context, "3. "+list[(index)].C, ans3?Colors.green: wrongchoice(3,index)),
                    circularAnswer(context, "4. "+list[(index)].D, ans4?Colors.green: wrongchoice(4,index)),
                    circularAnswer(context, "ANS: "+list[(index)].ans, optionColor),
                    circularAnswer(context, "Explanation: "+list[(index)].explanation, optionColor),
                ],
              ));
            }),
      ),
    );


  }


}
