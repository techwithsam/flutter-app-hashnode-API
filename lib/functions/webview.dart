import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hashnode/style/style.dart';

class BlogViews extends StatefulWidget {
  final String urli;
  final String title;
  BlogViews({Key key, @required this.title, @required this.urli})
      : super(key: key);

  @override
  _BlogViewsState createState() => _BlogViewsState(title: title, urli: urli);
}

class _BlogViewsState extends State<BlogViews> {
  final String urli;
  final String title;
  _BlogViewsState({@required this.title, @required this.urli});
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: AppTextStyle().appbarStyle,
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              if (webView != null) {
                webView.reload();
              }
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          progress < 1.0
              ? LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white,
                )
              : Container(),
          Expanded(
            child: InAppWebView(
              initialUrl: urli,
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
              )),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                setState(() {
                  this.url = url;
                });
              },
              onLoadStop:
                  (InAppWebViewController controller, String url) async {
                setState(() {
                  this.url = url;
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ],
      )),
    );
  }
}
