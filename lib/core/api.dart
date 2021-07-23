import 'dart:convert';
import 'package:hashnode/core/models/bestmodel.dart';
import 'package:hashnode/core/models/communitymodel.dart';
import 'package:hashnode/core/models/featuredmodel.dart';
import 'package:hashnode/core/models/newmodel.dart';
import 'package:hashnode/core/urls.dart';
import 'package:hashnode/functions/locator.dart';
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
      CommunityModel listi = CommunityModel.fromJson(decode);
      return listi;
    } else {
      return null;
    }
  }

  @override
  Future<BestModel> bestListApi() async {
    var response = await http.get(url.bestUrl);

    var decode = json.decode(response.body);
    if (decode != null) {
      BestModel listi = BestModel.fromJson(decode);
      return listi;
    } else {
      return null;
    }
  }

  @override
  Future<NewModel> newListApi() async {
    var response = await http.get(url.newUrl);

    var decode = json.decode(response.body);
    if (decode != null) {
      NewModel listi = NewModel.fromJson(decode);
      return listi;
    } else {
      return null;
    }
  }
}
