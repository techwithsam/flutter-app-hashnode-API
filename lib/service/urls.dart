class BaseUrl {
  static String main = 'https://api.hashnode.com/';
  final String featuredUrl =
      '$main?query={storiesFeed(type:FEATURED){title,author{name,photo,username},coverImage,slug,dateFeatured,replyCount}}';
  final String communityUrl =
      '$main?query={storiesFeed(type:COMMUNITY){title,author{name,photo,username},coverImage,slug,replyCount}}';
  final String bestUrl =
      '$main?query={storiesFeed(type:BEST){title,author{name,photo,username},coverImage,slug,replyCount}}';
  final String newUrl =
      '$main?query={storiesFeed(type:NEW){title,author{name,photo,username},coverImage,slug,replyCount}}';
}
