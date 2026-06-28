import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class WithdrawalStepIndicator extends StatelessWidget {
  final int currentStep;

  const WithdrawalStepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = [
      'Upload Agreement',
      'Bank Verification',
      'Confirm Withdrawal'
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        children: [
          Row(
            children: List.generate(steps.length, (i) {
              final isComplete = i < currentStep;
              final isActive = i == currentStep;
              return Expanded(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isComplete || isActive
                                ? AppColors.primary
                                : const Color(0xFFE2E8F0),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: isComplete
                                ? Icon(Icons.check,
                                    color: Colors.white, size: 16)
                                : Text(
                                    '${i + 1}',
                                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: isActive
                                          ? Colors.white
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          steps[i].toUpperCase(),
                          style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: isActive || isComplete
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        if (isComplete)
                          Text(
                            'Verified',
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                              fontSize: 9,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                      ],
                    ),
                    if (i < steps.length - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: const EdgeInsets.only(bottom: 20),
                          color: i < currentStep
                              ? AppColors.primary
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 20),
          Text(
            'STEP ${currentStep + 1}: ${[
              'UPLOAD AGREEMENT',
              'BANK VERIFICATION',
              'CONFIRM WITHDRAWAL'
            ][currentStep]}',
            style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (currentStep + 1) / 3,
              backgroundColor: const Color(0xFFE2E8F0),
              color: AppColors.primary,
              minHeight: 3,
            ),
          ),
        ],
      ),
    );
  }
}