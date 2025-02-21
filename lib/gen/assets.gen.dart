/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/AR.png
  AssetGenImage get ar => const AssetGenImage('assets/icons/AR.png');

  /// File path: assets/icons/ENG.png
  AssetGenImage get eng => const AssetGenImage('assets/icons/ENG.png');

  /// File path: assets/icons/appLogo.png
  AssetGenImage get appLogo => const AssetGenImage('assets/icons/appLogo.png');

  /// File path: assets/icons/routeLogo.png
  AssetGenImage get routeLogo =>
      const AssetGenImage('assets/icons/routeLogo.png');

  /// List of all assets
  List<AssetGenImage> get values => [ar, eng, appLogo, routeLogo];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/MoviesPostersGroup.png
  AssetGenImage get moviesPostersGroup =>
      const AssetGenImage('assets/images/MoviesPostersGroup.png');

  /// File path: assets/images/forgotPassword.png
  AssetGenImage get forgotPassword =>
      const AssetGenImage('assets/images/forgotPassword.png');

  /// File path: assets/images/login.png
  AssetGenImage get login => const AssetGenImage('assets/images/login.png');

  /// File path: assets/images/onBoarding1.png
  AssetGenImage get onBoarding1 =>
      const AssetGenImage('assets/images/onBoarding1.png');

  /// File path: assets/images/onBoarding2.png
  AssetGenImage get onBoarding2 =>
      const AssetGenImage('assets/images/onBoarding2.png');

  /// File path: assets/images/onBoarding3.png
  AssetGenImage get onBoarding3 =>
      const AssetGenImage('assets/images/onBoarding3.png');

  /// File path: assets/images/onBoarding4.png
  AssetGenImage get onBoarding4 =>
      const AssetGenImage('assets/images/onBoarding4.png');

  /// File path: assets/images/onBoarding5.png
  AssetGenImage get onBoarding5 =>
      const AssetGenImage('assets/images/onBoarding5.png');

  /// File path: assets/images/register.png
  AssetGenImage get register =>
      const AssetGenImage('assets/images/register.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    moviesPostersGroup,
    forgotPassword,
    login,
    onBoarding1,
    onBoarding2,
    onBoarding3,
    onBoarding4,
    onBoarding5,
    register,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
