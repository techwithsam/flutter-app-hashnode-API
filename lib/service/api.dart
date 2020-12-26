import 'dart:convert';
import 'package:hashnode/functions/locator.dart';
import 'package:hashnode/models/communitymodel.dart';
import 'package:hashnode/models/featuredmodel.dart';
import 'package:hashnode/service/urls.dart';
import 'package:http/http.dart' as http;
import 'baseapi.dart';

var url = locator<BaseUrl>();

class Api extends BaseApi {
  @override
  Future<FeaturedModel> featuredListApi() async {
    var response = await http.get(url.featuredUrl);

    var decode = json.decode(response.body);
    if (decode != null) {
      FeaturedModel list = FeaturedModel.fromJson(decode);
      return list;
    } else {
      return null;
    }
  }

  @override
  Future<CommunityModel> communityListApi() async {
    var response = await http.get(url.communityUrl);

    var decode = json.decode(response.body);
    if (decode != null) {
      CommunityModel list = CommunityModel.fromJson(decode);
      return list;
    } else {
      return null;
    }
  }
}
