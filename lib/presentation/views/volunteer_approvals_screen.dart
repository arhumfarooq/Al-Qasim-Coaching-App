
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_code_scanner/components/approving_indicator.dart';
import 'package:qr_code_scanner/components/volunteer_appBar.dart';
import 'package:qr_code_scanner/components/volunteer_screen_shimmer.dart';
import 'package:qr_code_scanner/core/constants/app_colors.dart';
import 'package:qr_code_scanner/core/utils/utils.dart';
import 'package:qr_code_scanner/data/models/volunteer_model.dart' show Volunteer;
import 'package:qr_code_scanner/presentation/viewmodels/volunteer_controller.dart';

class VolunteerApprovalsScreen extends StatefulWidget {
  const VolunteerApprovalsScreen({super.key});

  @override
  State<VolunteerApprovalsScreen> createState() =>
      _VolunteerApprovalsScreenState();
}

class _VolunteerApprovalsScreenState extends State<VolunteerApprovalsScreen> {

  final VolunteerController controller = Get.find<VolunteerController>();
@override
  void dispose() {
    controller.loadVolunteers();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
Obx(() {
  final pendingCount = controller.volunteers
      .where((v) => v.userStatus.toLowerCase() == 'pending')
      .length;
  return ModernVolunteerAppBar(
    title: 'Volunteer Approvals',
    showFilterIcon: false,
    onBackPressed: () => Get.back(),
    volunteerCount: pendingCount, // Now reactive
  );
}),
          // Main content area
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
              
                return 
                      _buildShimmerLoading();
              }

              if (controller.volunteers.isEmpty)
              
              
               {
                return _buildEmptyState();
              }

              return ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: controller.volunteers.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, index) {
                  final volunteer = controller.volunteers[index];
                  return _buildVolunteerCard(volunteer)
                      .animate()
                      .fadeIn(duration: 300.ms, delay: (100 * index).ms)
                      .slideY(
                        begin: 0.1,
                        end: 0,
                        duration: 400.ms,
                        curve: Curves.easeOutCubic,
                        delay: (50 * index).ms,
                      );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
Widget _buildVolunteerCard(Volunteer volunteer) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16.r),
    child: Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Name and Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Volunteer Avatar
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColors.getStatusColor(volunteer.userStatus).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.getStatusColor(volunteer.userStatus).withOpacity(0.2),
                    width: 1.w,
                  ),
                ),
                child: Center(
                  child: Icon(
                    LucideIcons.user,
                    size: 20.sp,
                    color: AppColors.getStatusColor(volunteer.userStatus),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              
              // Name and Status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Full Name
                              Text(
                                volunteer.userName,
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E293B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              
                              // Father Name
                              Text(
                                '${volunteer.fatherName}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF64748B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                         _buildApproveButton(
  volunteer.id,
  volunteer.isApproved,
),
                      ],
                    ),
                    
                    SizedBox(height: 8.h),
                    
                    // Volunteer ID
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryDark.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.user,
                            size: 12.sp,
                            color: AppColors.secondaryDark,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            volunteer.volunteerId,
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryDark,
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
          
          SizedBox(height: 16.h),
          
          // Contact Information Section
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1.w,
              ),
            ),
            child: Column(
              children: [
                // Phone Number Row
                Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: AppColors.success.withOpacity(0.2),
                          width: 1.w,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          LucideIcons.phone,
                          size: 16.sp,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mobile Number',
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              color: const Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            Utils.formatPhoneNumber(volunteer.mobileNo),
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 12.h),
                
                // CNIC Row
                Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: AppColors.warningDark.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: AppColors.warningDark.withOpacity(0.2),
                          width: 1.w,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          LucideIcons.creditCard,
                          size: 16.sp,
                          color: AppColors.warningDark,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CNIC Number',
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              color: const Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            Utils.formatCNIC(volunteer.cnicNo),
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E293B),
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
          
          SizedBox(height: 12.h),
          
      
        ],
      ),
    ),
  ).animate().scale(
    duration: 400.ms,
    curve: Curves.easeOutBack,
    begin: const Offset(0.95, 0.95),
    end: const Offset(1, 1),
  );
}




Widget _buildApproveButton(
  int volunteerId,
  bool isApproved,
) {
  final controller = Get.find<VolunteerController>();

  return Obx(() {
    final bool isApproving = controller.approvingIds.contains(volunteerId);

    return AnimatedSwitcher(
      duration: 300.ms,
      child: isApproving
          ? ApprovingIndicator()
          : isApproved
              ? _approvedState()
              : _approveAction(controller, volunteerId),
      // Optional: add a key for smoother transitions
      key: ValueKey('approve-$volunteerId-$isApproving-$isApproved'),
    );
  });
}

Widget _approvedState() {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.success.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.success.withOpacity(0.3),
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.checkCircle,
              size: 14.sp,
              color: AppColors.success,
            ),
            SizedBox(width: 8.w),
            Text(
              'Approved',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.success,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),

      /// ✨ Shimmer Overlay
      Positioned.fill(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.4),
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0.4),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                begin: Alignment(-1.0, 0.0),
                end: Alignment(2.0, 0.0),
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .shimmer(
                duration: 2000.ms,
                delay: 300.ms,
              ),
        ),
      ),
    ],
  )
      .animate()
      .scale(
        duration: 400.ms,
        curve: Curves.elasticOut,
      );
}

Widget _approveAction(
  VolunteerController controller,
  int volunteerId,
) {
  return Container(
    decoration: BoxDecoration(
          gradient: AppColors.approveVolunteerGradient, // same as main button

      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
        color: AppColors.approveVolunteerShadow,
          blurRadius: 8.r,
          offset: Offset(0, 4.h),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: () => controller.approveVolunteer(volunteerId),
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.checkCircle,
                size: 14.sp,
                color: Colors.white,
              ),
              SizedBox(width: 6.w),
              Text(
                'Approve',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                LucideIcons.users,
                size: 48.sp,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'No volunteers found',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
       
      
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: 5, // Show 5 shimmer cards
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, index) {
        return VolunteerScreenShimmer()
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .shimmer(
              duration: 1500.ms,
              delay: (200 * index).ms,
              angle: 0.3,
              size: 0.6,
            );
      },
    );
  }

  
}

enum ApprovalStatus { pending, approving, approved }


