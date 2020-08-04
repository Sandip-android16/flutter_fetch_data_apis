

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dmeo1 extends StatefulWidget{

    demo1 createState()=>demo1();

}

class demo1 extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

        return Scaffold(


          appBar: AppBar(
            title: Text("Demo1"),
          ),
          body: Container(
            alignment: Alignment.center,

            child: Center(

              child: Text("aaaaa"),
            ),
          ),

        );

  }

}