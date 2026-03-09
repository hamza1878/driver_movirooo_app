import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '_NavigationBar.dart';
import '_DriverCard.dart';
import '_SlideToComplete.dart';

class ActiveRidePage extends StatefulWidget {
  const ActiveRidePage({super.key});

  @override
  State<ActiveRidePage> createState() => _ActiveRidePageState();
}

class _ActiveRidePageState extends State<ActiveRidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg(context),
      body: Stack(
        children: [

          // ── 1. MAP (fond complet) ──────────────────────────
          Positioned.fill(
            child: Image.asset(
              'images/maps.png',
                height: double.infinity,

              fit: BoxFit.cover,
            ),
          ),

          // ── 2. NAVIGATION BAR (haut) ───────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: NavigationInstructionBar(),
              ),
            ),
          ),

          // ── 3. BOUTONS CARTE (droite) ──────────────────────
          Positioned(
            right: 16,
            top: MediaQuery.of(context).padding.top + 100,
            child: _MapControls(),
          ),

          // ── 4. DRIVER CARD + SLIDE (bas) ───────────────────
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DriverCard(),
                SlideToComplete(
                  onCompleted: () {
                    // → Navigation vers page de confirmation
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Boutons zoom carte ────────────────────────────────────────────────────────
class _MapControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MapBtn(icon: Icons.add),
        const SizedBox(height: 8),
        _MapBtn(icon: Icons.remove),
        const SizedBox(height: 8),
        _MapBtn(icon: Icons.my_location_rounded),
      ],
    );
  }
}

class _MapBtn extends StatelessWidget {
  final IconData icon;
  const _MapBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8, offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 20, color: AppColors.text(context)),
    );
  }
}