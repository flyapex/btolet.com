import 'dart:convert';
import 'dart:io';

import 'package:btolet/api/google%20ads/ad_helper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsController extends GetxController {
  //----------------------Google ads
  static const AdRequest request = AdRequest();

  int maxFailedLoadAttempts = 3;
  int life = 0;
  // bool _isBannerAdReady = false;

  InterstitialAd? interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd? rewardedAd;
  int _numRewardedLoadAttempts = 0;

  RewardedInterstitialAd? rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdHelper.rewardedAdUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              createRewardedAd();
            } else {}
          },
        ));
  }

  void createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: AdHelper.rewardedInterstitialAd,
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            print('$ad loaded.');
            rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
            rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createRewardedInterstitialAd();
            }
          },
        ));
  }

  // Showing ads from here
  void showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  void showRewardedAd(val) async {
    if (rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      final call = Uri.parse('tel:$val');
      launchUrl(call);
      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    rewardedAd!.setImmersiveMode(true);
    rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        life += 1;
        //xxx
        final call = Uri.parse('tel:$val');
        launchUrl(call);
      },
    );

    rewardedAd = null;
  }

  Future<void> shareBase64Image(String base64Image) async {
    try {
      // Get temporary directory
      final tempDir = await getTemporaryDirectory();

      // Create temporary file
      final file = File('${tempDir.path}/image.jpg');

      // Decode Base64 string and write to file
      await file.writeAsBytes(base64Decode(base64Image));

      // Share the file using share_plus
      // await Share.shareFiles([file.path]);

      // Delete the temporary file after sharing
      file.delete();
    } catch (e) {
      print('Error sharing image: $e');
    }
  }

  void showRewardedInterstitialAd(val, message) async {
    if (rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');

      val = '+88$val';
      await launchUrl(
          Uri.parse("whatsapp://send?phone=$val&text=${Uri.parse(message)}"));

      return;
    }
    rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedInterstitialAd();
      },
    );

    rewardedInterstitialAd!.setImmersiveMode(true);
    rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      val = '+88$val';
      await launchUrl(
          Uri.parse("whatsapp://send?phone=$val&text=${Uri.parse(message)}"));
    });
    rewardedInterstitialAd = null;
  }

//----------------------Facebook Ads

  // bool _isRewardedAdLoaded = false;
  // void _loadRewardedVideoAd() {
  //   FacebookRewardedVideoAd.loadRewardedVideoAd(
  //     placementId: "YOUR_PLACEMENT_ID",
  //     listener: (result, value) {
  //       print("Rewarded Ad: $result --> $value");
  //       if (result == RewardedVideoAdResult.LOADED) {
  //         _isRewardedAdLoaded = true;
  //       }
  //       if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
  //         print("Show Number");
  //       }

  //       if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
  //           (value == true || value["invalidated"] == true)) {
  //         _isRewardedAdLoaded = false;
  //         _loadRewardedVideoAd();
  //       }
  //     },
  //   );
  // }

  // _showRewardedAd() {
  //   if (_isRewardedAdLoaded == true) {
  //     FacebookRewardedVideoAd.showRewardedVideoAd();
  //   } else {
  //     print("Rewarded Ad not yet loaded!");
  //   }
  // }
}
