// ════════════════════════════════════════════════════════════════════
//  rides_page.dart
// ════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_text_styles.dart';
import '../widgets/tab_bar.dart';
import 'ride_model.dart';
import 'ride_dummy_data.dart';
import 'ride_widgets.dart';
import 'available_ride_card.dart';

class RidesPage extends StatefulWidget {
  const RidesPage({super.key});

  @override
  State<RidesPage> createState() => _RidesPageState();
}

class _RidesPageState extends State<RidesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = ['Available', 'Upcoming', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<RideModel> _ridesFor(RideStatus status) =>
      dummyRides.where((r) => r.status == status).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg(context),
      appBar: AppBar(
        backgroundColor: AppColors.bg(context),
        elevation: 0,
        centerTitle: false,
        title: Text('Rides', style: AppTextStyles.pageTitle(context)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.border(context), width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              indicatorColor: AppColors.primaryPurple,
              indicatorWeight: 2.5,
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              labelColor: AppColors.primaryPurple,
              unselectedLabelColor: AppColors.gray7B,
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Available — shows Accept / Reject buttons
          _AvailableTab(rides: _ridesFor(RideStatus.available)),

          // Upcoming
          _UpcomingTab(rides: _ridesFor(RideStatus.upcoming)),

          // Completed
          _RideListTab(
            rides: _ridesFor(RideStatus.completed),
            emptyMessage: 'No completed rides.',
            statusLabel: 'Completed',
            statusColor: AppColors.success,
          ),

          // Cancelled
          _RideListTab(
            rides: _ridesFor(RideStatus.cancelled),
            emptyMessage: 'No cancelled rides.',
            statusLabel: 'Cancelled',
            statusColor: AppColors.error,
          ),
        ],
      ),
      bottomNavigationBar: DriverTabBar(currentIndex: 2),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  AVAILABLE TAB  —  stateful (cards removed on accept/reject)
// ════════════════════════════════════════════════════════════════════

class _AvailableTab extends StatefulWidget {
  final List<RideModel> rides;
  const _AvailableTab({required this.rides});

  @override
  State<_AvailableTab> createState() => _AvailableTabState();
}

class _AvailableTabState extends State<_AvailableTab> {
  late List<RideModel> _rides;

  @override
  void initState() {
    super.initState();
    _rides = List.from(widget.rides);
  }

  void _accept(RideModel ride) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.success,
      content: Text('Ride ${ride.id} accepted!',
          style: const TextStyle(fontFamily: 'Inter', color: Colors.white)),
      duration: const Duration(seconds: 2),
    ));
    setState(() => _rides.remove(ride));
  }

  void _reject(RideModel ride) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.error,
      content: Text('Ride ${ride.id} rejected.',
          style: const TextStyle(fontFamily: 'Inter', color: Colors.white)),
      duration: const Duration(seconds: 2),
    ));
    setState(() => _rides.remove(ride));
  }

  @override
  Widget build(BuildContext context) {
    if (_rides.isEmpty) {
      return const RideEmptyState(
          message: 'There are no available rides at this time.');
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: _rides.length,
      itemBuilder: (_, i) => RideCard(
        ride: _rides[i],
        onAccept: _accept,
        onReject: _reject,
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  UPCOMING TAB  —  Track on Map + Chat buttons
// ════════════════════════════════════════════════════════════════════

class _UpcomingTab extends StatelessWidget {
  final List<RideModel> rides;
  const _UpcomingTab({required this.rides});

  @override
  Widget build(BuildContext context) {
    if (rides.isEmpty) {
      return const RideEmptyState(message: 'No upcoming rides.');
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: rides.length,
      itemBuilder: (_, i) => RideCard(
        ride: rides[i],
        statusLabel: 'Scheduled',
        statusColor: AppColors.primaryPurple,
        onTrack: (ride) {

  Navigator.pushNamed(context, '/active-ride');

        },
        onChat: (ride) {
          // TODO: open chat screen
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════
//  GENERIC RIDE LIST TAB  (Completed / Cancelled)
// ════════════════════════════════════════════════════════════════════

class _RideListTab extends StatelessWidget {
  final List<RideModel> rides;
  final String emptyMessage;
  final String statusLabel;
  final Color statusColor;

  const _RideListTab({
    required this.rides,
    required this.emptyMessage,
    required this.statusLabel,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    if (rides.isEmpty) return RideEmptyState(message: emptyMessage);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: rides.length,
      itemBuilder: (_, i) => RideCard(
        ride: rides[i],
        statusLabel: statusLabel,
        statusColor: statusColor,
      ),
    );
  }
}