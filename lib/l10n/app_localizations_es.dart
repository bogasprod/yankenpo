// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get noMoreAttempts => 'No hay más intentos disponibles';

  @override
  String get machineChose => 'La máquina eligió';

  @override
  String get youChose => 'Tú elegiste';

  @override
  String get selectDifficulty => 'Selecciona Dificultad';

  @override
  String get appTitle => 'Yan Ken Po';

  @override
  String get freeVersion => 'Versión gratuita';

  @override
  String get play => 'Jugar';

  @override
  String get settings => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get about => 'Acerca de';

  @override
  String get gameLevel => 'Nivel del juego';

  @override
  String get easy => 'Fácil';

  @override
  String get medium => 'Intermedio';

  @override
  String get hard => 'Avanzado';

  @override
  String get premiumRequired => 'Se requiere versión premium';

  @override
  String get upgrade => 'Actualizar';

  @override
  String get premiumVersion => 'Versión Premium';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get purchaseRestored => 'Compra restaurada exitosamente';

  @override
  String get googlePlayAutoRestore => 'Google Play restaurará tu compra automáticamente';

  @override
  String get selectMove => 'Selecciona tu jugada';

  @override
  String get rock => 'Piedra';

  @override
  String get paper => 'Papel';

  @override
  String get scissors => 'Tijera';

  @override
  String get youWin => '¡Ganaste!';

  @override
  String get youLose => '¡Perdiste!';

  @override
  String get draw => '¡Empate!';

  @override
  String attemptsLeft(Object count) {
    return 'Intentos restantes: $count';
  }

  @override
  String get noAttempts => 'No hay más intentos. Actualiza para continuar.';

  @override
  String get aboutApp => 'Acerca de la app';

  @override
  String get version => 'Versión';

  @override
  String get author => 'Autor';

  @override
  String get contact => 'Contacto';

  @override
  String get gameTitle => 'Yan Ken Po - Juego';

  @override
  String get difficulty => 'Dificultad';

  @override
  String get difficultMode => 'Activar modo difícil';

  @override
  String get you => 'Tú';

  @override
  String get machine => 'Máquina';

  @override
  String get advanced => 'Avanzado';

  @override
  String get wins => 'Ganados';

  @override
  String get start => 'Iniciar';

  @override
  String get premium => 'Premium';

  @override
  String get buyPremium => 'Comprar Premium';

  @override
  String get premiumActive => 'Premium activo';

  @override
  String get chooseAnOption => 'Elige una opción';

  @override
  String get errorPurchasing => 'Ocurrió un error al hacer la compra. Intenta nuevamente.';

  @override
  String get premiumOnly => 'Solo disponible para usuarios premium';

  @override
  String get timeLeft => 'Tiempo faltante';

  @override
  String get easyMode => 'Modo fácil';

  @override
  String get hardMode => 'Modo difícil';

  @override
  String get changeMode => 'Cambio  de modo';

  @override
  String get noMorePlays => 'No tienes más jugadas';

  @override
  String get win => 'Ganaste';

  @override
  String get lose => 'Perdiste';

  @override
  String get onlyPremiumForHardMode => 'Solo los usuarios premium pueden jugar en modo difícil';

  @override
  String get remainingPlays => 'Jugadas restantes';

  @override
  String time(Object seconds) {
    return 'Tiempo: $seconds';
  }

  @override
  String remainingPlaysTooltip(Object count) {
    return '$count intentos restantes';
  }

  @override
  String get waitResult => 'Espere el resultado...';

  @override
  String remainingAttempts(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count intentos restantes',
      one: 'Un intento restante',
      zero: 'No hay intentos restantes',
    );
    return '$_temp0';
  }
}
