import 'package:hashnode/models/communitymodel.dart';
import 'package:hashnode/models/featuredmodel.dart';

abstract class BaseApi {
  Future<FeaturedModel> featuredListApi();
  Future<CommunityModel> communityListApi();
}
