import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/banner/banner_model.dart';

class BannerNetwork {
  static const String banner1Url = "auth-api.php/getHomeBanner1";
  static const String banner2Url = "auth-api.php/getHomeBanner2";
  static const String sponsorBannerUrl = "auth-api.php/getSponsorBanner";
  static Future<dynamic> getBanner1() async {
    final result = await httpManager.post(
      url: banner1Url,
    );

    BannerRes loginRes = BannerRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> getBanner2() async {
    final result = await httpManager.post(
      url: banner2Url,
    );

    BannerRes loginRes = BannerRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> getSponsorBanner() async {
    final result = await httpManager.post(
      url: sponsorBannerUrl,
    );

    BannerRes loginRes = BannerRes.fromJson(result);
    return loginRes;
  }
}
