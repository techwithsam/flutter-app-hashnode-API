import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashnode/functions/customFunc.dart';
import 'package:hashnode/functions/locator.dart';
import 'package:hashnode/style/colors.dart';
import 'package:hashnode/style/style.dart';
import 'package:hashnode/widget/noInt.dart';
import 'package:hashnode/widget/notification_dialog.dart';
import 'package:package_info/package_info.dart';
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
  String notiTitle, notiBody, notiImage, notiBtnName, notiBtnAction;

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void getMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<dynamic, dynamic> message) async {
        notiTitle = message["data"]["title"];
        notiBody = message["data"]["body"];
        notiImage = message["data"]["image"];
        notiBtnName = message["data"]["btnName"];
        notiBtnAction = message["data"]["btnAction"];
        return showDialog(
            context: context,
            builder: (_) {
              return NotificationDialog(
                title: '$notiTitle',
                body: '$notiBody',
                img: '$notiImage',
                btnAction: '$notiBtnAction',
                btnName: '$notiBtnName',
              );
            });
      },
      onResume: (Map<dynamic, dynamic> message) async {
        notiTitle = message["data"]["title"];
        notiBody = message["data"]["body"];
        notiImage = message["data"]["image"];
        notiBtnName = message["data"]["btnName"];
        notiBtnAction = message["data"]["btnAction"];
        return showDialog(
            context: context,
            builder: (_) {
              return NotificationDialog(
                title: '$notiTitle',
                body: '$notiBody',
                img: '$notiImage',
                btnAction: '$notiBtnAction',
                btnName: '$notiBtnName',
              );
            });
      },
      onLaunch: (Map<dynamic, dynamic> message) async {
        notiTitle = message["data"]["title"];
        notiBody = message["data"]["body"];
        notiImage = message["data"]["image"];
        notiBtnName = message["data"]["btnName"];
        notiBtnAction = message["data"]["btnAction"];
        return showDialog(
            context: context,
            builder: (_) {
              return NotificationDialog(
                title: '$notiTitle',
                body: '$notiBody',
                img: '$notiImage',
                btnAction: '$notiBtnAction',
                btnName: '$notiBtnName',
              );
            });
      },
    );
  }

  void versionCheck() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));

    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    try {
      await remoteConfig.fetch();
      await remoteConfig.activateFetched();
      remoteConfig.getString('force_update_current_version');
      double newVersion = double.parse(remoteConfig
          .getString('force_update_current_version')
          .trim()
          .replaceAll(".", ""));

      if (newVersion > currentVersion) {
        setState(() {
          visinew = true;
        });
        _showVersionDialog(context);
      }
    } on FetchThrottledException catch (exception) {
      Text('$exception - ****************exception check');
    } catch (exception) {}
  }

  _showVersionDialog(context) async {
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
                  TextButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(playStoreUrl),
                  ),
                  TextButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            : AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  TextButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(playStoreUrl),
                  ),
                  TextButton(
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
    versionCheck();
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
                _showSnackbar();
              } else if (v == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactDev()));
              } else if (v == 2) {
                Share.share(
                    'Hi dev, kindly download this app to check hashnode featured, best, new'
                    ', and community articles with ease --> $playStoreUrl');
              } else if (v == 3) {
                launch(playStoreUrl);
              } else if (v == 4) {
                launch('https://api.hashnode.com/');
              } else {
                showLicensePage(
                  context: context,
                  applicationVersion: '1.0.2',
                  applicationName: 'Hashnode App build with flutter',
                  applicationIcon: Image.asset(
                    'assets/logo.jpg',
                    height: 32,
                    width: 32,
                  ),
                );
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
              PopupMenuItem(
                child: Text('View License'),
                value: 5,
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

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Coming Soon...'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () =>
              ScaffoldMessenger.of(context).removeCurrentSnackBar(),
        ),
      ),
    );
  }
}
