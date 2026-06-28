import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../app/router.dart';
import '../../../data/models/user_model.dart';

import '../../../data/providers/user_providers.dart';

class KycStatusScreen extends ConsumerWidget {
  final String userId;
  const KycStatusScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userByIdProvider(userId));

    return userAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
      data: (user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('User not found')),
          );
        }

        final status = user.verificationStatus;
        final isVerified = status == VerificationStatus.verified;
        final isRejected = status == VerificationStatus.unverified;

        final Color circleColor = isVerified
            ? AppColors.success
            : isRejected
                ? AppColors.error
                : AppColors.pending;

        final Color circleBgColor = isVerified
            ? AppColors.successLight
            : isRejected
                ? AppColors.errorLight
                : AppColors.pendingLight;

        final IconData statusIcon = isVerified
            ? Icons.check_circle_rounded
            : isRejected
                ? Icons.cancel_rounded
                : Icons.hourglass_empty_rounded;

        final String statusLabel = isVerified
            ? 'Verified'
            : isRejected
                ? 'Rejected'
                : 'Pending';

        final String statusMessage = isVerified
            ? 'Your identity has been successfully verified.'
            : isRejected
                ? 'Your identity verification was declined.'
                : 'Your identity verification is awaiting review.';

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => context.go(AppRoutes.admin),
            ),
            title: Text(
              'KYC Status',
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: [
                  const Spacer(),

                  // Big status circle
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      color: circleBgColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: circleColor, width: 3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(statusIcon, size: 72, color: circleColor),
                        SizedBox(height: 12),
                        Text(
                          statusLabel,
                          style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: circleColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32),

                  // User name
                  Text(
                    user.fullName,
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Status message
                  Text(
                    statusMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),

                  // Review button — goes to KYC approval screen

                  SizedBox(height: 16),

                  TextButton(
                    onPressed: () => context.go(AppRoutes.admin),
                    child: Text(
                      'Back to Dashboard',
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', color: AppColors.textSecondary),
                    ),
                  ),

                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}