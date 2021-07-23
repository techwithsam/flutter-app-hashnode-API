class FeaturedModel {
  Data? data;

  FeaturedModel({this.data});

  FeaturedModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<StoriesFeed>? storiesFeed;

  Data({this.storiesFeed});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['storiesFeed'] != null) {
      List<StoriesFeed> _storiesFeed = [];
      storiesFeed = _storiesFeed;
      json['storiesFeed'].forEach((v) {
        storiesFeed!.add(new StoriesFeed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storiesFeed != null) {
      data['storiesFeed'] = this.storiesFeed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoriesFeed {
  String? title;
  Author? author;
  String? coverImage;
  String? slug;
  int? replyCount;

  StoriesFeed(
      {this.title, this.author, this.coverImage, this.slug, this.replyCount});

  StoriesFeed.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    coverImage = json['coverImage'];
    slug = json['slug'];
    replyCount = json['replyCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['coverImage'] = this.coverImage;
    data['slug'] = this.slug;
    data['replyCount'] = this.replyCount;
    return data;
  }
}

class Author {
  String? name;
  String? photo;
  String? username;

  Author({this.name, this.photo, this.username});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['username'] = this.username;
    return data;
  }
}
