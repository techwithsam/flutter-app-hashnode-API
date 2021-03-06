import 'package:flutter/material.dart';
import 'package:hashnode/functions/locator.dart';
import 'package:hashnode/functions/webview.dart';
import 'package:hashnode/models/bestmodel.dart';
import 'package:hashnode/service/api.dart';
import 'package:hashnode/theme/style.dart';
import 'package:hashnode/theme/text.dart';
import 'package:hashnode/widget/lists.dart';

var callApi = locator<Api>();

class BestPage extends StatefulWidget {
  BestPage({Key key}) : super(key: key);

  @override
  _BestPageState createState() => _BestPageState();
}

class _BestPageState extends State<BestPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<BestModel> best;

  @override
  void initState() {
    super.initState();
    best = callApi.bestListApi();
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
      best = callApi.bestListApi();
    });
  }

  getApi() {
    return FutureBuilder<BestModel>(
        future: best,
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

  list(BestModel data) {
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
