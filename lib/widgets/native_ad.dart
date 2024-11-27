import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdsScreen extends StatefulWidget {
  const NativeAdsScreen({super.key});

  @override
  State<NativeAdsScreen> createState() => _NativeAdsScreenState();
}

class _NativeAdsScreenState extends State<NativeAdsScreen> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nativeAd?.dispose();
  }

  /// Loads a native ad.
  void loadAd() {
    _nativeAd = NativeAd(
        adUnitId: _adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.white,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.white,
                backgroundColor: Colors.orange,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.orange,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black54,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black54,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _nativeAdIsLoaded ? ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 320, // minimum recommended width
          minHeight: 320, // minimum recommended height
          maxWidth: 400,
          maxHeight: 400,
        ),
        child: AdWidget(ad: _nativeAd!),
      ): CircularProgressIndicator(),
    );
  }
}

// class NativeAdExample extends StatefulWidget {
//   const NativeAdExample({super.key});
//
//   @override
//   _NativeAdExampleState createState() => _NativeAdExampleState();
// }
//
// class _NativeAdExampleState extends State<NativeAdExample> {
//   NativeAd? _nativeAd;
//   bool _isAdLoaded = false;
//   // bool _nativeAdIsLoaded = false;
//
//   final String _adUnitId = 'YOUR_AD_UNIT_ID'; // Replace with your actual ad unit ID
//
//   @override
//   void initState() {
//     super.initState();
//     loadNativeAd();
//   }
//
//   void loadNativeAd() {
//     /// Loads a native ad.
//     void loadAd() {
//       _nativeAd = NativeAd(
//           adUnitId: _adUnitId,
//           listener: NativeAdListener(
//             onAdLoaded: (ad) {
//               print('$NativeAd loaded.');
//               setState(() {
//                 _isAdLoaded = true;
//               });
//             },
//             onAdFailedToLoad: (ad, error) {
//               // Dispose the ad here to free resources.
//               print('$NativeAd failedToLoad: $error');
//               ad.dispose();
//             },
//             // Called when a click is recorded for a NativeAd.
//             onAdClicked: (ad) {},
//             // Called when an impression occurs on the ad.
//             onAdImpression: (ad) {},
//             // Called when an ad removes an overlay that covers the screen.
//             onAdClosed: (ad) {},
//             // Called when an ad opens an overlay that covers the screen.
//             onAdOpened: (ad) {},
//             // For iOS only. Called before dismissing a full screen view
//             onAdWillDismissScreen: (ad) {},
//             // Called when an ad receives revenue value.
//             onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
//           ),
//           request: const AdRequest(),
//           // Styling
//           nativeTemplateStyle: NativeTemplateStyle(
//             // Required: Choose a template.
//               templateType: TemplateType.medium,
//               // Optional: Customize the ad's style.
//               mainBackgroundColor: Colors.purple,
//               cornerRadius: 10.0,
//               callToActionTextStyle: NativeTemplateTextStyle(
//                   textColor: Colors.cyan,
//                   backgroundColor: Colors.red,
//                   style: NativeTemplateFontStyle.monospace,
//                   size: 16.0),
//               primaryTextStyle: NativeTemplateTextStyle(
//                   textColor: Colors.red,
//                   backgroundColor: Colors.cyan,
//                   style: NativeTemplateFontStyle.italic,
//                   size: 16.0),
//               secondaryTextStyle: NativeTemplateTextStyle(
//                   textColor: Colors.green,
//                   backgroundColor: Colors.black,
//                   style: NativeTemplateFontStyle.bold,
//                   size: 16.0),
//               tertiaryTextStyle: NativeTemplateTextStyle(
//                   textColor: Colors.brown,
//                   backgroundColor: Colors.amber,
//                   style: NativeTemplateFontStyle.normal,
//                   size: 16.0)))
//         ..load();
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _isAdLoaded
//             ? buildNativeAd(_nativeAd!)
//             : const CircularProgressIndicator(),
//       ),
//     );
//   }
//
//   Widget buildNativeAd(NativeAd ad) {
//     return Column(
//       children: [
//         Text(ad.    ad.   .mediaContent!.headline!),
//         Text(ad.body!),
//         Image.network(ad.mediaContent!.images![0].url!),
//         ElevatedButton(
//           onPressed: () {
//             ad.handleClick();
//           },
//           child: Text(ad.callToAction!.text),
//         ),
//       ],
//     );
//   }
//
//   // Widget buildNativeAd(NativeAd ad) {
//   //   return Column(
//   //     children: [
//   //       Text(ad.headline!),
//   //       Text(ad.body!),
//   //       Image.network(ad.images![0].url!),
//   //       ElevatedButton(
//   //         onPressed: () {
//   //           ad.handleClick();
//   //         },
//   //         child: Text(ad.callToAction!.text),
//   //       ),
//   //     ],
//   //   );
//   // }
//
//   @override
//   void dispose() {
//     _nativeAd?.dispose();
//     super.dispose();
//   }
// }
