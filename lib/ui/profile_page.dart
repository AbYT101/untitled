import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _SettingPageState();
}

class _SettingPageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SharedPreferences? prefs;
  String? username ;

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
                children: [
                  const Text(
                    'Profile',
                    // style: Theme.of(context).textTheme.headline1,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
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
                  children: const [
                    SizedBox(
                      height: (15),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/empty_avatar.png',
                      ),
                      maxRadius: 45.0,

                    ),
                    Text(
                      '',
                      // style: Theme.of(context).textTheme.headline1,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(
              height: (20),
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
              child: const Center(
                  child: Text('Log out', style: TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.bold),)
              ),
            ),
          ],
        ),
      )
    );
  }

  void loadDatas() async {
    final prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString('username');
    username = name!;


  }
}


