import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase_widget.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityResult>.value(value: ConnectivityService().connStateChanges)
      ],

      child: MaterialApp(
        title: "Layzee Learner",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          secondaryHeaderColor: Colors.amber[400]
        ),
        home: LaunchScreen(),
      ),
    );
  }
}

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SplashScreen(
        // backgroundColor: Colors.amber[400],
        loaderColor: Colors.green[500],
        seconds: 2,
        navigateAfterSeconds: AfterSplash(),
        loadingText: Text("Welcome To LayzeeLearner", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[500]),),
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // after launchscreen loading check for internet connectivity
    return MaterialApp(
      title: 'Custom Invoicing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green[500],
          primaryColorBrightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey[850],
          accentColor: Colors.blue[500],
          accentColorBrightness: Brightness.dark,
        ),
      home: ConnCheck(),
    );
  }
}

class ConnCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConnectivityResult conn =Provider.of<ConnectivityResult>(context); 
    
    if (conn != null && conn.index != 2){
      return ShowCaseWidget(builder: Builder(builder: (context) => LoginPage()));
    }
    else {
      return NoConnection();
    }
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green[500],
        primaryColorBrightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[850],
        accentColor: Colors.blue[50],
        accentColorBrightness: Brightness.dark,
      ),
      title: 'login',
      home: Scaffold(
        appBar: AppBar(
          title: Text('LayzeeLearner'),
          toolbarHeight: 80.0,
          ),
        body: Center(
          child : Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
                  child: Text(
                    'Login to Continue',
                    style: TextStyle(
                      color: Colors.green[500],
                      fontSize: 17
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(), 
                      labelText: 'Username'
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password'
                    ),
                  ),
                ),

                // TextButton(onPressed: (){
                //   // Forgot Password Screen
                //   }, 
                //   child: Text('Forgot Password?',),
                // ),

                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      if (nameController.text == 'guru' && passwordController.text == 'hello'){
                        print('success');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                      else {
                        print('failure');
                      }
                      
                      // print(nameController.text);
                      // print(passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[500], 
                    ),
                  ),
                ),
              ],
            ),
          ),
        ), 
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LayzeeLearner"),
        toolbarHeight: 80.0,
      ),
      body: Container(
        child: Center(
          child: Text("Hello World", style: TextStyle(fontSize: 22.0),),
        ),
      ),
    );
  }
}

class NoConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LayzeeLearner"),
        toolbarHeight: 80.0,
      ),
      body: Container(
        child: Center(
          child: Text("No Connection", style: TextStyle(fontSize: 22.0),),
        ),
      ),
    );
  }
}

class ConnectivityService {
  Stream<ConnectivityResult> get connStateChanges => Connectivity().onConnectivityChanged;
}