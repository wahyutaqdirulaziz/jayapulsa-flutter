import 'package:flutter/material.dart';
import 'package:jayapulsa/blog.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(
    home: MyHomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue)));

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  int position = 1;

  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.0), // here the desired height
            child: AppBar(
                // ...
                )),
        body: IndexedStack(index: position, children: <Widget>[
          WebView(
            initialUrl: 'https://jayapulsa.id/public/',
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (value) {
              setState(() {
                position = 1;
              });
            },
            onPageFinished: (value) {
              setState(() {
                position = 0;
              });
            },
          ),
          Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        ]),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 4),
          height: 50.0,
          width: 50.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => BlogPage(),
                  ),
                );
              },
              child: const Icon(Icons.dashboard_customize_sharp),
              backgroundColor: Colors.blue,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: new BottomAppBar(
          color: Colors.white,
        ),
      ),
    );
  }
}


// "https://jayapulsa.id/public/"