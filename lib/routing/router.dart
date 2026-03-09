import 'package:flutter/material.dart';
import 'package:moviroo/pages/tabs%20%5Bdriver%5D/ActiveRide/active_ride_page.dart';
import 'package:moviroo/pages/tabs%20%5Bdriver%5D/chat/chat_page.dart';
import '../pages/onboarding/onboarding_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/sign_up_page.dart';
import '../pages/auth/forget_password.dart';
import '../pages/tabs [passenger]/home/home_page.dart' as passenger;
import '../pages/tabs [passenger]/support/support_page.dart';
import '../pages/tabs [passenger]/profile/settings_page.dart';
import '../pages/tabs [passenger]/trajet/trajet_page.dart';
import '../pages/tabs [passenger]/membre/membre_pass_screen.dart';
import '../pages/splash/splash_page.dart';
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
  static const String home = '/home';
  static const String support = '/support';
  static const String membre = '/membre';
  static const String profile = '/profile';
  static const String trajet = '/trajet';

  // Driver
  static const String driverDashboard = '/driver/dashboard';
  static const String driverEarnings = '/driver/earnings';
  static const String driverRides = '/driver/rides';
  static const String driverProfile = '/driver/profile';
static const String activeRide = '/active-ride';
  static const String chat = '/chat';


// Dans routes :
static const String initialRoute = splash;


  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashPage(),
    onboarding: (_) => const OnboardingPage(),
    login: (_) => const LoginPage(),
    signup: (_) => const SignUpPage(),
    forgotPass: (_) => const ForgotPasswordPage(),

    // Passenger
    home: (_) => const passenger.HomePage(),
    support: (_) => const SupportPage(),
    membre: (_) => const MembrePassScreen(),
    profile: (_) => const SettingsPage(),
    trajet: (_) => const TrajetPage(),

    // Driver
    driverDashboard: (_) => const DashboardPage(),
    driverEarnings: (_) => const EarningsPage(),
    driverRides: (_) => const RidesPage(),   // ← added
    driverProfile: (_) => const DriverProfilePage(),
    activeRide: (_) => const ActiveRidePage(),
    chat: (_) => const ChatPage(),

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