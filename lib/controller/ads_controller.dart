import 'dart:convert';
import 'dart:io';
import 'package:btolet/api/google%20ads/ad_helper.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:btolet/view/tolet/single_post.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

ToletController toletController = Get.find();

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

  void showRewardedAd(String type, phone) async {
    var message =
        '''Hey there👋! I saw your sweet listing on btolet App(btolet.com) - is it still up for Rent? I'm super interested. 😊 Please let me know what you think.''';
    if (rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      if (type == "call") {
        final call = Uri.parse('tel:$phone');
        launchUrl(call);
      } else if (type == "sms") {
        final sms = Uri.parse('sms:$phone?body=${Uri.parse(message)}');
        launchUrl(sms);
      } else if (type == 'wapp') {
        phone = '+88$phone';

        await launchUrl(Uri.parse(
            "whatsapp://send?phone=$phone&text=${Uri.parse(message)}"));
      } else if (type == 'ads') {
        print('ads');
      }

      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        print('ad onAdShowedFullScreenContent.   xx');
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        print('$ad onAdDismissedFullScreenContent.   yy');
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
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
        print('$ad onAdDismissedFullScreenContent.   zzz');
        var message =
            '''Hey there👋! I saw your sweet listing on btolet - is it still up for Rent? I'm super interested. 😊 Please let me know what you think.''';
        Get.back();
        print('----------------');
        life += 1;
        if (type == "call") {
          final call = Uri.parse('tel:$phone');
          launchUrl(call);
        } else if (type == "sms") {
          final sms = Uri.parse('sms:$phone?body=${Uri.parse(message)}');
          launchUrl(sms);
        } else if (type == 'wapp') {
          phone = '+88$phone';

          await launchUrl(Uri.parse(
              "whatsapp://send?phone=$phone&text=${Uri.parse(message)}"));
        } else if (type == 'ads') {
          print('ads');
        }
      },
    );

    rewardedAd = null;
  }

  void showRewardedInterstitialAd(String type, data) async {
    if (rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');

      var message =
          '''Hey there👋! I saw your sweet listing on btolet App(btolet.com) - is it still up for Rent? I'm super interested. 😊 Please let me know what you think.''';
      if (type == "call") {
        final call = Uri.parse('tel:$data');
        launchUrl(call);
      } else if (type == "sms") {
        data = '+88$data';
        final sms = Uri.parse('sms:$data?body=${Uri.parse(message)}');
        launchUrl(sms);
      } else if (type == 'wapp') {
        data = '+88$data';

        await launchUrl(Uri.parse(
            "whatsapp://send?phone=$data&text=${Uri.parse(message)}"));
      } else if (type == 'ads') {
        print('ads');
        toletController.singlePostloding(true);
        Get.to(
          () => SinglePostTolet(
            postid: data,
          ),
          transition: Transition.circularReveal,
          duration: const Duration(milliseconds: 600),
          preventDuplicates: false,
        );
      }

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
      var message =
          '''Hey there👋! I saw your sweet listing on btolet App(btolet.com) - is it still up for Rent? I'm super interested. 😊 Please let me know what you think.''';
      if (type == "call") {
        final call = Uri.parse('tel:$data');
        launchUrl(call);
      } else if (type == "sms") {
        data = '+88$data';
        final sms = Uri.parse('sms:$data?body=${Uri.parse(message)}');
        launchUrl(sms);
      } else if (type == 'wapp') {
        data = '+88$data';

        await launchUrl(Uri.parse(
            "whatsapp://send?phone=$data&text=${Uri.parse(message)}"));
      } else if (type == 'ads') {
        print('ads');
        toletController.singlePostloding(true);
        Get.to(
          () => SinglePostTolet(
            postid: data,
          ),
          transition: Transition.circularReveal,
          duration: const Duration(milliseconds: 600),
          preventDuplicates: false,
        );
      }
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

  Future<void> shareBase64Image(String base64Image, text) async {
    try {
      // Decode base64 image to bytes
      Uint8List bytes =
          const Base64Decoder().convert(base64Image.split(',').last);

      // Create a temporary file to share
      // Note: You can use other methods to share images as well
      final tempDir = await getTemporaryDirectory();
      final tempFile = await File('${tempDir.path}/image.png').create();
      await tempFile.writeAsBytes(bytes);

      // ignore: deprecated_member_use
      await Share.shareFiles(
        [tempFile.path],
        text: text,
        subject: 'Image Sharing',
      );
      await tempFile.delete();
    } catch (e) {
      print('Error sharing image: $e');
    }

    // try {
    //   final tempDir = await getTemporaryDirectory();
    //   final file = File('${tempDir.path}/image.jpg');
    //   await file.writeAsBytes(base64Decode(base64Image));
    //   file.delete();
    // } catch (e) {
    //   print('Error sharing image: $e');
    // }
  }
}
