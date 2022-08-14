import 'package:flutter/material.dart';
import 'package:untitled/ui/login.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  String? urlImage,name,uid;
  bool lightStatus = true;
  bool acStatus = false;

  void getUserData(){
    setState(){
      name = 'Abraham';
    }
    getUserData();
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
                'Hi, $name',
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
               Text('   Lights', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
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
                 Icon(Icons.ac_unit_sharp, size: 120),
                 Text('Air Control - Fan', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
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
                  Icon(Icons.ac_unit_sharp, size: 120),
                  Text('Sprinkler', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
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
          ])
        ],

      )
      )
    );
  }
}
