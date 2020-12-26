import 'package:flutter/material.dart';
import 'package:hashnode/theme/colors.dart';
import 'package:hashnode/theme/style.dart';
import 'best.dart';
import 'community.dart';
import 'featured.dart';
import 'new.dart';

class HomePgae extends StatefulWidget {
  HomePgae({Key key}) : super(key: key);

  @override
  _HomePgaeState createState() => _HomePgaeState();
}

class _HomePgaeState extends State<HomePgae> with TickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 4, vsync: this);
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
            onSelected: (v) {},
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Settings'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('About.'),
                value: 0,
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
      body: TabBarView(
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
}
