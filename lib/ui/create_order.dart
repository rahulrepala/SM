import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_management/ui/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class NewOrder extends StatefulWidget {
  final List n;
  NewOrder(this.n);

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  
 var _name = TextEditingController();
 var _phone = TextEditingController();
 var _address = TextEditingController();
 
 var _gOthers = TextEditingController();
 var _gAmount = TextEditingController();
 var _gDesc = TextEditingController();
 var _gTotal = TextEditingController();
 var _gDisc = TextEditingController();
 var _gPay = TextEditingController();
 var _gAdvance = TextEditingController();
 var _gDue = TextEditingController();


List<TextEditingController> _vdate = [];
 List<TextEditingController> _vamount = [];
 List<TextEditingController> _alprice = [];
 List<TextEditingController> _alqty = [];
 List<TextEditingController> _alamount = [];
 
 List<TextEditingController> _fdate = [];
 List<TextEditingController> _faddress = [];
 List<TextEditingController> _famount1 = [];
 List<TextEditingController> _famount2 = [];

 bool checkedValue=false;
 bool checkedAlbum=false;

 bool submitted=false;

 bool uncheckall=true;

 List<String> sheetTypes=[];
 List<String> dropItems =[];
 List<double> values=[];

List<String> function=[];
List<String> functionItems =['Marriage','formalities','Reception','Birthday'];

List<String> fdec=[];
List<String> fdecItems =['Marriage Set','Stage','Others'];

List prices=[];
int load=0;
int orderId=0;
List fid=[];
List vid=[];
List sid=[];

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



  final GlobalKey<ScaffoldState> _sk = GlobalKey<ScaffoldState>();

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _sk,
      appBar: AppBar(
        elevation: 0,
        title:  Text(' New Order',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor:  Color(0xfff2f7ff),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child:load==1? Column(
            children: <Widget>[
                
               Padding(
                      padding: const EdgeInsets.fromLTRB(20,10,20,20),
                      child: TextFormField(
                        maxLines: 1,
                        enabled: uncheckall,
                        controller: _name,
                        keyboardType: TextInputType.text,
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
                            labelText: 'Name',
                            hintText: "Name",
                            hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 16.0)),
                             ),
                        ),
                        
                          Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,20),
                      child: TextFormField(
                        maxLines: 1,
                        controller: _phone,
                        enabled: uncheckall,
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
                            labelText: 'Phone',
                            border: OutlineInputBorder(),
                            hintText: "phone",
                            hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 16.0)),
                      ),
                    ),  

                   Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                        maxLines: 1,
                        controller: _address,
                        enabled: uncheckall,
                        keyboardType: TextInputType.text,
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
                            labelText: 'Address',
                            border: OutlineInputBorder(),
                            hintText: "Address",
                            hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 16.0)),
                      ),
                    ), 

               Padding(
                 padding: const EdgeInsets.fromLTRB(20,0,20,8),
                 child: Card(
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    
                    Container(
                      height:_fdate.length*size.height*0.286,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(8,8,8,8),
                          itemCount: _fdate.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: size.height*0.286,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                             SizedBox(height: size.height*0.01,), 
                             Row(
                                children: <Widget>[
                                GestureDetector(
                                    onTap: (){
                                           setState(() {

                                if(index!=0){

                                      _faddress.removeAt(index);
                                      _famount1.removeAt(index);
                                      _famount2.removeAt(index);
                                      _fdate.removeAt(index);
                                      function.removeAt(index);
                                      fdec.removeAt(index);
                                      if(fid.length>index){
                                        fid.removeAt(index);
                                      }

                                 }
                   
                                });
                             },
                        child: Icon(Icons.delete,size: 16,),
                       ),           
                                 Expanded(
                                  child: _fdate[index].text == ''
                     ? Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: GestureDetector(
                         onTap: () {
                           _selectDate(index,1);
                         },
                         child: Container( 
                          decoration: BoxDecoration(
                           border: Border.all(
                           color: Colors.grey[500],
                           width: 1,
                          ),
                           borderRadius: BorderRadius.circular(5),
                         ),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Center(
                               child: Text(
                                 'Date',
                                 style: TextStyle(
                                   fontSize: 16,
                                   color: Colors.grey[500]
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ),
                     )
                     : Padding(
                                 padding: const EdgeInsets.fromLTRB(8,0,5,8),
                                 child: SizedBox(
                                   height: 40,
                                   child: TextFormField(
                                   maxLines: 1,
                                   enabled: uncheckall,
                                   controller: _fdate[index],
                                   decoration: InputDecoration(
                                     contentPadding: EdgeInsets.fromLTRB(15,10,10,10),
                                     enabledBorder: OutlineInputBorder(
                                     borderSide: BorderSide(
                                         color: Colors.grey, width: 1.0),
                                     borderRadius:
                                         BorderRadius.all(Radius.circular(10.0)),
                                        ),
                                        border: OutlineInputBorder(),
                                        hintText: "date",
                                        hintStyle:
                                        TextStyle(color: Colors.black26, fontSize: 16.0)),
                                     onChanged: (t){

                                     },
                                   
                               ),)
                             ),
                          ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(25,0,5,8),
                                    child: SizedBox(
                                         height: 40,
                                         width: size.width*0.28,
                                         child: TextFormField(
                                        maxLines: 1,
                                        controller: _faddress[index],
                                        enabled: uncheckall,
                                        keyboardType: TextInputType.text,
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
                                            hintText: "address",
                                            hintStyle:
                                            TextStyle(color: Colors.black26, fontSize: 16.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                ],
                              ),



                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: <Widget>[
                                 
                                 
                                   Expanded(
                                     child: Padding(
                                       padding: const EdgeInsets.fromLTRB(8,0,5,8),
                                       child: SizedBox(
                                            height: 40,
                                            width: size.width*0.35,
                                            child: new DropdownButton<String>(
                                              hint:function[index]!=""?Text(function[index]):Text('Function'),
                                              items: functionItems.map((String value) {
                                                return new DropdownMenuItem<String>(
                                                value: value,
                                                child: new Text(value),
                                                );
                                               }).toList(),
                                              onChanged: (String val) {
                                                setState(() {
                                                  function[index]=val;
                                                });
                                              },
                                           )
                                       ),
                                     ),
                                   ),


                                   Expanded(
                                     child: Padding(
                                       padding: const EdgeInsets.fromLTRB(25,0,5,8),
                                       child: SizedBox(
                                            height: 40,
                                            width: size.width*0.28,
                                            child: TextFormField(
                                           maxLines: 1,
                                           controller: _famount1[index],
                                           enabled: uncheckall,
                                           keyboardType: TextInputType.number,
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
                                               hintText: "amount",
                                               hintStyle:
                                               TextStyle(color: Colors.black26, fontSize: 16.0)),
                                         ),
                                       ),
                                     ),
                                   ),

                                 ],
                               ),


                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: <Widget>[


                                   Expanded(
                                     child: Padding(
                                       padding: const EdgeInsets.fromLTRB(8,0,5,8),
                                       child: SizedBox(
                                            height: 40,
                                            width: size.width*0.35,
                                            child: new DropdownButton<String>(
                                              hint:fdec[index]!=""?Text(fdec[index]):Text('Decoration'),
                                              items: fdecItems.map((String value) {
                                                return new DropdownMenuItem<String>(
                                                value: value,
                                                child: new Text(value),
                                                );
                                               }).toList(),
                                              onChanged: (String val) {
                                                setState(() {
                                                  fdec[index]=val;
                                                });
                                              },
                                           )
                                       ),
                                     ),
                                   ),


                                   Expanded(
                                     child: Padding(
                                       padding: const EdgeInsets.fromLTRB(25,0,5,8),
                                       child: SizedBox(
                                            height: 40,
                                            width: size.width*0.28,
                                            child: TextFormField(
                                           maxLines: 1,
                                           enabled: uncheckall,
                                           controller: _famount2[index],
                                           keyboardType: TextInputType.number,
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
                                               hintText: "amount",
                                               hintStyle:
                                               TextStyle(color: Colors.black26, fontSize: 16.0)),
                                         ),
                                       ),
                                     ),
                                   ),

                                 ],
                               ),

                   SizedBox(height: size.height*0.01,),
                  
                    Padding(
                    padding: const EdgeInsets.fromLTRB(8,12,8,12),
                    child: Container(height: 1,color: Colors.grey,),
                  ),

                                ],
                              )
                            );
                          }
                      ),
                    ),

                    
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,0,15,8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)),
                          onPressed: (){
                            setState(() {
                               _faddress.add(TextEditingController());
                               _famount1.add(TextEditingController());
                               _famount2.add(TextEditingController());
                               _fdate.add(TextEditingController());
                               function.add("");
                               fdec.add("");

                              });
                          },
                          color: Colors.white,
                          textColor: Colors.red,
                          child: Text("Add More",
                              style: TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                    )

                   ],
                 ),
               ),
              ),
                    
             CheckboxListTile(
                title: Text(
                  "Video",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                value: checkedValue,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (newValue) {
                  setState(() {
                    if(newValue==true){
                      _vamount.add(TextEditingController());
                      _vdate.add(TextEditingController());
                    }
                    else{
                      _vdate.clear();
                      _vamount.clear();
                      vid.clear();
                    }
                    checkedValue = newValue;
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
      
                 Center(
                child: Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: checkedValue,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,8),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: _vdate.length*size.height*0.13,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(8),
                                  itemCount: _vdate.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      height: size.height*0.13,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: <Widget>[
                                        Row(
                                        children: <Widget>[
                                        IconButton(
                                          onPressed: (){
                                            setState(() {
                                          if(index!=0){
                                               _vdate.removeAt(index);
                                               _vamount.removeAt(index);
                                                if(vid.length>index){
                                                     vid.removeAt(index);
                                                   }
                                                 }                  
                                          });
                                          },
                                          icon: Icon(Icons.delete),
                                          ),

                                          Expanded(
                                            child: _vdate[index].text == ''
                               ? Padding(
                                 padding: const EdgeInsets.fromLTRB(8,0,5,8),
                                 child: GestureDetector(
                                   onTap: () {
                                     _selectDate(index,2);
                                   },
                                   child: Container( 
                                    decoration: BoxDecoration(
                                     border: Border.all(
                                     color: Colors.grey[500],
                                     width: 1,
                                    ),
                                     borderRadius: BorderRadius.circular(5),
                                   ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Center(
                                         child: Text(
                                           'Date',
                                           style: TextStyle(
                                             fontSize: 16,
                                             color: Colors.grey[500]
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                 ),
                               )
                               : Padding(
                                 padding: const EdgeInsets.fromLTRB(8,0,5,8),
                                 child: SizedBox(
                                   height: 40,
                                   child: TextFormField(
                                   maxLines: 1,
                                   enabled: uncheckall,
                                   controller: _vdate[index],
                                   decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.fromLTRB(15,10,10,10),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey, width: 1.0),
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(10.0)),
                                                      ),
                                                      border: OutlineInputBorder(),
                                                      hintText: "date",
                                                      hintStyle:
                                                      TextStyle(color: Colors.black26, fontSize: 16.0)),
                                   onChanged: (t){

                                   },
                                   
                                 ),)
                               ),
                          ),

                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(10,0,5,8),
                                              child: SizedBox(
                                                   height: 40,
                                                   width: size.width*0.28,
                                                   child: TextFormField(
                                                  maxLines: 1,
                                                  enabled: uncheckall,
                                                  controller: _vamount[index],
                                                  keyboardType: TextInputType.number,
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
                                                      hintText: "amount",
                                                      hintStyle:
                                                      TextStyle(color: Colors.black26, fontSize: 16.0)),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),


              SizedBox(height: size.height*0.01,),
                  


                 Padding(
                    padding: const EdgeInsets.fromLTRB(8,12,8,12),
                    child: Container(height: 1,color: Colors.grey,),
                  ),


                                        ],
                                      ),
                                    );
                                  }
                              ),
                            ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0,0,15,8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)),
                                  onPressed: (){
                                    setState(() {
                                      _vdate.add(TextEditingController());
                                      _vamount.add(TextEditingController());
                                      });
                                  },
                                  color: Colors.white,
                                  textColor: Colors.red,
                                  child: Text("Add More",
                                      style: TextStyle(fontSize: 14)),
                                  ),
                                ],
                              ),
                            )

                           ],
                         ),
                       ),
                     ))),


         CheckboxListTile(
                title: Text(
                  "Album",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                value: checkedAlbum,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (newValue) {
                  setState(() {
                    if(newValue==true){
                      _alamount.add(TextEditingController());
                      _alprice.add(TextEditingController());
                      _alqty.add(TextEditingController());
                      sheetTypes.add("");
                      prices.add("");
                    }
                    else{
                      _alprice.clear();
                      _alqty.clear();
                     _alamount.clear();
                     sheetTypes.clear();
                     prices.clear();
                     sid.clear();
                    }
                    checkedAlbum = newValue;
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),

              
         Center(
                child: Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: checkedAlbum,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,8),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: _alprice.length*size.height*0.2,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(8),
                                  itemCount: _alprice.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                     height: size.height*0.2,
                                      child: Column(
                                        children: <Widget>[
                                           Row(
                                        children: <Widget>[
                                    IconButton(
                                         icon: Icon(
                                           Icons.delete,
                                           size: 16,
                                         ),
                                         onPressed: () {
                                           setState(() {
                                             if(index!=0){
                                              _alamount.removeAt(index);
                                              _alprice.removeAt(index);
                                              _alqty.removeAt(index);
                                              sheetTypes.removeAt(index);
                                              prices.removeAt(index);
                                            if(sid.length>index){
                                               sid.removeAt(index);
                                              }
                                             }
                                             
                                           });
                                         },
                                       ),

                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5,0,5,8),
                                              child: SizedBox(
                                                   height: 40,
                                                   width: size.width*0.66,
                                                   child: new DropdownButton<String>(
                                                     hint:sheetTypes[index]!=""?Text(sheetTypes[index]):Text('Sheet Type'),
                                                     items: dropItems.map((String value) {
                                                       return new DropdownMenuItem<String>(
                                                       value: value,
                                                       child: new Text(value),
                                                       );
                                                      }).toList(),
                                                     onChanged: (String val) {
                                                       setState(() {
                                                         sheetTypes[index]=val;
                                                         int j= dropItems.indexOf(val);
                                                         prices[index]=values[j].toString();
                                                         _alprice[index].text=values[j].toString();
                                                       });
                                                     },
                                                  )
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),

                                      Row(
                                        children: <Widget>[
                                       Flexible(child: Padding(
                                         padding: const EdgeInsets.fromLTRB(12,0,5,8),
                                         child: SizedBox(
                                                   height: 40,
                                                   width: size.width*0.22,
                                                   child: TextFormField(
                                                  maxLines: 1,
                                                  enabled: uncheckall,
                                                  controller: _alprice[index],
                                                  onChanged: (String n) async{
                                                   if(n==""){
                                                    _alamount[index].text="0";
                                                  }
                                                  if(_alqty[index].text.toString()!=""){
                                                    var m=num.parse(_alqty[index].text);
                                                    int h=int.parse(n);
                                                    var k=m*h;
                                                    _alamount[index].text=k.toString();
                                                  }
                                                  },
                                                  keyboardType: TextInputType.number,
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
                                                      hintText: "price",
                                                      hintStyle:
                                                      TextStyle(color: Colors.black26, fontSize: 16.0)),
                                                ),
                                              ),
                                       )),

                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5,0,5,8),
                                              child: SizedBox(
                                                   height: 40,
                                                   width: size.width*0.22,
                                                   child: TextFormField(
                                                  maxLines: 1,
                                                  enabled: uncheckall,
                                                  controller: _alqty[index],
                                                  onChanged: (String n) async{
                                                   if(n==""){
                                                    _alamount[index].text="0";
                                                  }
                                                  if(_alprice[index].text.toString()!=""){
                                                    var m=num.parse(_alprice[index].text);
                                                    int h=int.parse(n);
                                                    var k=m*h;
                                                    _alamount[index].text=k.toString();
                                                  }
                                                  },
                                                  keyboardType: TextInputType.number,
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
                                                      hintText: "quantity",
                                                      hintStyle:
                                                      TextStyle(color: Colors.black26, fontSize: 16.0)),
                                                ),
                                              ),
                                            ),
                                          ),


                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5,0,5,8),
                                              child: SizedBox(
                                                   height: 40,
                                                   width: size.width*0.22,
                                                   child: TextFormField(
                                                  maxLines: 1,
                                                  enabled: false,
                                                  controller: _alamount[index],
                                                  keyboardType: TextInputType.number,
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
                                                      hintText: "amount",
                                                      hintStyle:
                                                      TextStyle(color: Colors.black26, fontSize: 16.0)),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                            

                                       
                 Padding(
                    padding: const EdgeInsets.fromLTRB(8,12,8,0),
                    child: Container(height: 1,color: Colors.grey,),
                  ),            

                                        ],
                                      )
                                    );
                                  }
                              ),
                            ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0,0,15,8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)),
                                  onPressed: (){
                                    setState(() {
                                      _alprice.add(TextEditingController());
                                      _alqty.add(TextEditingController());
                                      _alamount.add(TextEditingController());
                                      sheetTypes.add("");
                                      prices.add("");
                                      });
                                  },
                                  color: Colors.white,
                                  textColor: Colors.red,
                                  child: Text("Add More",
                                      style: TextStyle(fontSize: 14)),
                                  ),
                                ],
                              ),
                            )

                           ],
                         ),
                       ),
                     ))),

        SizedBox(height: 10,),


        Row(
           children: <Widget>[

             
               Flexible(
                     child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,5,8),
                        child: TextFormField(
                          maxLines: 1,
                          controller: _gOthers,
                          enabled: uncheckall,
                          keyboardType: TextInputType.text,
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
                              labelText: 'Others',
                              hintText: "others",
                              hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 16.0)),
                               ),
                          ),
               ),
                        
                          Flexible(
                         child: Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,5,8),
                      child: TextFormField(
                        maxLines: 1,
                        enabled: uncheckall,
                        controller: _gAmount,
                        keyboardType: TextInputType.number,
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
                              labelText: 'Amount',
                              border: OutlineInputBorder(),
                              hintText: "Amount",
                              hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 16.0)),
                      ),
                    ),
                          ),  

                   
             
             
             ],
          ),

        SizedBox(height: 10,),
        Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,5,8),
                        child: TextFormField(
                          maxLines: 1,
                          controller: _gDesc,
                          enabled: uncheckall,
                          keyboardType: TextInputType.text,
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
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                              hintText: "Description",
                              hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 16.0)),
                        ),
                      ),
                   
        SizedBox(height: 10,),
                 CheckboxListTile(
                title: Text(
                  "Submitted all details",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                value: submitted,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (newValue) {
                  setState(() {
                    double total=0;
                    int label=0;
                    if(newValue==true){
                   _onLoading();  
                    for(int i=0;i<_fdate.length;i++){
                         if(function[i].toString()!=""&&_famount1[i].text.toString()!=""&&
                             fdec[i].toString()!="" && _famount2[i].text.toString()!="" &&  _fdate[i].toString()!=""&&
                             _faddress[i].text.toString()!=""
                         ){
                           
                            total=total+num.parse(_famount1[i].text.toString())+num.parse(_famount2[i].text.toString());
                         }
                         else{
                           label=1;
                         }
                    }
                    for(int i=0;i<_vdate.length;i++){
                       if(_vamount[i].text.toString()!="" && _vdate[i].text.toString()!=""){
                             total=total+num.parse(_vamount[i].text.toString());
                       }
                       else{
                         label=2;
                       }
                    }
                    for(int i=0;i<_alprice.length;i++){
                       if(sheetTypes[i].toString()!="" && _alprice[i].text.toString()!="" 
                              || _alqty.toString()!="" && _alamount.toString()!=""){

                             total=total+num.parse(_alamount[i].text.toString());
                       }
                       else{
                         label=3;
                       }
                    }
                     
                    if(label==0){
                      if(_gAmount.text.toString()!=""){
                        total=total+num.parse(_gAmount.text);
                      }
                      uncheckall=false;
                      Navigator.pop(context);
                      submitted = newValue;
                      _gTotal.text=total.toString();
                    }
                    else{
                      String h;
                        if(label==1){
                          h="Enter Function Details Properly";
                        }
                        else if(label==2){
                           h="Enter Video Details Properly";
                        }
                        else{
                           h="Enter Album Details Properly";
                        }
                       uncheckall=true;
                       Navigator.pop(context);
                        _sk.currentState.showSnackBar(SnackBar(
                             content: Text(
                                   h,
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
                      
                    }
                    else{
                       submitted = newValue;
                      _gTotal.text="0";
                      uncheckall=true;
                    }
                    
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),

        SizedBox(height: 10,),

        Row(
           children: <Widget>[

             
               Flexible(
                     child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,5,8),
                        child: TextFormField(
                          maxLines: 1,
                          controller: _gTotal,
                          enabled: false,
                          keyboardType: TextInputType.number,
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
                              labelText: 'Total ',
                              hintText: "total",
                              hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 16.0)),
                               ),
                          ),
               ),
                        
                          Flexible(
                         child: Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,5,8),
                      child: TextFormField(
                        maxLines: 1,
                        controller: _gDisc,
                        keyboardType: TextInputType.number,
                        onChanged: (String n) async{
                          if(n==""){
                             _gPay.text="0";
                               }
                          if(n!="" && _gTotal.text.toString()!=""){
                              var m=num.parse(_gTotal.text);
                              int h=int.parse(n);
                              var k=m-h;
                              _gPay.text=k.toString();
                             }
                           },
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
                              labelText: 'Discount',
                              border: OutlineInputBorder(),
                              hintText: "discount",
                              hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 16.0)),
                      ),
                    ),
                          ),  

                   Flexible(
                        child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,5,8),
                        child: TextFormField(
                          maxLines: 1,
                          controller: _gPay,
                          enabled: false,
                          keyboardType: TextInputType.number,
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
                              labelText: 'Payable',
                              border: OutlineInputBorder(),
                              hintText: "payable",
                              hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 16.0)),
                        ),
                      ),
                   ),
             
             
             ],
          ),

          
          SizedBox(height: 10,),


        Row(
           children: <Widget>[

             
               Flexible(
                     child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,5,8),
                        child: TextFormField(
                          maxLines: 1,
                          controller: _gAdvance,
                           onChanged: (String n) async{
                          if(n==""){
                             _gDue.text="0";
                               }
                          if(n!="" && _gPay.text.toString()!=""){
                              var m=num.parse(_gPay.text);
                              int h=int.parse(n);
                              var k=m-h;
                              _gDue.text=k.toString();
                             }
                           },
                          keyboardType: TextInputType.number,
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
                              labelText: 'Advance',
                              hintText: "advance",
                              hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 16.0)),
                               ),
                          ),
               ),
                        
                          Flexible(
                         child: Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,5,8),
                      child: TextFormField(
                        maxLines: 1,
                        controller: _gDue,
                        enabled: false,
                        keyboardType: TextInputType.number,
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
                              labelText: 'Due',
                              border: OutlineInputBorder(),
                              hintText: "Due",
                              hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 16.0)),
                      ),
                    ),
                          ),  

             
             ],
          ),


                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.fromLTRB(20,30,20,0),
                         child: FlatButton(
                           child: Text(
                             'SUBMIT',
                             style: Theme.of(context).textTheme.button,
                           ),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(25),
                           ),
                           padding: const EdgeInsets.all(15),
                           color: Theme.of(context).buttonColor,
                           textColor: Colors.white,
                           onPressed: () async {
                            int checked1=0;
                            int checked2=0;
                            int checked3=0;
                            int checked4=0;

                            _onLoading();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            int id = prefs.getInt('ClientId');

                            var date = new DateTime.now().toString();
  
                            var dateParse = DateTime.parse(date);
 
                            var formattedDate = "${dateParse.year}-${dateParse.month}-${dateParse.day}";
                             
                              if(_phone.text.toString().length==10){
                                checked1=1;
                              }else{
                                   Navigator.of(context).pop();
                                  _sk.currentState.showSnackBar(SnackBar(
                                          content: Text(
                                            "Enter Phone Number Properly",
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

                if(_name.text.toString()!=""&& _address.text.toString()!="" &&_gTotal.text.toString()!=""
                         && _gPay.text.toString()!="" && _gDue.text.toString()!="" &&checked1==1 &&submitted==true){

                          List func=[];
                          for(int i=0;i<_fdate.length;i++){
                           
                          
                             if(fid.length>i){
                             func.add(
                              {
                                "Ofid":fid[i],
                                "functions": function[i].toString(),
                                "famount": num.parse(_famount1[i].text.toString()),
                                "decoration": fdec[i].toString(),
                                "damount": num.parse(_famount2[i].text.toString()),
                                "date":  _fdate[i].text.toString(),
                                "address": _faddress[i].text.toString(),
                              }
                            );
                            }else{

                             func.add(
                               {
                                "functions": function[i].toString(),
                                "famount": num.parse(_famount1[i].text.toString()),
                                "decoration": fdec[i].toString(),
                                "damount": num.parse(_famount2[i].text.toString()),
                                "date":  _fdate[i].text.toString(),
                                "address": _faddress[i].text.toString(),
                              }
                            );
                            }


                            }
                            
                            
                          

                        List vid=[];
                          for(int i=0;i<_vdate.length;i++){
                          
                          if(vid.length>i){
                          vid.add(
                             {
                                "OvId":vid[i],
                                "date": _vdate[i].text.toString(),
                                "amount": num.parse(_vamount[i].text.toString())
                              }
                            );
                          }else{

                            vid.add(
                             {
                                "date": _vdate[i].text.toString(),
                                "amount": num.parse(_vamount[i].text.toString())
                              }
                            );
                          }

                          } 
                                                     

                        List alb=[];
                          for(int i=0;i<_alprice.length;i++){

                              if(sid.length>i){
                             
                            alb.add(
                              {
                                "OsId":sid[i],
                                "sheetType": sheetTypes[i].toString(),
                                "price": num.parse(_alprice[i].text.toString()),
                                "quantity": num.parse(_alqty[i].text.toString()),
                                "amount": num.parse(_alamount[i].text.toString()),
                              }
                            );

                           }else{
                          
                             alb.add(
                              {
                                "sheetType": sheetTypes[i].toString(),
                                "price": num.parse(_alprice[i].text.toString()),
                                "quantity": num.parse(_alqty[i].text.toString()),
                                "amount": num.parse(_alamount[i].text.toString()),
                              }
                            );

                           }

                           }                           
                            
                          

                            var url = 'http://test.matha.co.in/api/Order/CreateOrder';
                            var resp = await http.post(
                              url,
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body:widget.n.length==0?
                               json.encode(<String, dynamic>{
                               "clientId": id,
                               "orderDate": formattedDate.toString(),
                               "customerName": _name.text.toString(),
                               "customerMobile": num.parse(_phone.text.toString()),
                               "customerAddress": _address.text.toString(),
                               "functions": "Yes",
                               "video": checkedValue.toString()=="true"?"Yes":"No",
                               "sheets": checkedAlbum.toString()=="true"?"Yes":"No",
                               "others": _gOthers.text.toString(),
                               "amount": num.parse(_gAmount.text.toString()!=""?_gAmount.text.toString():"0"),
                               "description": _gDesc.text.toString(),
                               "totalAmount":num.parse(_gTotal.text.toString()) ,
                               "discountAmount": num.parse(_gDisc.text.toString()),
                               "payableAmount": num.parse(_gPay.text.toString()),
                               "paidAmount": num.parse(_gAdvance.text.toString()),
                               "dueAmount": num.parse(_gDue.text.toString()),
                               "psOrderFunctions": func,
                               "psOrderSheets": alb,
                               "psOrderVideo": vid,
                               }
                              ):
                              json.encode(<String, dynamic>{ 
                               "orderId":orderId,
                               "clientId": id,
                               "orderDate": formattedDate.toString(),
                               "customerName": _name.text.toString(),
                               "customerMobile": num.parse(_phone.text.toString()),
                               "customerAddress": _address.text.toString(),
                               "functions": "Yes",
                               "video": checkedValue.toString()=="true"?"Yes":"No",
                               "sheets": checkedAlbum.toString()=="true"?"Yes":"No",
                               "others": _gOthers.text.toString(),
                               "amount": num.parse(_gAmount.text.toString()),
                               "description": _gDesc.text.toString(),
                               "totalAmount":num.parse(_gTotal.text.toString()) ,
                               "discountAmount": num.parse(_gDisc.text.toString()),
                               "payableAmount": num.parse(_gPay.text.toString()),
                               "dueAmount": num.parse(_gDue.text.toString()),
                               "psOrderFunctions": func,
                               "psOrderSheets": alb,
                               "psOrderVideo": vid,
                               }
                              ),
                            );
                            var result = json.decode(resp.body);  
                            print(result.toString());  
                            if(result.toString()=="New Order Placed Successfully" && widget.n.length==0){

                             Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                            builder: (context) => Home()),
                            (Route<dynamic> route) => false);
                 
                            }
                            else if(result.toString()=="Order Updated Successfully"){

                             Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                            builder: (context) => Home()),
                            (Route<dynamic> route) => false);
                 
                            }
                            else{
                                Navigator.pop(context);
                             _sk.currentState.showSnackBar(SnackBar(
                                          content: Text(
                                            "Some Problem Submit again with correct details",
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


                             }
                             else if(checked1==1){


                                Navigator.pop(context);
                             _sk.currentState.showSnackBar(SnackBar(
                                          content: Text(
                                            "Enter All Details Properly",
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
                     ],),



                 SizedBox(height: 10,),


             ],
           ):Center(child: Text('Loading...')),
          ) ,
         ),
      );
  }


       _selectDate(index,n) async {
      
              DateTime picked = await showDatePicker(
              context: context,
              initialDate: new DateTime.now(),
              firstDate: new DateTime.now(),
              lastDate: new DateTime(2050),
              builder: (BuildContext context, Widget child) {
               return Theme(
                    data: ThemeData.light().copyWith(
                    primaryColor: Theme.of(context).primaryColor,
                    accentColor: Theme.of(context).primaryColor,
                    colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
                    buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.primary
                  ),
                ),
                child: child,
                 );
                }
               );
              if (picked != null) {
               setState(() => {
                 if(n==1){
                  _fdate[index].text = picked.toString().substring(0,10)
                 }
                 else{
                   _vdate[index].text = picked.toString().substring(0,10)
                 }
               });
               }
            }

