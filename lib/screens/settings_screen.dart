import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/premium_provider.dart';
import '../services/iap_service.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final premiumProvider = Provider.of<PremiumProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(l10n.darkMode),
            value: themeProvider.isDarkMode,
            onChanged: premiumProvider.isPremium
                ? themeProvider.toggleTheme
                : null,
            subtitle: !premiumProvider.isPremium
                ? Text(
                    l10n.premiumOnly,
                    style: const TextStyle(color: Colors.grey),
                  )
                : null,
          ),
          ListTile(
            title: Text(l10n.language),
            subtitle: !premiumProvider.isPremium
                ? Text(
                    l10n.premiumOnly,
                    style: const TextStyle(color: Colors.grey),
                  )
                : null,
            trailing: DropdownButton<String>(
              value: localeProvider.locale.languageCode,
              items: const [
                DropdownMenuItem(value: 'es', child: Text('Español')),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
              onChanged: premiumProvider.isPremium
                  ? (value) {
                      if (value != null) {
                        localeProvider.setLocale(Locale(value));
                      }
                    }
                  : null,
            ),
          ),
          const Divider(),
          if (!premiumProvider.isPremium) ...[
            ListTile(
              title: Text(l10n.buyPremium),
              trailing: const Icon(Icons.lock_open),
              onTap: () => IAPService.buyPremium(context),
            ),
            ListTile(
              title: Text(l10n.restorePurchase),
              trailing: const Icon(Icons.restore),
              onTap: () => IAPService.restorePurchase(context),
            ),
            // ✅ Botón para activar Premium temporalmente
            ListTile(
              title: Text("Activar Premium Temporal"),
              trailing: const Icon(Icons.timer),
              onTap: () {
                premiumProvider.setPremium(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Premium activado temporalmente")),
                );
              },
            ),
          ] else ...[
            ListTile(
              title: Text(l10n.premiumActive),
              leading: const Icon(Icons.verified, color: Colors.green),
            ),
          ],
        ],
      ),
    );
  }
}
