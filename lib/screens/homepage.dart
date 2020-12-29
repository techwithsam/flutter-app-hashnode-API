import 'package:flutter/material.dart';
import 'package:hashnode/functions/customFunc.dart';
import 'package:hashnode/functions/locator.dart';
import 'package:hashnode/theme/colors.dart';
import 'package:hashnode/theme/style.dart';
import 'package:hashnode/widget/noInt.dart';
import 'best.dart';
import 'community.dart';
import 'featured.dart';
import 'new.dart';

var func = locator<CustomFunction>();

class HomePgae extends StatefulWidget {
  HomePgae({Key key}) : super(key: key);

  @override
  _HomePgaeState createState() => _HomePgaeState();
}

class _HomePgaeState extends State<HomePgae> with TickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _nestedTabController;
  bool chinternet = true;

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
            // icon: Icon(
            //   Icons.more_vert,
            //   color: AppColor().mainColor,
            // ),
            onSelected: (v) {
              if (v == 0) {
                func.showToast(message: 'Coming soon...');
              } else if (v == 1) {
                print('fdjkdjfd');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Settings'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('About.'),
                value: 1,
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
