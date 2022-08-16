import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/ui/login.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/data/constants.dart';

import '../data/constants.dart';
import '../data/fetched_data.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

String username = '';
class _ControlPageState extends State<ControlPage> {
  String? urlImage,name,uid;
  bool lightStatus = true;
  bool acStatus = false;

  @override
  void initState() {
    super.initState();
    connect();
    _getUserData();
  }
  Future<void> connect() async {
    IO.Socket socket = IO.io(serverIpAddress,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.on('data fetched', (msg) => {
      // print(msg),
      setActuatorData(msg)
    });

  }
  void _getUserData() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username')??'');
    });
  }
  void setActuatorData(json){
    FetchedData data =  FetchedData.fromJson(jsonDecode(json));
    // print(data.temperature);
    if (this.mounted) {
      setState(() {

        if(data.light1 == 'true'){
          lightStatus = true;
        }
        else {
          lightStatus = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xF9F9F9F9),
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.start,
            children: [
              const ClipRRect(
                child: ClipRRect(
                  child: CircleAvatar(
                    backgroundImage:  AssetImage(
                        'assets/images/app_logo.png'
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 50),
              const Spacer(),
              Text(
                'Hi, $username',
                style: const TextStyle(
                    color : Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Spacer(),
              ClipRRect(
                child: ClipRRect(
                  child: CircleAvatar(
                    backgroundImage:  AssetImage(
                        'assets/images/empty_avatar.png'
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          top: 35,
          right: 30,
          bottom: 15,
          ),
        child: ListView(
        children: [
          Text('Appliances', style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold)),
         SizedBox(height: 10,),
         Row( children: [
           Container(
             child: Column(
               children: [
               Icon(Icons.light, size: 120),
               Text('Light 1', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
                 Switch(value: lightStatus,
                   onChanged: (bool newValue) async{
                     print('light state changed');
                    String respose = await switchActuators('Light 1', 'true');
                     setState(() {
                       lightStatus = newValue;
                     });
                   }, ),
             ],
             ),
           ),
           Spacer(),
           Container(
             child: Column(
               children: [
                 Icon(Icons.ac_unit_sharp, size: 120),
                 Text('Light 2', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
                 Switch(value: acStatus,
                   onChanged: (bool newValue){
                     setState(() {
                       acStatus = newValue;
                       print('Motion Sensor state changed');
                     });
                   }, ),
               ],
             ),
           )
         ]),
          SizedBox(height: 22,),
          Row( children: [
            Container(
              child: Column(
                children: [
                  Icon(Icons.security, size: 120),
                  Text('   Security', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
                  Switch(value: lightStatus,
                    onChanged: (bool newValue){
                      setState(() {
                        lightStatus = newValue;
                        print('Motion Sensor state changed');
                      });
                    }, ),
                ],
              ),
            ),
            Spacer(),
            Container(
              child: Column(
                children: [
                  Icon(Icons.man_sharp, size: 120),
                  Text('Motion Sensor', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
                  Switch(value: acStatus,
                    onChanged: (bool newValue){
                      setState(() {
                        acStatus = newValue;
                        print('Motion Sensor state changed');
                      });
                    }, ),
                ],
              ),
            ),
          ]),
          SizedBox(height: 22,),
          Row( children: [
            Container(
              child: Column(
                children: [
                  Icon(Icons.ac_unit, size: 120),
                  Text('   Fan - AC', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
                  Switch(value: lightStatus,
                    onChanged: (bool newValue){
                      setState(() {
                        lightStatus = newValue;
                        print('Motion Sensor state changed');
                      });
                    }, ),
                ],
              ),
            ),
            Spacer(),
            Container(
              child: Column(
                children: [
                  Icon(Icons.water_drop, size: 120),
                  Text('Water sensor', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
                  Switch(value: acStatus,
                    onChanged: (bool newValue){
                      setState(() {
                        acStatus = newValue;
                        print('Motion Sensor state changed');
                      });
                    }, ),
                ],
              ),
            ),
          ])
        ],)
      )
    );
  }
  Future<String> switchActuators(String identifier, String status) async{
      final response = await http.post(
        Uri.parse(commandipAddress),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': identifier,
          'status': status,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        return response.body;
      }
      //show an error here for incorrect user and password
      else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to send data.');
      }


  }
}
