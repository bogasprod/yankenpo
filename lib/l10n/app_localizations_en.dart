// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get noMoreAttempts => 'No more attempts available';

  @override
  String get machineChose => 'Machine chose';

  @override
  String get youChose => 'You chose';

  @override
  String get selectDifficulty => 'Select Difficulty';

  @override
  String get appTitle => 'Yan Ken Po';

  @override
  String get freeVersion => 'Free Version';

  @override
  String get play => 'Play';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get about => 'About';

  @override
  String get gameLevel => 'Game Level';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get premiumRequired => 'Premium required';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get premiumVersion => 'Premium Version';

  @override
  String get restorePurchase => 'Restore Purchase';

  @override
  String get purchaseRestored => 'Purchase restored successfully';

  @override
  String get googlePlayAutoRestore => 'Google Play will automatically restore your purchase';

  @override
  String get selectMove => 'Select your move';

  @override
  String get rock => 'Rock';

  @override
  String get paper => 'Paper';

  @override
  String get scissors => 'Scissors';

  @override
  String get youWin => 'You win!';

  @override
  String get youLose => 'You lose!';

  @override
  String get draw => 'Draw!';

  @override
  String attemptsLeft(Object count) {
    return 'Attempts left: $count';
  }

  @override
  String get noAttempts => 'No more attempts. Upgrade to continue.';

  @override
  String get aboutApp => 'About App';

  @override
  String get version => 'Version';

  @override
  String get author => 'Author';

  @override
  String get contact => 'Contact';

  @override
  String get gameTitle => 'Yan Ken Po - Game';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get difficultMode => 'Activate Difficult Mode';

  @override
  String get you => 'You';

  @override
  String get machine => 'Machine';

  @override
  String get advanced => 'Advanced';

  @override
  String get wins => 'Wins';

  @override
  String get start => 'Start';

  @override
  String get premium => 'Premium';

  @override
  String get buyPremium => 'Buy Premium';

  @override
  String get premiumActive => 'Premium active';

  @override
  String get chooseAnOption => 'Choose an option';

  @override
  String get errorPurchasing => 'There was an error during the purchase. Please try again.';

  @override
  String get premiumOnly => 'Premium Only';

  @override
  String get timeLeft => 'Time left';

  @override
  String get easyMode => 'Easy Mode';

  @override
  String get hardMode => 'Hard Mode';

  @override
  String get changeMode => 'Change mode';

  @override
  String get noMorePlays => 'No more plays left';

  @override
  String get win => 'You win';

  @override
  String get lose => 'You lose';

  @override
  String get onlyPremiumForHardMode => 'Only premium users can play in Hard Mode';

  @override
  String get remainingPlays => 'Remaining plays';

  @override
  String time(Object seconds) {
    return 'Time: $seconds';
  }

  @override
  String remainingPlaysTooltip(Object count) {
    return '$count remaining plays';
  }

  @override
  String get waitResult => 'Please wait for the result...';

  @override
  String remainingAttempts(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attempts left',
      one: 'One attempt left',
      zero: 'No remaining attempts',
    );
    return '$_temp0';
  }
}
