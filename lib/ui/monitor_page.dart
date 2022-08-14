
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io/socket_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonitorPage extends StatefulWidget {
  const MonitorPage({Key? key}) : super(key: key);

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {

  IO.Socket? socket;
  String? urlImage,name,uid;
  String? currentTemprature = '25';
  bool motionSensorVal = true;
  // String? humidity =;
  String? temprature= '0';
  String? presence = 'Nothing';
  String? nfc = 'Locked';
  late final SharedPreferences prefs;

  @override
  void initState(){
    super.initState();
    connect();
    getUserData();
    print('initialized');

  }

  Future<void> connect() async {
    IO.Socket socket = IO.io('http://192.168.25.16:3000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.on('save temp', (msg) => {
      print(msg)

    });
    socket.emit('save temperature', ' data');
    // socket.onconnect();
    print(socket.connected);


  }

  void getUserData() async{
    prefs = await SharedPreferences.getInstance();
    name =  prefs.getString('username');
    currentTemprature = '25';
    print(name);
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
                      'Hi, $name',
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
              Row( children: [
                Text('$currentTemprature C',
                  style: TextStyle(fontSize: 65, fontWeight: FontWeight.w300),
                ),
                SizedBox(width: 30,),
                Column(children: [
                  Text('Cooling: ',
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.normal),),
                  Text('Heating: ',
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.normal),)
                ],)
              ]),
              SizedBox(height: 29,),
              Row( children: [
                Text('Motion Sensor',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.normal)),
                Spacer(),
                Switch(value: motionSensorVal,
                  onChanged: (bool newValue){
                  setState(() {
                    motionSensorVal = newValue;
                    print('Motion Sensor state changed');
                    getUserData();
                  });
                  }, )
              ],),
            ],
          )
      )

    );
    getUserData();
  }


}
