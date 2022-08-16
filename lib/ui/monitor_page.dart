
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io/socket_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/data/constants.dart';

import '../data/fetched_data.dart';

String _name = '';
class MonitorPage extends StatefulWidget {
  const MonitorPage({Key? key}) : super(key: key);

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}
  String? currentTemprature = '25';
  bool motionSensorVal = true;
  String? humidity = '';
  String? temprature= '0N';
  String? presence = 'Nothing';
  String? nfc = 'Locked';
  String cooling = 'ON';
  String waterlevel = '250';
  String lights = 'ON';
class _MonitorPageState extends State<MonitorPage> {

  IO.Socket? socket;
  String? urlImage,uid;

  //Humudity waterLevel NFC motion sensor

  @override
  void initState(){
    super.initState();
    connect();
    _getUserData();
  }
  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  Future<void> connect() async {
    IO.Socket socket = IO.io(serverIpAddress,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.on('data fetched', (msg) => {
      setActuatorData(msg),

    });
    // socket.emit('save temperature', ' data');
    print(socket.connected);

  }
  void setActuatorData(json){
    FetchedData data =  FetchedData.fromJson(jsonDecode(json));
    print(data.temperature);
    if (this.mounted) {
      setState(() {
        currentTemprature = data.temperature.toString();
        humidity = data.humidity;
        presence = data.motion;
        if(data.light1 == 'true'){
          lights = 'ON';
        }
        else {
          lights = 'OFF';
        }
      });
    }

  }

  void _getUserData() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = (prefs.getString('username')??'');
      // currentTemprature = '20';
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xF9F9F9F9),
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          centerTitle: true,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(
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
                      'Hi, $_name',
                      style: const TextStyle(
                          color : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24
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
              SizedBox(height: 10,),
              Center(
                child: Row( children: [
                  Text('$currentTemprature C',
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: 30,),
                //   Column(children: [
                //   //   Row(
                //   //     children: [
                //   //       Text('Cooling:  ',
                //   //       style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal),),
                //   //       Text('$cooling',
                //   //         style: TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.normal),),
                //   //   ]),
                //   //   Row(
                //   //       children: [
                //   //         Text('NFC:   ',
                //   //           style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal),),
                //   //         Text('$nfc',
                //   //           style: TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.normal),),
                //   //       ]),
                //   // ],)
                ]),
              ),
              SizedBox(height: 29,),

              Divider(color: Colors.black45,thickness: 1, indent: 30, endIndent: 20,),
              ListTile(
                title: Text('Cooling',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                leading: Icon(Icons.ac_unit, color: Colors.blue, size: 50,),
                trailing: Text('$waterlevel',
                    style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),

              ),
              Divider(color: Colors.black45,thickness: 1, indent: 30, endIndent: 20,),
              ListTile(
                title: Text('Water Level',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                leading: Icon(Icons.water_drop, color: Colors.blue, size: 50,),
                trailing: Text('$waterlevel',
                    style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),

              ),
              Divider(color: Colors.black45,thickness: 1, indent: 30, endIndent: 20,),
              ListTile(
                title: Text('Motion ',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                leading: Icon(Icons.man, size: 50, color: Colors.black87),
                trailing: Text('$presence',
                    style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),

              ),
              Divider(color: Colors.black45,thickness: 1, indent: 30, endIndent: 20,),
              ListTile(
                title: Text('Humudity',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                leading: Icon(Icons.ac_unit_rounded, size: 50,),
                trailing: Text('$humidity',
                    style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),
              ),
              Divider(color: Colors.black45,thickness: 1, indent: 30, endIndent: 20,),
              ListTile(
                title: Text('Lights',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                leading: Icon(Icons.light, size: 50, color: Colors.redAccent),
                trailing: Text('$lights',
                    style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),
              ),
              Divider(color: Colors.black45,thickness: 1, indent: 30, endIndent: 20,),
              ListTile(
                title: Text('NFC',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                leading: Icon(Icons.lock, color: Colors.blue, size: 50,),
                trailing: Text('$waterlevel',
                    style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),

              ),
              Divider(color: Colors.black45,thickness: 1, indent: 30, endIndent: 20,),
            ],
          )
      )

    );

  }


}
