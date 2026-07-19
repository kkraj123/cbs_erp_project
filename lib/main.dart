import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/network/support/share_preference.dart';
import 'package:cbs_erp_project/onboarding_screen.dart';
import 'package:cbs_erp_project/screens/login_screen/login_screen.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:cbs_erp_project/widgets/network_aware_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ERP managment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NetworkAwareWrapper(child: SplashScreen()),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String loginPin = '';

  @override
  void initState() {
    super.initState();
    loadLoginPin();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
      _checkOnboardingStatus();
    });
  }

  loadLoginPin() async {
    loginPin = await SharedPreferenceManager.getLoginPin();
  }

  Future<void> _checkOnboardingStatus() async {
    bool hasSeenOnboarding =
        await SharedPreferenceManager.getFirstCallOnboarding();
    if (!hasSeenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen(loginPin: loginPin)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.colorWhite,
              ),
              child: Center(
                child: Icon(
                  Icons.shopping_bag,
                  size: 35,
                  color: AppColors.primaryColors,
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomTextView.largeTextView(
              "Balance ERP",
              AppColors.colorWhite,
              false,
            ),
            const SizedBox(height: 5),
            CustomTextView.normalTextView(
              'PROCUREMENT & SALES',
              AppColors.colorWhite,
              false,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1),
                duration: const Duration(seconds: 5), // 0.5 second
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    minHeight: 5,
                    backgroundColor: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.colorWhite,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            CustomTextView.normalTextView(
              'ESTABLISHING SECURE CONNECTION',
              Colors.white,
              false,
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextView.normalTextView(
                  "Powered by",
                  AppColors.secondaryColor,
                  false,
                ),
                const SizedBox(width: 5),
                CustomTextView.normalTextView(
                  "Infobrain Technologies",
                  Colors.white,
                  false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