void _load() async{

   SharedPreferences prefs = await SharedPreferences.getInstance();
   int id = prefs.getInt('ClientId');
 
   var url = 'http://test.matha.co.in/api/Sheet/Sheets?clientId='+id.toString();
   var resp = await http.get(url);
   var result = json.decode(resp.body);
    setState(() {
       for(int i=0;i<result.length;i++){
         values.add(result[i]['Price']);
         dropItems.add(result[i]['SheetType']);
       }
     });
  // print(result);

    _faddress.add(TextEditingController());
    _famount1.add(TextEditingController());
    _famount2.add(TextEditingController());
    _fdate.add(TextEditingController());
    function.add("");
    fdec.add("");
   if(widget.n.length!=0){
     print(widget.n);
     List m=widget.n;
     _name.text=m[0]['CustomerName'];
     _phone.text=m[0]['CustomerMobile'].toString();
     _address.text=m[0]['CustomerAddress'];
     _gOthers.text=m[0]['Others'];
     _gAmount.text=m[0]['Amount'].toString();
     _gDesc.text=m[0]['Description'];
     _gTotal.text=m[0]['TotalAmount'].toString();
     _gDisc.text=m[0]['DiscountAmount'].toString();
     _gPay.text=m[0]['PayableAmount'].toString();
     _gAdvance.text=m[0]['PaidAmount'].toString();
     _gDue.text=m[0]['DueAmount'].toString();
     if(m[0]['Functions']=='Yes'){
       List fn=m[0]['PsOrderFunctions'];
       for(int i=0;i<fn.length;i++){
         
          setState(() {

          fdec[i]=fn[i]['Decoration'];
          function[i]=fn[i]['Functions'];
          _faddress[i].text=fn[i]['Functions'];
          _famount1[i].text=fn[i]['Famount'].toString();
          _famount2[i].text=fn[i]['Damount'].toString();
          _fdate[i].text=fn[i]['Date'].toString().substring(0,10);   
          fid.add(fn[i]['Ofid']);
          });

          _faddress.add(TextEditingController());
          _famount1.add(TextEditingController());
          _famount2.add(TextEditingController());
          _fdate.add(TextEditingController());
          function.add("");
          fdec.add("");
       }


      _faddress.removeAt(fn.length);
      _famount1.removeAt(fn.length);
      _famount2.removeAt(fn.length);
      _fdate.removeAt(fn.length);
      function.removeAt(fn.length);
      fdec.removeAt(fn.length);

     }
    if(m[0]['Video']=='Yes'){
       setState(() {
         checkedValue=true;
       });
       List vd=m[0]['PsOrderVideo'];
       for(int i=0;i<vd.length;i++){
         
          _vamount.add(TextEditingController());
          _vdate.add(TextEditingController());

          setState(() {
          _vamount[i].text=vd[i]['Amount'].toString();
          _vdate[i].text=vd[i]['Date'].toString().substring(0,10);  
          vid.add(vd[i]['Ovid']); 
          });
         
       }

     }

     if(m[0]['Sheets']=='Yes'){
       setState(() {
         checkedAlbum=true;
       });
       List alb=m[0]['PsOrderSheets'];
       for(int i=0;i<alb.length;i++){

            _alamount.add(TextEditingController());
            _alprice.add(TextEditingController());
            _alqty.add(TextEditingController());
            sheetTypes.add("");
            prices.add("");

          setState(() {
          _alamount[i].text=alb[i]['Amount'].toString();
          _alprice[i].text=alb[i]['Price'].toString();
          _alqty[i].text=alb[i]['Quantity'].toString();
          sheetTypes[i]= alb[i]['SheetType'];
          prices[i]=alb[i]['Price'];
          sid.add(alb[i]['Osid']); 
          });

       }

     }

    setState(() {
       load=1;
       orderId=m[0]['OrderId'];
     });
   }
   else{
     setState(() {
       load=1;
     });
   }

  }


  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                new Text("    Loading..."),
              ],
            ),
          ),
        );
      },
    );
  }
}

