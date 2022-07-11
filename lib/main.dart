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
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SplashScreen(
        // backgroundColor: Colors.amber[400],
        loaderColor: Colors.amber[400],
        seconds: 5,
        navigateAfterSeconds: AfterSplash(),
        loadingText: Text("Welcome To LayzeeLearner", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber[400]),),
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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

class ConnCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConnectivityResult conn =Provider.of<ConnectivityResult>(context); 
    
    if (conn != null){
      return ShowCaseWidget(builder: Builder(builder: (context) => AfterS()),)
    }

    return Container(

    );
  }
}

class ConnectivityService {
  Stream<ConnectivityResult> get connStateChanges => Connectivity().onConnectivityChanged;
}