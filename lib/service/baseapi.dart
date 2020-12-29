import 'package:hashnode/models/bestmodel.dart';
import 'package:hashnode/models/communitymodel.dart';
import 'package:hashnode/models/featuredmodel.dart';
import 'package:hashnode/models/newmodel.dart';

abstract class BaseApi {
  Future<FeaturedModel> featuredListApi();
  Future<CommunityModel> communityListApi();
  Future<BestModel> bestListApi();
  Future<NewModel> newListApi();
}
