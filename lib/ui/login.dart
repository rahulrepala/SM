import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_management/support/back_profile.dart';
import 'package:studio_management/support/below_profile.dart';
import 'package:studio_management/ui/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

 var _password = TextEditingController();
 var _phone = TextEditingController();

 final GlobalKey<ScaffoldState> _sk = GlobalKey<ScaffoldState>();

 @override
void initState(){
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
      key: _sk,
      body: OrientationBuilder(
     builder: (context, orientation) {
     Size size = MediaQuery.of(context).size;
     return SingleChildScrollView(
         child: Container(
          child: Column(
            children: <Widget>[
            Stack(
             children: <Widget>[
                Container(
                     height: size.height*0.6,
                     width: MediaQuery.of(context).size.width,
                     child: CustomPaint(
                       painter: BackProfile(context),
                     ),
                   ),
             
                Container(
                     height: size.height,
                     width: MediaQuery.of(context).size.width,
                     child: CustomPaint(
                       painter: BelowProfile(context),
                     ),
                   ),

               Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[

                   SizedBox(
                    height:size.height*0.34 ,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,20),
                      child: TextFormField(
                        maxLines: 1,
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(15,10,10,10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            hintText: "Phone Number",
                            hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 16.0)),
                             ),
                        ),
                        
                          Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        maxLines: 1,
                        controller: _password,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(15,10,10,10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: "password",
                            hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 16.0)),
                      ),
                    ),

                     Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.fromLTRB(20,30,20,0),
                         child: FlatButton(
                           child: Text(
                             'VERIFY',
                             style: Theme.of(context).textTheme.button,
                           ),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(25),
                           ),
                           padding: const EdgeInsets.all(15),
                           color: Theme.of(context).buttonColor,
                           textColor: Colors.white,
                           onPressed: () async{
                            
                            if(_phone.text.length==10 && _password.text.length!=0){


var url = 'http://test.matha.co.in/api/Client/ClientLogin';
                            var resp = await http.post(
                              url,
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: json.encode(<String, dynamic>{
                               "mobile":_phone.text,
                               "password":_password.text
                              }),
                            );
                         var result = json.decode(resp.body);
                      
                                // 9963867732
                                // 123

                          if(result!=null){
                                  
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('ClientId',result['ClientId']);      
   
                            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                            builder: (context) => Home()),
                            (Route<dynamic> route) => false);
                         
                            }
                            else{

                             _sk.currentState.showSnackBar(SnackBar(
                                          content: Text(
                                            "give correct credentials",
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(12.0),
                                                  topRight:
                                                      Radius.circular(12.0))),
                                          duration: Duration(seconds: 3),
                                          backgroundColor:
                                              Colors.lightBlueAccent,
                                        ));
                            
                            }

                            }else{

                       _sk.currentState.showSnackBar(SnackBar(
                                          content: Text(
                                            "enter all fields",
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(12.0),
                                                  topRight:
                                                      Radius.circular(12.0))),
                                          duration: Duration(seconds: 3),
                                          backgroundColor:
                                              Colors.lightBlueAccent,
                                        ));

                            }

                            


                          },
                         ),
                       ),
                     ],)
                       

                       ],
                     ),
                  ),
                ),

              ],
           )


           ],
         ),
    ),
      );


     },
   ),
 );
  }
}

