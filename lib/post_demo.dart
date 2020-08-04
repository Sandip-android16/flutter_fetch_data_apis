
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'demo1.dart';

Future<Album> createAlbum(String UserID,String Password) async {
  final http.Response response = await http.get(
    'http://www.ebs-applications.com:2000/api/mobileapp/validatelogin?UserID='+UserID+'&Password='+Password,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    /*body: jsonEncode(<String, String>{
      'UserID': UserID,
      'Password': Password,
    }),*/
  );

  var jsonDate = json.decode(response.body);

  List<Album> user = [];

  for (var i in jsonDate) {

    Album model = new Album(i["LoginStatus"], i["CompanyID"]);

    user.add(model);
  }
  print(user.length);
  print(user.toString());


}

class Album {
  String  LoginStatus="";
  int CompanyID;
  Album(this.LoginStatus, this.CompanyID);
}

class PostDemo extends StatefulWidget {
  PostDemo({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<PostDemo> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _password = TextEditingController();
  var _futureAlbumlist=List<Album>();

  bool IsList=false;


  Future _getuser(String UserId,String Password) async {
    var date = await http.get("http://www.ebs-applications.com:2000/api/mobileapp/validatelogin?UserID="+UserId+"&Password="+Password);
    var jsonDate = json.decode(date.body);

    for (var i in jsonDate) {
      Album model = new Album(i["LoginStatus"], i["CompanyID"],
      );

        if(i["LoginStatus"] == "true"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dmeo1()),
          );
        }
        else{
          print("Error");

        }


      setState(() {
        _futureAlbumlist.add(model);
      });
    }
    print(_futureAlbumlist.length);
  }

  @override
  void initState() {
    super.initState();
    IsList = true;
    _getuser(_controller.text,_password.text);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
  resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Fetch Data Get Method"),
      ),
      body: Container(


        height: double.maxFinite,
        width: double.maxFinite,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Enter Title'),
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(hintText: 'Enter password'),
            ),
            RaisedButton(
              child: Text('Create Data'),
              onPressed: () {
                setState(() {
                  _getuser(_controller.text,_password.text);
                });
              },
            ),

            Expanded(
              child: _futureAlbumlist.isNotEmpty?   ListView.builder(
                  itemCount: _futureAlbumlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child:  ListTile(
                        title: Text(_futureAlbumlist[index].LoginStatus),
                        subtitle:  Text(_futureAlbumlist[index].CompanyID.toString()),
                        onTap: () {
                        },
                      ),
                    );
                  }):Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ],
                ),
              ),

            )

          ],
        ),


      ),
    );
  }
}
