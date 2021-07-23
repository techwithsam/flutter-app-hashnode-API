import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hashnode/style/style.dart';

class BlogViews extends StatefulWidget {
  final String? urli;
  final String? title;
  BlogViews({Key? key, @required this.title, @required this.urli})
      : super(key: key);

  @override
  _BlogViewsState createState() => _BlogViewsState();
}

class _BlogViewsState extends State<BlogViews> {
  InAppWebViewController? webView;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('${widget.title}', style: AppTextStyle().appbarStyle),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              if (webView != null) {
                webView!.reload();
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
              initialUrlRequest: URLRequest(url: Uri.parse('${widget.urli}')),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions()),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = '$url';
                });
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  this.url = '$url';
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
