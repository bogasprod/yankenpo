import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/move.dart';
import '../services/ad_service.dart';
import '../providers/premium_provider.dart';
import '../widgets/move_button.dart';
import '../l10n/app_localizations.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Move? playerMove;
  Move? machineMove;
  String? result;
  int playsLeft = 10;
  int wins = 0;
  bool isDifficult = false;
  Timer? timer;
  int countdown = 0;
  bool showMachineMove = false;
  bool canPlay = true;

  late AdService adService; // instancia AdService
  bool adLoaded = false;

  @override
  void initState() {
    super.initState();
    adService = AdService();
    adService.loadBanner();
    // Opcional: escucha si el ad está cargado (puedes implementar listener dentro de AdService)
    // Aquí, si quieres puedes usar un callback para setState cuando se cargue el anuncio.
  }

  @override
  void dispose() {
    timer?.cancel();
    adService.dispose();
    super.dispose();
  }

  void startEasyMode(PremiumProvider premiumProvider) {
    if (!premiumProvider.isPremium && playsLeft <= 0) return;
    setState(() {
      resetRound();
      machineMove = Move.values[Random().nextInt(Move.values.length)];
      showMachineMove = true;
      countdown = 3;
      canPlay = true;
    });

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (countdown > 0) {
        setState(() => countdown--);
      } else {
        t.cancel();
        if (playerMove == null) {
          endRound(false, premiumProvider);
        }
      }
    });
  }

  void startDifficultMode(PremiumProvider premiumProvider) {
    if (!premiumProvider.isPremium && playsLeft <= 0) return;
    setState(() {
      resetRound();
      machineMove = Move.values[Random().nextInt(Move.values.length)];
      showMachineMove = true;
      canPlay = false;
    });

    Future.delayed(const Duration(seconds: 1), () {  // 1 segundos para mostrar jugada
      setState(() {
        showMachineMove = false;
        canPlay = true;
        countdown = 3; // cuenta regresiva antes de mostrar resultado
      });

      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (countdown > 0) {
          setState(() => countdown--);
        } else {
          t.cancel();
          if (playerMove != null) {
            checkWinner(premiumProvider);
          } else {
            endRound(false, premiumProvider);
          }
        }
      });
    });
  }

  void resetRound() {
    playerMove = null;
    machineMove = null;
    result = null;
    countdown = 0;
  }

  void selectMove(Move move) {
    if (!canPlay) return;
    setState(() => playerMove = move);
    if (!isDifficult) {
      final premiumProvider = Provider.of<PremiumProvider>(context, listen: false);
      checkWinner(premiumProvider);
    }
  }

  void checkWinner(PremiumProvider premiumProvider) {
    if (machineMove == null || playerMove == null) return;

    if (playerMove!.beats(machineMove!)) {
      wins++;
      result = 'win';
    } else if (machineMove!.beats(playerMove!)) {
      result = 'lose';
    } else {
      result = 'draw';
    }

    if (!premiumProvider.isPremium) {
      playsLeft--;
    }

    canPlay = false;
    setState(() {});
  }

  void endRound(bool playerWon, PremiumProvider premiumProvider) {
    if (playerWon) {
      wins++;
      result = 'win';
    } else {
      result = 'lose';
    }

    if (!premiumProvider.isPremium) {
      playsLeft--;
    }

    canPlay = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final premiumProvider = Provider.of<PremiumProvider>(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Yan Ken Po'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Jugadas restantes
          Text(
            premiumProvider.isPremium
                ? loc.premiumActive
                : (playsLeft > 0
                    ? loc.remainingAttempts(playsLeft)
                    : loc.noMorePlays),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),

          // Ganadas
          Text(
            '${loc.wins}: $wins',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),

          // Mostrar jugada máquina
          if (showMachineMove && machineMove != null)
            Image.asset(machineMove!.assetPath, height: 100),

          const SizedBox(height: 20),

          // Contador
          if (countdown > 0)
            Text(
              '$countdown',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.red),
            ),

          const SizedBox(height: 20),

          // Botón iniciar y modo difícil solo premium puede cambiar modo
          if (premiumProvider.isPremium)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isDifficult,
                  onChanged: (val) {
                    setState(() => isDifficult = val ?? false);
                  },
                ),
                Text(loc.difficultMode),
              ],
            ),

          ElevatedButton(
            onPressed: premiumProvider.isPremium || playsLeft > 0
                ? () => isDifficult
                    ? startDifficultMode(premiumProvider)
                    : startEasyMode(premiumProvider)
                : null,
            child: Text(loc.start),
          ),

          const SizedBox(height: 30),

          // Botones de jugada
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Move.values.map((m) {
              return _AnimatedMoveButton(
                move: m,
                onTap: () => selectMove(m),
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          // Resultado
          if (result != null)
            Column(
              children: [
                if (result == 'win')
                  Image.asset('assets/images/win.png', height: 80),
                if (result == 'lose')
                  Image.asset('assets/images/lose.png', height: 80),
                if (result == 'draw')
                  Image.asset('assets/images/draw.png', height: 80),
              ],
            ),

          const SizedBox(height: 20),

          // Publicidad solo si no es premium
          if (!premiumProvider.isPremium) adService.bannerAdWidget(),
        ],
      ),
    );
  }
}
class _AnimatedMoveButton extends StatefulWidget {
  final Move move;
  final VoidCallback onTap;

  const _AnimatedMoveButton({
    required this.move,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<_AnimatedMoveButton> createState() => _AnimatedMoveButtonState();
}

class _AnimatedMoveButtonState extends State<_AnimatedMoveButton>
    with SingleTickerProviderStateMixin {
  double scale = 1.0;

  void _handleTap() {
    setState(() => scale = 0.9); // reduce tamaño
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => scale = 1.0); // vuelve al tamaño normal
      widget.onTap(); // ejecuta acción
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: MoveButton(
            move: widget.move,
            onTap: _handleTap,
            size: 80,
          ),
        ),
      ),
    );
  }
}