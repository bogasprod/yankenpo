import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  AdService() {
    loadBanner();
  }

  void loadBanner() {
    _bannerAd = BannerAd(
      adUnitId: 'TU_AD_UNIT_ID',  // Cambia aquí por tu ad unit real
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _isLoaded = true;
          // Si usas State Management, aquí podrías notificar que el ad está listo
          print('Banner cargado');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          _isLoaded = false;
          print('Error al cargar banner: $error');
        },
      ),
    );

    _bannerAd!.load();
  }

  Widget bannerAdWidget() {
    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }

  void dispose() {
    _bannerAd?.dispose();
  }
}
