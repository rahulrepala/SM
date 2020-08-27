import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_management/ui/create_order.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;
  OrderDetails({this.orderId});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  
  List s=[];

  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
     body: OrientationBuilder(builder: (context,orientation){
      Size size=MediaQuery.of(context).size;  
    //  print(size.height*0.026);
     return Stack(
       children: <Widget>[
         Container(
           color: Theme.of(context).primaryColor,
           height: size.height,
           child: Column(
             children: <Widget>[
                 SizedBox(height: size.height*0.026,),
                 SafeArea(child: Center(child: 
                 Column(children: <Widget>[
                 s.length>0?Text(s[0]['CustomerName'],style: TextStyle(color: Colors.white,fontSize: size.height*0.04)):Text(''),
                 s.length>0?Text(s[0]['CustomerMobile'].toString(),style: TextStyle(color: Colors.white,fontSize: size.height*0.04)):Text(''),
                 ],)
                 ))
             ],
           ),
         ),
          
         DraggableScrollableSheet(
           initialChildSize: 0.8,
           maxChildSize: 0.8,
           builder: (context,scrollController){
             return SingleChildScrollView(
               child:  Container(
               child: Column(
                children: <Widget>[

            
                ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                    child: SingleChildScrollView(
                         child: Container(
            
                        width: size.width,
                        color: Colors.white,
                        child:s.length>0?Column(
                          children: <Widget>[
                           
                            s[0]['Functions']=='Yes'?
                            Container(
                              height: orientation==Orientation.portrait?size.height*0.26:size.height*0.44,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width:size.width*0.03 ,),
                                   Padding(
                                     padding: const EdgeInsets.fromLTRB(8,13,0,12),
                                     child: Container(
                                       width: size.width*0.23,
                                        child: 
                                          Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                             Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('Functions',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ), 
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('Famount',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('Decoration',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ), 
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('Damount',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ),
                                                Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('Date',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: AutoSizeText('Address',maxLines: 2,style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ),

                                      ],
                                     ),),
                                   ),

                               Container(
                                 width: size.width*0.68,

                                child: ListView.builder(
                                scrollDirection: Axis.horizontal,  
                                itemCount: s[0]['PsOrderFunctions'].toList().length,
                                itemBuilder: (context, position) {
                                     List j=s[0]['PsOrderFunctions'].toList();
                                       return Card(
                                         child:Padding(
                                           padding: const EdgeInsets.fromLTRB(25,10,25,8),
                                           child: Container(
                                             width: size.width*0.4,
                                             child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                               children: <Widget>[
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Functions'].toString()),
                                             ), 
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Famount'].toString()),
                                             ),
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Decoration'].toString()),
                                             ), 
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Damount'].toString()),
                                             ),
                                              Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Date'].toString().substring(0,10)),
                                             ),
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: AutoSizeText(j[position]['Address'].toString(),maxLines: 2,),
                                             ),

                                             ],),),
                                         ) 
                                       );
                                         },
                                       ),
                                    )
                                    

                                ],
                              ),
                            )
                           :SizedBox(height: 0,),

                        SizedBox(height: size.height*0.02,),
                         s[0]['Video']=='Yes'?
                            Container(
                              height:orientation==Orientation.portrait? size.height*0.12:size.height*0.2,
                              child: Row(
                                children: <Widget>[
                                       SizedBox(width:size.width*0.03 ,),
                                   Padding(
                                     padding: const EdgeInsets.fromLTRB(8,13,0,12),
                                     child: Container(
                                       width: size.width*0.23,                                      
                                       child: 
                                          Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                             Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('VideoDate',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ), 
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('Amount',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ),
                                               
                                      ],
                                     ),),
                                   ),

                               Container(
                                 width: size.width*0.68,
                                child: ListView.builder(
                                scrollDirection: Axis.horizontal,  
                                itemCount: s[0]['PsOrderVideo'].toList().length,
                                itemBuilder: (context, position) {
                                     List j=s[0]['PsOrderVideo'].toList();
                                       return Card(
                                         child:Padding(
                                           padding: const EdgeInsets.fromLTRB(25,10,25,8),
                                           child: Container(
                                             child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                               children: <Widget>[
                                             
                                              Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Date'].toString().substring(0,10)),
                                             ),
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Amount'].toString()),
                                             ),

                                             ],),),
                                         ) 
                                       );
                                         },
                                       ),
                                    )
                                    

                                ],
                              ),
                            )
                           :SizedBox(height: 0,),
                         
                          SizedBox(height: size.height*0.02,),
                            
                         s[0]['Sheets']=='Yes'?
                            Container(
                              height: orientation==Orientation.portrait?size.height*0.18:size.height*0.33,
                              child: Row(
                                children: <Widget>[
                                       SizedBox(width:size.width*0.03 ,),
                                   Padding(
                                     padding: const EdgeInsets.fromLTRB(8,13,0,12),
                                     child: Container(
                                       width: size.width*0.23,
                                       
                                       child: 
                                          Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                             Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('SheetType',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ), 
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('Price',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('Quantity',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ), 
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('Amount',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ),

                                      ],
                                     ),),
                                   ),

                               Container(
                                 width: size.width*0.68,
    
                                child: ListView.builder(
                                scrollDirection: Axis.horizontal,  
                                itemCount: s[0]['PsOrderSheets'].toList().length,
                                itemBuilder: (context, position) {
                                     List j=s[0]['PsOrderSheets'].toList();
                                       return Card(
                                         child:Padding(
                                           padding: const EdgeInsets.fromLTRB(25,10,25,8),
                                           child: Container(
                                             child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                               children: <Widget>[
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['SheetType'].toString()),
                                             ), 
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Price'].toString()),
                                             ),
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Quantity'].toString()),
                                             ), 
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Amount'].toString()),
                                             ),
                                              

                                             ],),),
                                         ) 
                                       );
                                         },
                                       ),
                                    )
                                    

                                ],
                              ),
                            )
                           :SizedBox(height: 0,),

                           SizedBox(height: size.height*0.02,),

                            Container(
                              height: orientation==Orientation.portrait?size.height*0.14:size.height*0.23,
                              child: Row(
                                children: <Widget>[
                                       SizedBox(width:size.width*0.03 ,),
                                   Padding(
                                     padding: const EdgeInsets.fromLTRB(8,13,0,12),
                                     child: Container(
                                       width: size.width*0.23,
                                     
                                       child: 
                                          Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                             Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('PayDate',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ), 
                                               Padding(
                                                 padding: const EdgeInsets.all(3.0),
                                                 child: Text('Amount',style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                               ),
                                               
                                      ],
                                     ),),
                                   ),

                               Container(
                                 width: size.width*0.68,
                                
                                child: ListView.builder(
                                scrollDirection: Axis.horizontal,  
                                itemCount: s[0]['PsPayments'].toList().length,
                                itemBuilder: (context, position) {
                                     List j=s[0]['PsPayments'].toList();
                                       return Card(
                                         child:Padding(
                                           padding: const EdgeInsets.fromLTRB(25,10,25,8),
                                           child: Container(
                                             child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                               children: <Widget>[
                                             
                                              Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Date'].toString().substring(0,10)),
                                             ),
                                             Padding(
                                               padding: const EdgeInsets.all(3.0),
                                               child: Text(j[position]['Amount'].toString()),
                                             ),

                                             ],),),
                                         ) 
                                       );
                                         },
                                       ),
                                    )
                                    

                                ],
                              ),
                            ),


                         SizedBox(height: size.height*0.03,),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Card(child: Container(child:
                               Column(
                                 children: <Widget>[
                              Row(
                              children: <Widget>[
                               Column(
                                 children: <Widget>[
                                Padding(
                                padding: const EdgeInsets.fromLTRB(10, 3, 3,3),
                                child: Text("Others : ",style: TextStyle(color: color,fontWeight: FontWeight.bold),),
                                  ),
                                 Padding(
                                padding: const EdgeInsets.fromLTRB(10, 3, 3,3),
                                child: Text(s[0]['Others'].toString()),
                                  ),
                                 ],),

                              Expanded(
                                flex:2,
                                                              child: Column(children: <Widget>[
                                    Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 3, 3,3),
                                    child: Text("Description : ",style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                  ),
                                 Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 3, 3,3),
                                    child: Text(s[0]['Description'].toString()),
                                  ),
                                 ],),
                              ),

                               Expanded(
                                                                child: Column(children: <Widget>[
                                    Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 3, 3,3),
                                    child: Text("Amount : ",style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                  ),
                                 Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 3, 3,3),
                                    child: Text(s[0]['Amount'].toString()),
                                  ),
                                 ],),
                               ),
                                
                              ],
                          ),
                            
                            SizedBox(height: 15,),
                            Row(
                              children: <Widget>[
                               Column(children: <Widget>[
                                    Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 3, 3,3),
                                    child: Text("Total : ",style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                  ),
                                 Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 3, 3,3),
                                    child: Text(s[0]['TotalAmount'].toString()),
                                  ),
                                 ],),

                              Expanded(
                                flex: 2,
                                                              child: Column(children: <Widget>[
                                    Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 3, 3,3),
                                    child: Text("Discount : ",style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                  ),
                                 Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 3, 3,3),
                                    child: Text(s[0]['DiscountAmount'].toString()),
                                  ),
                                 ],),
                              ),

                               Expanded(
                                                                child: Column(children: <Widget>[
                                    Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 3, 3,3),
                                    child: Text("Payable : ",style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                  ),
                                 Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 3, 3,3),
                                    child: Text(s[0]['PayableAmount'].toString()),
                                  ),
                                 ],),
                               ),
                                
                              ],
                          ),

                          SizedBox(height: 15,),
                             Row(
                              children: <Widget>[
                               Column(children: <Widget>[
                                    Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 3, 3,3),
                                    child: Text("Paid : ",style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                  ),
                                 Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 3, 3,3),
                                    child: Text(s[0]['PaidAmount'].toString()),
                                  ),
                                 ],),

                              Expanded(
                                flex:2,
                                                              child: Column(children: <Widget>[
                                    Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 3, 3,3),
                                    child: Text("Due : ",style: TextStyle(color: color,fontWeight: FontWeight.bold)),
                                  ),
                                 Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 3, 3,3),
                                    child: Text(s[0]['DueAmount'].toString()),
                                  ),
                                 ],),
                              ),

                                
                              Expanded(
                                                              child: Column(children: <Widget>[
                                    Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 3, 3,3),
                                    child: Text("               "),
                                  ),
                                 Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 3, 3,3),
                                    child: Text("       "),
                                  ),
                                 ],),
                              ),
                              ],
                          ),
                           SizedBox(height: 15,),

                                   ],
                                  ),
                                ),
                              ),
                           ),
                     SizedBox(height: 10,),

                     

                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[


                        FlatButton(
                           child: Padding(
                             padding: const EdgeInsets.fromLTRB(10,1,10,1),
                             child: Text(
                               'Edit',
                               style: Theme.of(context).textTheme.button,
                             ),
                           ),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(25),
                           ),
                           padding: const EdgeInsets.all(15),
                           color: Theme.of(context).buttonColor,
                           textColor: Colors.white,
                           onPressed: () async{

                            Navigator.pushAndRemoveUntil(
                             context,
                             MaterialPageRoute(
                               builder: (context) => NewOrder(s)),
                               (Route<dynamic> route) => true);


                          },
                         ),

                             
                        FlatButton(
                           child: Padding(
                             padding: const EdgeInsets.fromLTRB(10,1,10,1),
                             child: Text(
                               'Make Payment',
                               style: Theme.of(context).textTheme.button,
                             ),
                           ),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(2),
                           ),
                           padding: const EdgeInsets.all(15),
                           color: Colors.lightBlue,
                           textColor: Colors.white,
                           onPressed: () async{
                              _makePayment();

                          },
                         ),

                             
                           ],
                         ),

                          SizedBox(height: 30,)

                           ],
                        ):Center(child: Container(
                          height: size.height*0.85,
                          child: Text('Loading..')))
                      ),
                    ),
                  ),
             
             ],
           ),
           ),
          );
          }
         )
  
         ],
       );


     }),
      
    );
  }

  _makePayment(){

     String _value = '';
          var _amount = TextEditingController();
          
       showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context,setState){
          
           _selectDate() async {
              DateTime picked = await showDatePicker(
              context: context,
              initialDate: new DateTime.now(),
              firstDate: new DateTime(2010),
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
          //     print(picked.toString().substring(0,10)); 
               setState(() => _value = picked.toString().substring(0,10));
               }
            }

          

            return Dialog(
              shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)),
              child: Container(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [                     
                      _value == ''
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              _selectDate();
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
                                    'Date ',
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              children: <Widget>[
                                Text(
                                  'Date: ' +
                                      _value.substring(8, 10) +
                                      "-" +
                                      _value.substring(5, 7) +
                                      "-" +
                                      _value.substring(0, 4),
                                  style: TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    _selectDate();
                                  },
                                ),
                              ],
                            ),
                        ),
                    
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextFormField(
                          maxLines: 1,
                          controller: _amount,
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
                              labelText: 'Amount',
                              border: OutlineInputBorder(),
                              hintText: "amount",
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
                             'SUBMIT',
                             style: Theme.of(context).textTheme.button,
                           ),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(25),
                           ),
                           padding: const EdgeInsets.all(15),
                           color: Theme.of(context).buttonColor,
                           textColor: Colors.white,
                           onPressed: () async{

                             SharedPreferences prefs = await SharedPreferences.getInstance();
                             int id = prefs.getInt('ClientId');

                             var url = 'http://test.matha.co.in/api/Order/InsertPayment';
                             var resp = await http.post(
                              url,
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: json.encode(<String, dynamic>{
                             
                               "orderId":widget.orderId,
                               "date":_value+"T00:00:00",
                               "amount":num.parse(_amount.text.toString()),
                               "createdBy":id
                              
                              }),

                                                         );
                             var result = json.decode(resp.body);
                      //       print(result);


                             if(result.toString()=="Payment Received"){
                                Navigator.pop(context); 
                                _load();                       
                               Fluttertoast.showToast(
                                 msg: "Payment Received",
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.BOTTOM,
                                 timeInSecForIosWeb: 1,
                                 backgroundColor: Colors.blue,
                                 textColor: Colors.white,
                                 fontSize: 16.0
                                );
                             }
                           
       
                           },
                         ),
                       ),
                     ],)
                       


                   ],
                  ),
                ),
              ),
             );
            },
          );
        });
  }

   void _load() async{
    var ur="http://test.matha.co.in/api/Order/OrderDetails?orderId="+widget.orderId;
    var resp = await http.post(ur);
    var result = json.decode(resp.body);
    setState(() {
      s=result;
    });
  //  print(result[0]);
  }


}

