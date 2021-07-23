import 'package:flutter/material.dart';
import 'package:hashnode/core/api.dart';
import 'package:hashnode/core/models/newmodel.dart';
import 'package:hashnode/functions/customFunc.dart';
import 'package:hashnode/functions/locator.dart';
import 'package:hashnode/functions/webview.dart';
import 'package:hashnode/style/style.dart';
import 'package:hashnode/style/text.dart';
import 'package:hashnode/widget/lists.dart';

var callApi = locator<Api>();
var func = locator<CustomFunction>();

class NewPage extends StatefulWidget {
  NewPage({Key key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future newArc;

  @override
  void initState() {
    super.initState();
    newArc = callApi.newListApi();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Center(
          child: SingleChildScrollView(
            child: getApi(),
          ),
        ),
      ),
    );
  }

  Future<Null> _refresh() async {
    setState(() {
      newArc = callApi.newListApi();
    });
  }

  getApi() {
    return FutureBuilder<NewModel>(
        future: newArc,
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
                return Text(
                  CustomText().apiErr,
                  style: AppTextStyle().errStyle,
                );
              } else if (lists.hasData) {
                if (lists.data.data == null) {
                  return Center(
                      child: Text(
                    CustomText().zeroAct,
                    style: AppTextStyle().errStyle,
                  ));
                } else {
                  return list(lists.data);
                }
              } else {
                return Text(
                  CustomText().noInt,
                  style: AppTextStyle().errStyle,
                );
              }
              break;
          }
          return Text('');
        });
  }

  list(NewModel data) {
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
