import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DueList extends StatefulWidget {
  @override
  _DueListState createState() => _DueListState();
}

class _DueListState extends State<DueList> {

  List Due=[];
  int load=0;

  @override
  void initState() {
   _load();
      super.initState();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
}

@override
dispose(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:  Text('Due List',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor:  Color(0xfff2f7ff),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
     body:load==1? ListView.builder
              (
                itemCount: Due.length,
                itemBuilder: (BuildContext ctxt, int Index) {
                  return Card(
                   child: ListTile(
                      leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(Icons.attach_money,size: 20,),
                    ),
                      title: Text(Due[Index]['CustomerMobile'].toString()),
                      subtitle: Text(Due[Index]['CustomerName']),
                        trailing: Text(Due[Index]['DueAmount'].toString()),
                     ),
                   );
                }
            ):Container(child: Text("Loading..."),)
 
       
    );
  }

  void _load() async{
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
        int id = prefs.getInt('ClientId');


        var url = 'http://test.matha.co.in/api/Order/DueList?clientId='+id.toString();
        var resp = await http.post(url);
        var result = json.decode(resp.body);
        print(result);

         setState(() {
           Due=result;
           load=1;
         });

  }

}