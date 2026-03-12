import 'package:flutter/material.dart';
import 'package:moviroo_driver_app/pages/auth/LoginDriver.dart' show DriverLoginPage;
import 'package:moviroo_driver_app/pages/driver_pickup_v2/driver_pickup_page.dart';
import 'package:moviroo_driver_app/pages/tabs%20%5Bdriver%5D/chat/chat_page.dart';
import '../pages/tabs [driver]/ActiveRide/active_ride_page.dart';
import '../pages/tabs [driver]/ride/map_preview_page.dart';

import '../pages/tabs [driver]/dashboard/dashboard_page.dart';
import '../pages/tabs [driver]/Earnings/earnings_page.dart';
import '../pages/tabs [driver]/Rides/rides_page.dart';
import '../pages/tabs [driver]/profile/driver_profile_page.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPass = '/forgot-password';

  // Passenger
static const String driverLogin = '/driver/login';

  // Driver
  static const String driverDashboard = '/driver/dashboard';
  static const String driverEarnings = '/driver/earnings';
  static const String driverRides = '/driver/rides';
  static const String driverProfile = '/driver/profile';
static const String activeRide = '/active-ride';
  static const String chat = '/chat';
static const String mapPreview = '/map-preview';
static const String driverPickup = '/driver/pickup';

// Dans routes :
static const String initialRoute = driverLogin;


  static Map<String, WidgetBuilder> get routes => {
    

  driverLogin: (_) => const DriverLoginPage(),

driverPickup: (_) => const DriverPickupPage(),

    // Driver
    driverDashboard: (_) => const DashboardPage(),
    driverEarnings: (_) => const EarningsPage(),
    driverRides: (_) => const RidesPage(),   // ← added
    driverProfile: (_) => const DriverProfilePage(),
    activeRide: (_) => const ActiveRidePage(),
    chat: (_) => const ChatPage(),
    mapPreview: (_) => const MapPreviewPage(),


  };

  static Future<T?> push<T>(
    BuildContext context,
    String routeName, {
    Object? args,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: args);
  }

  static Future<T?> replace<T>(
    BuildContext context,
    String routeName, {
    Object? args,
  }) {
    return Navigator.pushReplacementNamed<T, dynamic>(
      context,
      routeName,
      arguments: args,
    );
  }

  static Future<T?> clearAndGo<T>(
    BuildContext context,
    String routeName, {
    Object? args,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (_) => false,
      arguments: args,
    );
  }

  static void pop(BuildContext context, [dynamic result]) {
    Navigator.pop(context, result);
  }
}