class BannerRes {
  List<BannerData>? data;

  BannerRes({this.data});

  BannerRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(BannerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerData {
  String? id;
  String? bannerImage;
  String? bannerLink;
  String? createdAt;

  BannerData({this.id, this.bannerImage, this.bannerLink, this.createdAt});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImage = json['banner_image'];
    bannerLink = json['banner_link'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner_image'] = bannerImage;
    data['banner_link'] = bannerLink;
    data['created_at'] = createdAt;
    return data;
  }
}
