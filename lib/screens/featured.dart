import 'package:flutter/material.dart';
import 'package:hashnode/core/api.dart';
import 'package:hashnode/core/models/featuredmodel.dart';
import 'package:hashnode/functions/locator.dart';
import 'package:hashnode/functions/webview.dart';
import 'package:hashnode/style/style.dart';
import 'package:hashnode/style/text.dart';
import 'package:hashnode/widget/lists.dart';

var callApi = locator<Api>();

class FeaturedPage extends StatefulWidget {
  FeaturedPage({Key? key}) : super(key: key);

  @override
  _FeaturedPageState createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<FeaturedModel>? featured;

  @override
  void initState() {
    super.initState();
    featured = callApi.featuredListApi() as Future<FeaturedModel>?;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState!.show());
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
      featured = callApi.featuredListApi() as Future<FeaturedModel>?;
    });
  }

  getApi() {
    return FutureBuilder<FeaturedModel>(
        future: featured,
        builder: (context, lists) {
          switch (lists.connectionState) {
            case ConnectionState.none:
              return Text('');

            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(strokeWidth: 1.1));

            case ConnectionState.active:
              return Text('');

            case ConnectionState.done:
              if (lists.hasError) {
                return Text(
                  CustomText().apiErr,
                  style: AppTextStyle().errStyle,
                );
              } else if (lists.hasData) {
                if (lists.data!.data == null) {
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
          }
        });
  }

  list(FeaturedModel? data) {
    return ListView.builder(
      itemCount: data!.data!.storiesFeed!.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlogViews(
                          title: data.data!.storiesFeed![index].title,
                          urli:
                              'https://${data.data!.storiesFeed![index].author!.username}.hashnode.dev/${data.data!.storiesFeed![index].slug}',
                        )));
          },
          child: BlogList(
            commt: data.data!.storiesFeed![index].replyCount,
            img: data.data!.storiesFeed![index].coverImage,
            title: data.data!.storiesFeed![index].title,
            uname: data.data!.storiesFeed![index].author!.username,
            name: data.data!.storiesFeed![index].author!.name,
          ),
        );
      },
    );
  }
}
