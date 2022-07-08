import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashnode/functions/customFunc.dart';
import 'package:hashnode/functions/locator.dart';
import 'package:hashnode/style/colors.dart';
import 'package:hashnode/style/style.dart';
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
  HomePgae({Key? key}) : super(key: key);

  @override
  _HomePgaeState createState() => _HomePgaeState();
}

class _HomePgaeState extends State<HomePgae> with TickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? _nestedTabController;
  bool chinternet = true, visinew = false;

  @override
  void initState() {
    super.initState();
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
    _nestedTabController!.dispose();
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
