import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../widgets/tab_bar.dart';
import 'edit_profile/driver_profile_edit_page.dart';
import 'notification/driver_notifications_page.dart';
import 'driver_settings_page.dart';
import 'preferences/driver_appearance_page.dart';
import 'preferences/driver_language_page.dart';



class DriverProfilePage extends StatelessWidget {
  const DriverProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg(context),
      bottomNavigationBar: const DriverTabBar(currentIndex: 3),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ── Page Title ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Text('Profile', style: AppTextStyles.pageTitle(context)),
            ),

            // ── Profile Hero Card ────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border(context)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 68,
                              height: 68,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.purpleGradient,
                              ),
                              child: const Center(
                                child: Icon(Icons.person_rounded,
                                    color: Colors.white, size: 34),
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.surface(context),
                                    width: 2.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Amadou Diallo',
                                  style: AppTextStyles.profileName(context)),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColors.iconBg(context),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      'Premium Driver',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryPurple,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.success.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Online',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.success,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Divider(color: AppColors.border(context), height: 1),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        _StatCell(
                          value: '4.9',
                          label: 'RATING',
                          icon: Icons.star_rounded,
                          iconColor: const Color(0xFFFFB300),
                        ),
                        _VerticalDivider(),
                        _StatCell(
                          value: '1,248',
                          label: 'TRIPS',
                          icon: Icons.route_rounded,
                          iconColor: AppColors.primaryPurple,
                        ),
                        _VerticalDivider(),
                        _StatCell(
                          value: '3 yrs',
                          label: 'EXPERIENCE',
                          icon: Icons.workspace_premium_rounded,
                          iconColor: const Color(0xFF00C2A8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── PERSONAL DETAILS Section ─────────────────────────
            const _SectionHeader(label: 'PERSONAL DETAILS'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _GroupCard(
                children: [
                  _SettingsRow(
                    icon: Icons.manage_accounts_outlined,
                    label: 'Account',
                    subtitle: 'Manage your name, email, and passkeys',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DriverProfileEditPage()),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── TOOLS Section ────────────────────────────────────
            const _SectionHeader(label: 'TOOLS'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _GroupCard(
                children: [
                  _SettingsRow(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Payment',
                    subtitle: 'Bank account configured',
                    onTap: () {},
                  ),
                  _GroupDivider(),
                  _SettingsRow(
                    icon: Icons.description_outlined,
                    label: 'Documents',
                    subtitle: 'All documents up to date',
                    subtitleColor: AppColors.success,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── PREFERENCES Section ──────────────────────────────
            const _SectionHeader(label: 'PREFERENCES'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _GroupCard(
                children: [
                  _SettingsRow(
                    icon: Icons.palette_outlined,
                    label: 'Appearance',
                    subtitle: 'Theme & display',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DriverAppearancePage()),
                    ),
                  ),
                  _GroupDivider(),
                  _SettingsRow(
                    icon: Icons.language_rounded,
                    label: 'Language',
                    subtitle: 'App language',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DriverLanguagePage()),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── SETTINGS Section ─────────────────────────────────
            const _SectionHeader(label: 'SETTINGS'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _GroupCard(
                children: [
                  _SettingsRow(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    subtitle: 'Manage alerts & reminders',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DriverNotificationsPage()),
                    ),
                  ),
                  _GroupDivider(),
                  _SettingsRow(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    subtitle: 'Privacy, security & support',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DriverSettingsPage()),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Logout ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _GroupCard(
                children: [
                  _SettingsRow(
                    icon: Icons.logout_rounded,
                    label: 'Log Out',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(label, style: AppTextStyles.sectionLabel(context)),
    );
  }
}

// ── Group Card ────────────────────────────────────────────────────────────────

class _GroupCard extends StatelessWidget {
  final List<Widget> children;
  const _GroupCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Column(children: children),
    );
  }
}

class _GroupDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Divider(height: 1, color: AppColors.border(context)),
    );
  }
}

// ── Settings Row ──────────────────────────────────────────────────────────────

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final Color? subtitleColor;
  final VoidCallback onTap;

  const _SettingsRow({
    required this.icon,
    required this.label,
    this.subtitle,
    this.subtitleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.iconBg(context),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryPurple, size: 17),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.settingsItem(context)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: AppTextStyles.settingsItemValue(context)
                          .copyWith(color: subtitleColor),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: AppColors.subtext(context), size: 20),
          ],
        ),
      ),
    );
  }
}

// ── Stat Cell ─────────────────────────────────────────────────────────────────

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;

  const _StatCell({
    required this.value,
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.profileStatValue(context)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.profileStatLabel(context)),
        ],
      ),
    );
  }
}

// ── Vertical Divider ──────────────────────────────────────────────────────────

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 44, color: AppColors.border(context));
  }
}