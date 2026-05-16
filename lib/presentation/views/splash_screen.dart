import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/components/login_background_elements.dart';
import 'package:qr_code_scanner/core/constants/app_colors.dart';
import 'package:qr_code_scanner/presentation/viewmodels/auth_controller.dart';
import 'package:qr_code_scanner/presentation/views/home/student_dashboard.dart';
import 'package:qr_code_scanner/presentation/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000), // Fixed from seconds to milliseconds
      vsync: this,
    )..forward();
    _startNavigationTimer();
  }
  
  // void _startNavigationTimer() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     final authController = Get.find<AuthController>();

  //     if (authController.isLoggedIn.value) {
  //       // Get.offAll(() => StudentDashboard());
  //               Get.offAll(() => LoginScreen());

  //     } else {
  //       Get.offAll(() => LoginScreen());

  //       // Get.offAll(() =>StudentDashboard);
  //     }
  //   });
  // }
  void _startNavigationTimer() async {

  await Future.delayed(
    const Duration(seconds: 3),
  );

  final authController =
      Get.find<AuthController>();

  await authController.checkLoginStatus();

  if (authController.isLoggedIn.value) {

    Get.offAll(() => StudentDashboard());

  } else {

    Get.offAll(() => LoginScreen());

  }
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFFFFF), // Pure white
              const Color(0xFFFFF9E6), // Warm white
              const Color(0xFFFFF3E0), // Light orange tint
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            
                        const BackgroundElements(),

            
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo Container
                  _buildLogoAnimation(),
                  const SizedBox(height: 40),
                  
                  // Academy Name
                  _buildAcademyName(),
                  const SizedBox(height: 8),
                  
                  // Academy Tagline
                  _buildAcademyTagline(),
                ],
              ),
            ),
            
            // Bottom Slogan
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: _buildSloganSection(),
            ),
            
            // Loading Indicator
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: _buildLoadingIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoAnimation() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow effect behind logo
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFFF39C12).withOpacity(0.2),
                const Color(0xFFF39C12).withOpacity(0.1),
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ).animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        ).scale(
          duration: Duration(seconds: 2),
          begin: Offset(0.9, 0.9),
          end: Offset(1.1, 1.1),
          curve: Curves.easeInOut,
        ),
        
        // // Logo container
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF39C12).withOpacity(0.3),
                blurRadius: 25,
                spreadRadius: 5,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(
                "assets/app_logo.png",
                width: 90,
                height: 90,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ).animate(delay: 300.ms)
          .scale(
            duration: 800.ms,
            begin: Offset(0.7, 0.7),
            end: Offset(1.0, 1.0),
            curve: Curves.elasticOut,
          )
          .fadeIn(duration: 600.ms),
      ],
    );
  }


  Widget _buildAcademyName() {
    return Column(
      children: [
        Text(
          'Al-Qasim Academy',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF2C3E50),
            letterSpacing: -0.5,
          ),
        ).animate(delay: 800.ms)
          .fadeIn(duration: 600.ms)
          .slideY(
            begin: -0.5,
            end: 0,
            duration: 500.ms,
            curve: Curves.easeOut,
          ),
        
        const SizedBox(height: 4),
        
        Text(
          'of Mathematics',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFE67E22),
            fontStyle: FontStyle.italic,
          ),
        ).animate(delay: 900.ms)
          .fadeIn(duration: 600.ms)
          .slideY(
            begin: -0.3,
            end: 0,
            duration: 500.ms,
            curve: Curves.easeOut,
          ),
      ],
    );
  }

  Widget _buildAcademyTagline() {
    return Text(
      'Excellence in Mathematical Education',
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF7F8C8D),
        letterSpacing: 0.5,
      ),
    ).animate(delay: 1100.ms)
      .fadeIn(duration: 600.ms)
      .slideY(
        begin: 0.5,
        end: 0,
        duration: 500.ms,
        curve: Curves.easeOut,
      );
  }

  Widget _buildSloganSection() {
    return Column(
      children: [
        // Divider line
        Container(
          width: 80,
          height: 3,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            gradient: AppColors.warningGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate(delay: 1300.ms).scaleX(
              begin: 0,
              end: 1,
              duration: 600.ms,
              curve: Curves.easeOut,
            ),
        
        // Main slogan
        Text(
          'The Language of Universe',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C3E50),
            letterSpacing: 0.3,
          ),
        ).animate(delay: 1500.ms).fadeIn(duration: 800.ms),
        
        const SizedBox(height: 8),
        
        // Secondary tagline
        Text(
          'Where Numbers Come to Life',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFE67E22),
            fontStyle: FontStyle.italic,
          ),
        ).animate(delay: 1700.ms).fadeIn(duration: 800.ms),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(
              const Color(0xFFF39C12),
            ),
            backgroundColor: const Color(0xFFF39C12).withOpacity(0.1),
          ),
        ).animate(
          onPlay: (controller) => controller.repeat(),
        ).rotate(duration: Duration(seconds: 2)),


      ],
    );
  }
}