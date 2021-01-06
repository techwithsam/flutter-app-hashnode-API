import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashnode/functions/customFunc.dart';
import 'package:hashnode/functions/locator.dart';
import 'package:hashnode/functions/webview.dart';
import 'package:hashnode/theme/colors.dart';
import 'package:hashnode/theme/style.dart';
import 'package:hashnode/widget/noInt.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'best.dart';
import 'community.dart';
import 'dev.dart';
import 'featured.dart';
import 'new.dart';

const playStoreUrl =
    'https://play.google.com/store/apps/details?id=com.acctgen1.hashnode';
var func = locator<CustomFunction>();

class HomePgae extends StatefulWidget {
  HomePgae({Key key}) : super(key: key);

  @override
  _HomePgaeState createState() => _HomePgaeState();
}

class _HomePgaeState extends State<HomePgae> with TickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _nestedTabController;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool chinternet = true, visinew = false;
  var messtitle;
  var messbody;
  var imageurl;
  var newdata;
  var navigation;

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void getMessage() {
    _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      messtitle = message["data"]["title"];
      messbody = message["data"]["body"];
      imageurl = message["data"]["image"];
      newdata = message["data"]["newdata"];
      navigation = message["data"]["navigate"];
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  //checking if input sent is not null
                  title: Center(
                    child: Text(
                      (messtitle == null ? 'Hashnode' : messtitle),
                      style: GoogleFonts.aBeeZee(
                          color: AppColor().mainColor,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    messbody == null ? 'No message sent!' : messbody,
                    style: GoogleFonts.aBeeZee(fontSize: 14),
                  ),
                ),
                SizedBox(height: 5),
                imageurl == null
                    ? Image.asset('assets/noimg.png')
                    : Image.network(imageurl)
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: newdata == null ? Text('Close') : Text(newdata),
                onPressed: () {
                  print(navigation);
                  if (navigation != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlogViews(
                                  title: 'Hashnode',
                                  urli: '$navigation',
                                )));
                  } else {
                    Navigator.of(context).pop();
                    print(navigation);
                  }
                },
              )
            ],
          );
        },
      );
    }, onResume: (Map<String, dynamic> message) {
      messtitle = message["data"]["title"];
      messbody = message["data"]["body"];
      imageurl = message["data"]["image"];
      newdata = message["data"]["newdata"];
      navigation = message["data"]["navigate"];
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                  title: Center(
                    child: Text(
                      (messtitle == null ? 'Hashnode' : messtitle),
                      style: TextStyle(
                          color: AppColor().mainColor,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    messbody == null ? 'No message sent!' : messbody,
                    style: TextStyle(fontSize: 14),
                  )),
              imageurl == null
                  ? Image.asset('assets/noimg.png')
                  : Image.network(imageurl)
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: newdata == null ? Text('Close') : Text(newdata),
              onPressed: () {
                if (navigation != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlogViews(
                                title: 'Hashnode',
                                urli: '$navigation',
                              )));
                } else {
                  Navigator.of(context).pop();
                  print(navigation);
                }
              },
            )
          ],
        ),
      );
    }, onLaunch: (Map<String, dynamic> message) {
      messtitle = message["data"]["title"];
      messbody = message["data"]["body"];
      imageurl = message["data"]["image"];
      newdata = message["data"]["newdata"];
      navigation = message["data"]["navigate"];
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                  title: Center(
                    child: Text(
                      (messtitle == null ? 'Hashnode' : messtitle),
                      style: TextStyle(
                          color: AppColor().mainColor,
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    messbody == null ? 'No message sent' : messbody,
                    style: TextStyle(fontSize: 14),
                  )),
              imageurl == null
                  ? Image.asset('assets/noimg.png')
                  : Image.network(imageurl)
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: newdata == null ? Text('Close') : Text(newdata),
              onPressed: () {
                if (navigation != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlogViews(
                                title: 'Hashnode',
                                urli: '$navigation',
                              )));
                } else {
                  Navigator.of(context).pop();
                  print(navigation);
                }
              },
            )
          ],
        ),
      );
    });
  }

  // void versionCheck() async {
  //   final PackageInfo info = await PackageInfo.fromPlatform();
  //   double currentVersion =
  //       double.parse(info.version.trim().replaceAll(".", ""));

  //   final RemoteConfig remoteConfig = await RemoteConfig.instance;
  //   try {
  //     await remoteConfig.fetch();
  //     await remoteConfig.activateFetched();
  //     remoteConfig.getString('force_update_current_version');
  //     double newVersion = double.parse(remoteConfig
  //         .getString('force_update_current_version')
  //         .trim()
  //         .replaceAll(".", ""));

  //     if (newVersion > currentVersion) {
  //       setState(() {
  //         visinew = true;
  //       });
  //       _showVersionDialog(context);
  //     }
  //   } on FetchThrottledException catch (exception) {
  //     Text('$exception - ****************exception check');
  //   } catch (exception) {}
  // }

  showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of Hashnode available on playstore'' please update it now and view our new amazing features 😍.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(playStoreUrl),
                  ),
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            : AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(playStoreUrl),
                  ),
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _register();
    getMessage();
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {});
    //versionCheck();
    _nestedTabController = TabController(length: 4, vsync: this);
    Future<int> a = CustomFunction().checkInternetConnection();
    a.then((value) {
      print(value);
      if (value == 0) {
        setState(() {
          chinternet = false;
        });
      } else {
        setState(() {
          chinternet = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: CircleAvatar(
          child: Image.asset(
            'assets/logo.jpg',
            height: 32,
            width: 32,
          ),
          backgroundColor: Colors.white,
        ),
        title: Text(
          'Hashnode',
          style: AppTextStyle().appbarStyle,
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          PopupMenuButton(
            onSelected: (v) {
              if (v == 0) {
                func.showToast(message: 'Coming soon...');
              } else if (v == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactDev()));
              } else if (v == 2) {
                Share.share(
                    'Hi dev, kindly download this app to check hashnode featured, best, new'
                    ', and community articles at your finger tips --> $playStoreUrl');
              } else if (v == 3) {
                launch(playStoreUrl);
              } else if (v == 4) {
                launch('https://api.hashnode.com/');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Settings'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Developer'),
                value: 1,
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Share'),
                    Icon(Icons.share),
                  ],
                ),
                value: 2,
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rate US'),
                    Icon(Icons.star_rate),
                  ],
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: RichText(
                  text: TextSpan(
                      text: 'Powered by ',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: 'Hashnode API',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch('https://api.hashnode.com/');
                              },
                            style: GoogleFonts.poppins(
                              color: AppColor().mainColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.double,
                            )),
                      ]),
                ),
                value: 4,
              ),
            ],
          )
        ],
        bottom: TabBar(
          controller: _nestedTabController,
          indicatorColor: AppColor().mainColor,
          labelColor: AppColor().mainColor,
          unselectedLabelColor: Colors.black,
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              child: Text('COMMUNITY', style: AppTextStyle().tabsStyle),
            ),
            Tab(
              child: Text('BEST', style: AppTextStyle().tabsStyle),
            ),
            Tab(
              child: Text('NEW', style: AppTextStyle().tabsStyle),
            ),
            Tab(
              child: Text('FEATURED', style: AppTextStyle().tabsStyle),
            ),
          ],
        ),
      ),
      body: !chinternet
          ? NoInternet(callBack: retry)
          : TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                CommunityPage(),
                BestPage(),
                NewPage(),
                FeaturedPage(),
              ],
            ),
    );
  }

  retry() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePgae()));
  }
}
