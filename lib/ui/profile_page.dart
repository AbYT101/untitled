import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _SettingPageState();
}
String username = '' ;

class _SettingPageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SharedPreferences? prefs;


  @override
  void initState(){
    super.initState();
    loadDatas();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 15,
          right: 20,
          bottom: 15,
        ),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 7),
              child: Row(
                children: const [
                  Text(
                    'Profile',
                    // style: Theme.of(context).textTheme.headline1,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Center(
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFFBDBDBD).withOpacity(0),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(
                  left: (5),
                  top: (5),
                  right: (5),
                  bottom: (4),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: (15),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/empty_avatar.png',
                      ),
                      maxRadius: 55.0,
                    ),
                    SizedBox(
                      height: (10),
                    ),
                    Text(
                      '$username',
                      // style: Theme.of(context).textTheme.headline1,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(
              height: (13),
            ),
            Row(
              children: const [
                Icon( Icons.notifications, size: 50,),
                SizedBox(width: 20,),
                Text('Notifications',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: const [
                Icon( Icons.security, size: 50,),
                SizedBox(width: 20,),
                Text('Security',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: const [
                Icon( Icons.call, size: 50,),
                SizedBox(width: 20,),
                Text('Emergency contact',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: const [
                Icon( Icons.info, size: 50,),
                SizedBox(width: 20,),
                Text('About',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10,),
            const SizedBox(
              height: (20),
            ),
            Container(
              height: (40),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(

                  child: InkWell(
                    child: Text('Log out',
                      style:TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.bold),),
                    onTap: (){
                      print('Log out');
                    },
                  )
              ),
            ),
          ],
        ),
      )
    );
  }

  void loadDatas() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username')??'');
    });

  }
}


