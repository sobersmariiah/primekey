import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primekey_loan_app/core/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/withdrawal_provider.dart';
import '../../../core/utils/formatters.dart';

class StepConfirmation extends ConsumerWidget {
  const StepConfirmation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalProvider);
    final application = state.application;
    final account = state.selectedAccount;

    if (application == null || account == null) {
      return Center(child: Text('Missing information'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          'Confirm Withdrawal',
          style: TextStyle(fontFamily: 'PlusJakartaSans', 
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Review your withdrawal details and destination account carefully before confirming.',
          style: TextStyle(fontFamily: 'PlusJakartaSans', 
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        SizedBox(height: 32),

        // Summary Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      'TOTAL WITHDRAWAL',
                      style: TextStyle(fontFamily: 'PlusJakartaSans', 
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      Formatters.currency(
                          application.loanAmount, application.countryCode),
                      style: TextStyle(fontFamily: 'PlusJakartaSans', 
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildConfirmRow('Destination', account.bankName),
                    SizedBox(height: 16),
                    _buildConfirmRow('Account Number',
                        '•••• ${account.accountNumber.length >= 4 ? account.accountNumber.substring(account.accountNumber.length - 4) : account.accountNumber}'),
                    SizedBox(height: 16),
                    _buildConfirmRow('Reference',
                        '#${application.id.substring(0, 8).toUpperCase()}'),
                    SizedBox(height: 16),
                    _buildConfirmRow('Processing Time', '2-5 Business Days'),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFEDD5)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: Color(0xFFC2410C), size: 18),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'By confirming, you agree to the terms of the withdrawal agreement and acknowledge that funds will be sent to the selected account.',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', 
                    fontSize: 12,
                    color: Color(0xFFC2410C),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontFamily: 'PlusJakartaSans', 
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontFamily: 'PlusJakartaSans', 
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}