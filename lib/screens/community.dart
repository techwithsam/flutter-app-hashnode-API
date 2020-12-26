import 'package:flutter/material.dart';
import 'package:hashnode/functions/locator.dart';
import 'package:hashnode/functions/webview.dart';
import 'package:hashnode/models/CommunityModel.dart';
import 'package:hashnode/service/api.dart';
import 'package:hashnode/widget/lists.dart';

var callApi = locator<Api>();

class CommunityPage extends StatefulWidget {
  CommunityPage({Key key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  Future community;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: _getApi(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    community = callApi.communityListApi();
  }

  _getApi() {
    return FutureBuilder<CommunityModel>(
        future: community,
        builder: (context, lists) {
          switch (lists.connectionState) {
            case ConnectionState.none:
              return Text('');
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(strokeWidth: 1.1));
              break;
            case ConnectionState.active:
              return Text('');
              break;
            case ConnectionState.done:
              if (lists.hasError) {
                return Text('Unable to get list, Retry!',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold));
              } else if (lists.hasData) {
                if (lists.data.data == null) {
                  return Center(
                      child: Text(
                    'Oops! No Testimonies Found!',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ));
                } else {
                  return _list(lists.data);
                }
              } else {
                return Text('No Internet Connection');
              }
              break;
          }
          return Text('');
        });
  }

  _list(CommunityModel data) {
    return ListView.builder(
      itemCount: data.data.storiesFeed.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlogViews(
                          title: data.data.storiesFeed[index].title,
                          urli:
                              'https://${data.data.storiesFeed[index].author.username}.hashnode.dev/${data.data.storiesFeed[index].slug}',
                        )));
          },
          child: BlogList(
            commt: data.data.storiesFeed[index].replyCount,
            img: data.data.storiesFeed[index].coverImage,
            title: data.data.storiesFeed[index].title,
            uname: data.data.storiesFeed[index].author.username,
            name: data.data.storiesFeed[index].author.name,
          ),
        );
      },
    );
  }
}
