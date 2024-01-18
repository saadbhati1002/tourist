import 'package:tourist/api/network/banner/banner.dart';

class BannerRepository {
  Future<dynamic> getBanner1ApiCall() async {
    return await BannerNetwork.getBanner1();
  }

  Future<dynamic> getBanner2ApiCall() async {
    return await BannerNetwork.getBanner2();
  }

  Future<dynamic> getSponsorBannerApiCall() async {
    return await BannerNetwork.getSponsorBanner();
  }
}
