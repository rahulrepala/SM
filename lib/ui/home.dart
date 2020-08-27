import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_management/ui/create_order.dart';
import 'package:studio_management/ui/order_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:studio_management/ui/due_list.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<dynamic> Orders=[];
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

 var cn=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        elevation: 0,
        title:  TextFormField(
               controller: cn,
               decoration: InputDecoration(
               border: InputBorder.none,
                hintText: 'Enter a search term'
             ),
            ),
      //  centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: () async{
            List search=[];

                SharedPreferences prefs = await SharedPreferences.getInstance();
        int id = prefs.getInt('ClientId');

        var date = new DateTime.now().toString();
 
        var dateParse = DateTime.parse(date);
 
        var formattedDate = "${dateParse.month}-${dateParse.day}-${dateParse.year}";
 
        
        var url = "http://test.matha.co.in/api/Order/UpComingOrders?clientId="+id.toString()+"&date="+formattedDate.toString()+"&searchText="+cn.text.toString();
        var resp = await http.post(url);
        var result = json.decode(resp.body);
        print(result);
        search=result;
            
            showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Scaffold(appBar: AppBar(
         elevation: 0,
          backgroundColor:  Color(0xfff2f7ff),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
          title: Text(cn.text.toString(),style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.clear),onPressed: (){
            Navigator.pop(context);
        },)],),
        body: listWidget(search),
        
        );
      },
    );
          },)
        ],
        backgroundColor:  Color(0xfff2f7ff),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      drawer: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width*0.6,
          child: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Image.asset(
                    'assets/images/camera.png'
                    ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                    Icon(Icons.bookmark_border,color: Theme.of(context).primaryColor,),
                    Text('     Orders',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),)
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title:  Row(
                    children: <Widget>[
                    Icon(Icons.add_shopping_cart,color: Theme.of(context).primaryColor,),
                    Text('     New Orders',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),)
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewOrder([])),
                            (Route<dynamic> route) => true);
                  },
                ),


                ListTile(
                  title:  Row(
                    children: <Widget>[
                    Icon(Icons.list,color: Theme.of(context).primaryColor,),
                    Text('     Due List',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),)
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                       Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DueList()),
                            (Route<dynamic> route) => true);
                  },
                ),

              ],
            ),
          ),
        ),
      ),

      body: load==1?listWidget(Orders):Container(child: Center(child: Text("Loading..."),)),
    );
  }

  void _load() async{
    
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int id = prefs.getInt('ClientId');

        var date = new DateTime.now().toString();
 
        var dateParse = DateTime.parse(date);
 
        var formattedDate = "${dateParse.month}-${dateParse.day}-${dateParse.year}";
 
        
        var url = "http://test.matha.co.in/api/Order/UpComingOrders?clientId="+id.toString()+"&date="+formattedDate.toString();
        var resp = await http.post(url);
        var result = json.decode(resp.body);
        print(result);

         setState(() {
           Orders=result;
           load=1;
         });

  }

Widget listWidget(orders){
  
return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext ctxt, int index) {
           return  Padding(
          padding: const EdgeInsets.fromLTRB(15,8,15,0),
          child: Card(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(3),topRight: Radius.circular(3)),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(orders[index]['CustomerName'],style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500,letterSpacing: 0.3),),
                        ),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                    child: Row(
                      children: <Widget>[
                       Expanded(
                         flex: 1,
                         child: Center(child: Text('Phone Number  :',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Theme.of(context).primaryColor),)),),
                      
                       Expanded(
                         flex: 1,
                         child: Center(child: Text(orders[index]['CustomerMobile'].toString())),)

                      ],
                     ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                       Expanded(
                         flex: 1,
                           child: Center(child: Text('Address  :',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Theme.of(context).primaryColor),)),),                      
                       Expanded(
                         flex: 1,
                         child: Column(children: <Widget>[
                            Center(child: Text(orders[index]['CustomerAddress']),)
                           ],))

                      ],
                     ),
                  ),

                SizedBox(height: 15,),

                GestureDetector(
                      onTap: (){
                              String id=orders[index]['OrderId'].toString();
                               Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                               builder: (context) => OrderDetails(orderId: id,)),
                               (Route<dynamic> route) => true);
                             },
                      child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                      child: Container(
                        color: Color(0xffdaf0ff),
                        child:Center(child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                             'Order Details',
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w400,
                               letterSpacing: 0.2,
                               color: Colors.black
                             ),
                           ),
                          )),
                      ),
                    ),
                ),
                  
                ],
              ),
            ),
          ),
           );
        }
       );
}

}