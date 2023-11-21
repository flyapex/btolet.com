// import 'package:facebook_audience_network/facebook_audience_network.dart';
// import 'package:get/get.dart';

// class AdsControllerF extends GetxController {
//   bool _isRewardedAdLoaded = false;
//   void _loadRewardedVideoAd() {
//     FacebookRewardedVideoAd.loadRewardedVideoAd(
//       placementId: "YOUR_PLACEMENT_ID",
//       listener: (result, value) {
//         print("Rewarded Ad: $result --> $value");
//         if (result == RewardedVideoAdResult.LOADED) {
//           _isRewardedAdLoaded = true;
//         }
//         if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
//           print("Show Number");
//         }

//         if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
//             (value == true || value["invalidated"] == true)) {
//           _isRewardedAdLoaded = false;
//           _loadRewardedVideoAd();
//         }
//       },
//     );
//   }

//   _showRewardedAd() {
//     if (_isRewardedAdLoaded == true) {
//       FacebookRewardedVideoAd.showRewardedVideoAd();
//     } else {
//       print("Rewarded Ad not yet loaded!");
//     }
//   }
// }
