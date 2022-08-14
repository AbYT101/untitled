import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/data/constants.dart';
import 'package:untitled/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/ui/home.dart';

class LoginScreen  extends StatelessWidget {
  static String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset:false,
      body: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children:[ Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/login.png',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.fill,),

                  Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text('SMART', style: Theme
                              .of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.black, fontSize: 33),),
                          Text('HOME', style: Theme
                              .of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.black, fontSize: 64),)
                        ],
                      )),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Sign into mange your home', style: TextStyle(fontSize: 18),),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 40.0, right: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(70.0),),
                      hintText: 'User name',
                      suffixIcon: const Icon(Icons.account_box_rounded, color: Colors.black,)
                  ),),
              ),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(

                  controller: passwordController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 40.0, right: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(70.0),),
                      hintText: 'Password',
                      suffixIcon: const Icon(Icons.lock, color: Colors.black,)
                  ),),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                    // Navigator.push(context,
                    //   MaterialPageRoute(builder: context) => const HomePage());
                    logIn(emailController.text, passwordController.text);

                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF464646),
                      borderRadius: BorderRadius.circular(70.0),),
                    child: const Text(
                      'Get Started', style: TextStyle(color: Colors.white),),
                    alignment: Alignment.center,),
                ),
              ),
              const SizedBox(height: 10),

              const Center(child: Text('Don\'t have an account yet?'))
            ],
          ),
      ]
        ),
    );
  }

  Future<User> createUser(String username, String password) async {
    final response = await http.post(
      Uri.parse(ipAddress),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': 'Teshale',
        'password': '12345678',
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode == 401) {
      Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      throw Exception('Failed to create album.');
    }
    //show an error here for incorrect user and password
    else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
  void logIn(username, password) async{
    User response = await createUser(username, password) ;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', response.id);
    await prefs.setString('username', response.username);
    await prefs.setString('accessToken', response.accessToken);
    await prefs.setString('refreshToken', response.refreshToken);
    print(prefs.getString('username'));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );


  }

}

