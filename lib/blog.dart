import 'package:flutter/material.dart';
import 'package:jayapulsa/main.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  int position = 1;

  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child: AppBar(
              // ...
              )),
      body: IndexedStack(index: position, children: <Widget>[
        WebView(
          initialUrl: 'http://blog.jayapulsa.id/',
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
                  builder: (BuildContext context) => MyHomePage(),
                ),
              );
            },
            child: const Icon(Icons.payment),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: new BottomAppBar(
        color: Colors.white,
      ),
    );
  }
}
