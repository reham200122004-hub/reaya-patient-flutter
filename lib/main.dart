import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/booking_provider.dart';
import 'presentation/providers/reaya_sense_provider.dart';

// استيراد الشاشات الـ19 كاملة
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/forgot_password_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/profile_screen.dart';
import 'presentation/screens/services_screen.dart';
import 'presentation/screens/case_information_screen.dart';
import 'presentation/screens/location_screen.dart';
import 'presentation/screens/nurse_recommendation_screen.dart';
import 'presentation/screens/nurse_details_screen.dart';
import 'presentation/screens/confirm_booking_screen.dart';
import 'presentation/screens/booking_success_screen.dart';
import 'presentation/screens/bookings_screen.dart';
import 'presentation/screens/booking_details_screen.dart';
import 'presentation/screens/medical_record_screen.dart';
import 'presentation/screens/notifications_screen.dart';
import 'presentation/screens/rating_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ReayaApp());
}

class ReayaApp extends StatelessWidget {
  const ReayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => ReayaSenseProvider()),
      ],
      child: MaterialApp(
        title: 'رِعاية — REAYA',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        
        // إعدادات اللغة العربية ودعم RTL الكامل
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [
          Locale('ar', 'EG'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        // المسار المبدئي والـ 19 شاشة المعتمدة
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (context) => const SplashScreen(),
          AppRoutes.onboarding: (context) => const OnboardingScreen(),
          AppRoutes.login: (context) => const LoginScreen(),
          AppRoutes.register: (context) => const RegisterScreen(),
          AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
          AppRoutes.home: (context) => const HomeScreen(),
          AppRoutes.profile: (context) => const ProfileScreen(),
          AppRoutes.services: (context) => const ServicesScreen(),
          AppRoutes.caseInformation: (context) => const CaseInformationScreen(),
          AppRoutes.location: (context) => const LocationScreen(),
          AppRoutes.nurseRecommendation: (context) => const NurseRecommendationScreen(),
          AppRoutes.nurseDetails: (context) => const NurseDetailsScreen(),
          AppRoutes.confirmBooking: (context) => const ConfirmBookingScreen(),
          AppRoutes.bookingSuccess: (context) => const BookingSuccessScreen(),
          AppRoutes.bookings: (context) => const BookingsScreen(),
          AppRoutes.bookingDetails: (context) => const BookingDetailsScreen(),
          AppRoutes.medicalRecord: (context) => const MedicalRecordScreen(),
          AppRoutes.notifications: (context) => const NotificationsScreen(),
          AppRoutes.rating: (context) => const RatingScreen(),
        },
      ),
    );
  }
}
