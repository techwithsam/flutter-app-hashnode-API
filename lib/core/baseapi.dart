import 'models/communitymodel.dart';
import 'models/featuredmodel.dart';
import 'models/bestmodel.dart';
import 'models/newmodel.dart';

abstract class BaseApi {
  Future<FeaturedModel> featuredListApi();
  Future<CommunityModel> communityListApi();
  Future<BestModel> bestListApi();
  Future<NewModel> newListApi();
}
