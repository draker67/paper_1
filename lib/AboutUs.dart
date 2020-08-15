import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {

  var textStyle=TextStyle(fontSize: 40, color: Colors.white,fontWeight: FontWeight.bold);
  var textStylename=TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text("DEVELOPER",style: textStyle ,)
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('lib/assets/sarath.jpeg'),
                    fit: BoxFit.fill
                ),
              ),
            ),
            Container(
                //margin: EdgeInsets.only(top: 40),
                child: Text("SARATH RAVEENDRAN",style: textStylename ,)
            ),
            Container(
                margin: EdgeInsets.only(top: 40),
                child: Text("ADMIN",style: textStyle ,)
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('lib/assets/greeshma.jpeg'),
                    fit: BoxFit.fill
                ),
              ),
            ),
            Container(
              //margin: EdgeInsets.only(top: 40),
                child: Text("GREESHMA RAVEENDRAN",style: textStylename ,)
            ),
          ],
        ),
      ),
    );
  }
}
