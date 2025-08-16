import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import '../providers/premium_provider.dart';
import '../l10n/app_localizations.dart';

class IAPService {
  static final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  static ProductDetails? _product;
  static bool _initialized = false;
  static StreamSubscription<List<PurchaseDetails>>? _subscription;

  static Future<void> init(BuildContext context) async {
    if (_initialized) return;

    // ⚠️ Extraemos el provider antes de cualquier await para evitar warning
    final provider = Provider.of<PremiumProvider>(context, listen: false);

    final available = await _inAppPurchase.isAvailable();
    if (!available) return;

    const Set<String> productIds = {'premium_upgrade'};
    final response = await _inAppPurchase.queryProductDetails(productIds);

    if (response.notFoundIDs.isNotEmpty || response.productDetails.isEmpty) {
      debugPrint('Producto no encontrado o vacío');
      return;
    }

    _product = response.productDetails.first;
    provider.setProduct(_product);

    _listenToPurchases(provider);

    _initialized = true;
  }

  static void _listenToPurchases(PremiumProvider provider) {
    _subscription?.cancel();
    _subscription = _inAppPurchase.purchaseStream.listen((purchases) {
      for (final purchase in purchases) {
        if (purchase.productID == 'premium_upgrade' &&
            purchase.status == PurchaseStatus.purchased) {
          provider.activatePremium();
          _inAppPurchase.completePurchase(purchase);
        }
      }
    });
  }

  static Future<void> buyPremium(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    if (_product == null) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.errorPurchasing)),
      );
      return;
    }

    final purchaseParam = PurchaseParam(productDetails: _product!);
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  static Future<void> restorePurchase(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final provider = Provider.of<PremiumProvider>(context, listen: false);

    final available = await _inAppPurchase.isAvailable();
    if (!available) return;

    bool found = false;
    await for (final purchaseDetails in _inAppPurchase.purchaseStream) {
      for (final purchase in purchaseDetails) {
        if (purchase.productID == 'premium_upgrade' &&
            purchase.status == PurchaseStatus.purchased) {
          provider.activatePremium();
          _inAppPurchase.completePurchase(purchase);
          found = true;
        }
      }
      if (found) break;
    }

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          found ? l10n.purchaseRestored : l10n.googlePlayAutoRestore,
        ),
      ),
    );
  }

  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
