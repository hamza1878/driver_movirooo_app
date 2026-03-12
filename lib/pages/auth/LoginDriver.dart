import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../routing/router.dart';

class DriverLoginPage extends StatefulWidget {
  const DriverLoginPage({super.key});

  @override
  State<DriverLoginPage> createState() => _DriverLoginPageState();
}

class _DriverLoginPageState extends State<DriverLoginPage>
    with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _passController  = TextEditingController();
  bool _obscurePass  = true;
  bool _keepSignedIn = true;
  bool _isLoading    = false;

  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<Offset>   _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim  = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(
    BuildContext context, {
    required String hint,
    required IconData prefixIcon,
    bool isActive = false,
    Widget? suffix,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.bodyMedium(context).copyWith(
        color: AppColors.subtext(context),
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: isActive ? AppColors.primaryPurple : AppColors.subtext(context),
        size: 20,
      ),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppColors.surface(context),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: isDark
            ? BorderSide.none
            : BorderSide(color: AppColors.border(context)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: isActive
            ? BorderSide(color: AppColors.primaryPurple, width: 1.5)
            : isDark
                ? BorderSide.none
                : BorderSide(color: AppColors.border(context)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: AppColors.primaryPurple,
          width: 2,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  void _login() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isLoading = false);
    AppRouter.clearAndGo(context, AppRouter.driverDashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg(context),
      body: SafeArea(
        child: Column(
          children: [

            // ── Top bar ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 16, 0),
              child: Row(
                children: [
                  Text(
                    'Quick access for chauffeurs',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.subtext(context),
                    ),
                  ),
                  const Spacer(),
                  // Secure badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.green.withOpacity(0.30), width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shield_outlined,
                            color: Colors.green.shade400, size: 14),
                        const SizedBox(width: 5),
                        Text(
                          'Secure',
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: Colors.green.shade400,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
ClipRRect(
  child: Image.asset(
    'images/logob.png',
    width: 100,
    height: 100,
 
    
    ),
  ),

const SizedBox(height: 16),
            // ── Card ──────────────────────────────────────
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.bg(context),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          // ── Title ──────────────────────
                          Text(
                            'Movirooo',
                            style: AppTextStyles.pageTitle(context).copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Use your phone number or email\nand password to continue.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              color: AppColors.subtext(context),
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // ── Phone / Email ──────────────
                          _label(context, 'PHONE NUMBER / EMAIL'),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: AppColors.primaryPurple,
                            style: AppTextStyles.bodyMedium(context),
                            decoration: _fieldDecoration(
                              context,
                              hint: '+212 6 12 34 56 78',
                              prefixIcon: Icons.smartphone_rounded,
                              isActive: true,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ── Password ───────────────────
                          _label(context, 'PASSWORD'),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _passController,
                            obscureText: _obscurePass,
                            cursorColor: AppColors.primaryPurple,
                            style: AppTextStyles.bodyMedium(context),
                            decoration: _fieldDecoration(
                              context,
                              hint: 'Enter your password',
                              prefixIcon: Icons.lock_outline_rounded,
                              suffix: IconButton(
                                icon: Icon(
                                  _obscurePass
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.subtext(context),
                                  size: 20,
                                ),
                                onPressed: () => setState(
                                    () => _obscurePass = !_obscurePass),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ── Keep me signed in ──────────
                          GestureDetector(
                            onTap: () => setState(
                                () => _keepSignedIn = !_keepSignedIn),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: _keepSignedIn
                                    ? AppColors.primaryPurple.withOpacity(0.10)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_rounded,
                                    color: _keepSignedIn
                                        ? AppColors.primaryPurple
                                        : AppColors.subtext(context),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Keep me signed in',
                                    style: AppTextStyles.bodyMedium(context)
                                        .copyWith(
                                      color: _keepSignedIn
                                          ? AppColors.primaryPurple
                                          : AppColors.subtext(context),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ── Login button ───────────────
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryPurple,
                                disabledBackgroundColor:
                                    AppColors.primaryPurple.withOpacity(0.5),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 22, height: 22,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.login_rounded,
                                            color: Colors.white, size: 20),
                                        const SizedBox(width: 10),
                                        Text('Login',
                                            style: AppTextStyles.buttonPrimary
                                                .copyWith(fontSize: 16)),
                                      ],
                                    ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ── Need help ──────────────────
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primaryPurple.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color:
                                    AppColors.primaryPurple.withOpacity(0.15),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.chat_bubble_outline_rounded,
                                    color: AppColors.primaryPurple, size: 22),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Need help?',
                                          style: AppTextStyles.bodyLarge(
                                                  context)
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.w800)),
                                      const SizedBox(height: 4),
                                      Text(
                                        'If you cannot access your account, contact admin or report a problem directly from the links below.',
                                        style: AppTextStyles.bodySmall(context)
                                            .copyWith(
                                          color: AppColors.subtext(context),
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _label(BuildContext context, String text) => Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: AppTextStyles.sectionLabel(context)),
      );
}