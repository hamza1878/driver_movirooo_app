import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../routing/router.dart';
import '../widgets/tab_bar.dart';

class EarningsPage extends StatefulWidget {
  const EarningsPage({super.key});

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage>
    with TickerProviderStateMixin {
  String _selectedPeriod = 'Weekly';
  late AnimationController _fadeController;
  late AnimationController _barController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _barAnimation;

  static const _allTimeTotal = '€24,560';
  static const _todayAmount  = '€142.30';
  static const _weekAmount   = '€820.50';
  static const _monthAmount  = '€3,240';

  static const _days   = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  static const _values = [65.0, 80.0, 50.0, 140.0, 90.0, 75.0, 35.0];
  static const _todayIndex = 3;

  static const _ridesHistory = [
    _RideEntry(date: 'Mar 4, 2026',  rides: 5, amount: '€62.50',  trend: true),
    _RideEntry(date: 'Mar 3, 2026',  rides: 8, amount: '€98.00',  trend: true),
    _RideEntry(date: 'Mar 2, 2026',  rides: 3, amount: '€37.20',  trend: false),
    _RideEntry(date: 'Mar 1, 2026',  rides: 6, amount: '€74.80',  trend: true),
    _RideEntry(date: 'Feb 28, 2026', rides: 7, amount: '€89.40',  trend: false),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _barController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _barAnimation = CurvedAnimation(
      parent: _barController,
      curve: Curves.easeOutCubic,
    );
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _barController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _barController.dispose();
    super.dispose();
  }

  void _handleTabTap(int index) {
    final routes = [
      AppRouter.driverDashboard,
      AppRouter.driverEarnings,
      AppRouter.driverRides,
      AppRouter.driverProfile,
    ];
    AppRouter.replace(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.bg(context),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  children: [
                    _buildTotalCard(context, isDark),
                    const SizedBox(height: 16),
                    _buildChartCard(context, isDark),
                    const SizedBox(height: 28),
                    _buildSectionHeader(context),
                    const SizedBox(height: 12),
                    _buildRidesHistory(context, isDark),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: DriverTabBar(
        currentIndex: 1,
        onTap: _handleTabTap,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Row(
        children: [
          Text('Earnings', style: AppTextStyles.pageTitle(context)),
        ],
      ),
    );
  }

  Widget _buildTotalCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.purpleGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: isDark ? 0.35 : 0.22),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Time Earnings',
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.trending_up_rounded,
                        size: 13, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      '+12.4%',
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _allTimeTotal,
            style: AppTextStyles.bookingId(context).copyWith(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildPeriodStat(context, 'Today',      _todayAmount, Icons.wb_sunny_rounded),
              _buildDivider(),
              _buildPeriodStat(context, 'This Week',  _weekAmount,  Icons.date_range_rounded),
              _buildDivider(),
              _buildPeriodStat(context, 'This Month', _monthAmount, Icons.calendar_month_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 36,
      color: Colors.white.withValues(alpha: 0.15),
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildPeriodStat(
      BuildContext context, String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 11, color: Colors.white.withValues(alpha: 0.65)),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.priceMedium(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(BuildContext context, bool isDark) {
    final maxVal = _values.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Activity', style: AppTextStyles.bodySmall(context)),
                  const SizedBox(height: 2),
                  Text(
                    'Average Earning',
                    style: AppTextStyles.bodyLarge(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() {
                  _selectedPeriod =
                      _selectedPeriod == 'Weekly' ? 'Monthly' : 'Weekly';
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF222228)
                        : const Color(0xFFF0F0F4),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border(context)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedPeriod,
                        style: AppTextStyles.bodySmall(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text(context),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: AppColors.subtext(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 185,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: ['140€', '105€', '70€', '35€', '0€']
                        .map((l) => Text(l,
                            style: AppTextStyles.priceFooter(context)))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _barAnimation,
                    builder: (context, _) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(_days.length, (i) {
                          final isActive = i == _todayIndex;
                          final barH = (_values[i] / maxVal) * 120 * _barAnimation.value;
                          return _buildBar(context, isDark, i, isActive, barH);
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, bool isDark, int i, bool isActive, double barH) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isActive)
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '€${_values[i].toInt()}',
              style: AppTextStyles.priceFooter(context).copyWith(
                fontSize: 9,
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        Container(
          width: 28,
          height: barH.clamp(4.0, double.infinity),
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(
                    colors: [
                      AppColors.primaryPurple,
                      AppColors.secondaryPurple,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            color: isActive
                ? null
                : (isDark
                    ? const Color(0xFF2A2A32)
                    : const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primaryPurple.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _days[i],
          style: AppTextStyles.priceFooter(context).copyWith(
            fontSize: 9,
            fontWeight:
                isActive ? FontWeight.w700 : FontWeight.w400,
            color: isActive
                ? AppColors.primaryPurple
                : AppColors.subtext(context),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.iconBg(context),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                size: 16,
                color: AppColors.primaryPurple,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Rides History',
              style: AppTextStyles.bodyLarge(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
        Text(
          'See all',
          style: AppTextStyles.bodySmall(context).copyWith(
            color: AppColors.primaryPurple,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildRidesHistory(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(_ridesHistory.length, (i) {
          final entry  = _ridesHistory[i];
          final isLast = i == _ridesHistory.length - 1;
          return Column(
            children: [
              _buildHistoryRow(context, isDark, entry, i),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: AppColors.border(context),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHistoryRow(
      BuildContext context, bool isDark, _RideEntry entry, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.iconBg(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.directions_car_rounded,
              size: 18,
              color: AppColors.primaryPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.date,
                  style: AppTextStyles.dateTime(context),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      '${entry.rides} Rides',
                      style: AppTextStyles.bodyMedium(context)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: (entry.trend
                                ? AppColors.success
                                : AppColors.error)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            entry.trend
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 10,
                            color: entry.trend
                                ? AppColors.success
                                : AppColors.error,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            entry.trend ? 'Up' : 'Down',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: entry.trend
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            entry.amount,
            style: AppTextStyles.priceMedium(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RideEntry {
  final String date;
  final int    rides;
  final String amount;
  final bool   trend;
  const _RideEntry({
    required this.date,
    required this.rides,
    required this.amount,
    required this.trend,
  });
}