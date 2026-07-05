import 'package:cbs_erp_project/custom_widgets/custom_text_view.dart';
import 'package:cbs_erp_project/network/support/share_preference.dart';
import 'package:cbs_erp_project/screens/login_screen/login_screen.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:cbs_erp_project/widgets/network_aware_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pages = [
    OnboardingItems(
      title: 'Master Your Sales',
      description:
          'Track every transaction with ease. Get real-time insights into your revenue and top-selling products.',
      img: 'assets/images/onboarding1.svg',
    ),
    OnboardingItems(
      title: 'Master Your Sales',
      description:
          'Track every transaction with ease. Get real-time insights into your revenue and top-selling products.',
      img: 'assets/images/onboarding2.svg',
    ),
    OnboardingItems(
      title: 'Master Your Sales',
      description:
          'Track every transaction with ease. Get real-time insights into your revenue and top-selling products.',
      img: 'assets/images/onboarding3.svg',
    ),
  ];

  final PageController _pageController = PageController();
  int currentPage = 0;
  String loginPin = '';
  @override
  void initState() {
    loadLoginPin();
    super.initState();
  }
  loadLoginPin() async{
    loginPin = await SharedPreferenceManager.getLoginPin();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NetworkAwareWrapper(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final height = constraints.maxHeight;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen(loginPin: loginPin,)),
                        );
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CustomTextView.mediumTextView(
                          'Skip',
                          AppColors.primaryColors,
                          false,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pages.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              Container(
                                height: height * 0.45,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2,
                                    color: AppColors.primaryColors,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  _pages[index].img,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 15),
                              CustomTextView.largeTextView(
                                _pages[index].title,
                                Colors.grey,
                                false,
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: CustomTextView.normalTextView(
                                  _pages[index].description,
                                  AppColors.primaryColors,
                                  true,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: height * 0.03,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _pages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 45,
                              height: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: currentPage == index
                                    ? AppColors.primaryColors
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            if (currentPage < _pages.length - 1) {
                              _pageController.animateToPage(
                                currentPage + 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(loginPin: loginPin,),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            constraints: const BoxConstraints(maxWidth: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColors,
                            ),
                            child: Center(
                              child: CustomTextView.normalTextView(
                                currentPage == _pages.length - 1
                                    ? "Get Started"
                                    : "Next",
                                Colors.white,
                                false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class OnboardingItems {
  final String title;
  final String description;
  final String img;

  OnboardingItems({
    required this.title,
    required this.description,
    required this.img,
  });
}
