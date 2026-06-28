import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primekey_loan_app/core/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primekey_loan_app/core/utils/formatters.dart';
import 'package:primekey_loan_app/data/models/withdrawal_model.dart';
import 'package:primekey_loan_app/features/auth/providers/auth_provider.dart';
import 'package:primekey_loan_app/app/router.dart';

class WithdrawalSuccessScreen extends ConsumerStatefulWidget {
  final WithdrawalModel withdrawal;

  const WithdrawalSuccessScreen({super.key, required this.withdrawal});

  @override
  ConsumerState<WithdrawalSuccessScreen> createState() =>
      _WithdrawalSuccessScreenState();
}

class _WithdrawalSuccessScreenState
    extends ConsumerState<WithdrawalSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider).value;
    final countryCode = currentUser?.countryCode ?? 'BZ';
    final w = widget.withdrawal;

    final last4 = w.accountNumber.length >= 4
        ? w.accountNumber.substring(w.accountNumber.length - 4)
        : w.accountNumber;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6F9),
        elevation: 0,
        title: Text(
          'Transaction',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        SizedBox(height: 16),

                        // ── Success icon ──────────────────
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Container(
                                width: 64,
                                height: 64,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 34,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 28),

                        // ── Title ─────────────────────────
                        Text(
                          'Withdrawal Requested',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 14),

                        Text(
                          'Your withdrawal request has been successfully submitted and is now pending review. This process typically takes 1–2 business days.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 32),

                        // ── Summary card ──────────────────
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Amount
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 28, 24, 20),
                                child: Column(
                                  children: [
                                    Text(
                                      'AMOUNT REQUESTED',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textSecondary,
                                        letterSpacing: 1.4,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      Formatters.currency(
                                          w.amount, countryCode),
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 42,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Divider(
                                  height: 0.5, color: Color(0xFFF1F5F9)),

                              // Details
                              Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  children: [
                                    _buildDetailRow(
                                      'DESTINATION',
                                      w.bankName,
                                      subtitle: 'Ending in $last4',
                                    ),
                                    SizedBox(height: 20),
                                    _buildDetailRow(
                                      'STATUS',
                                      'PENDING REVIEW',
                                      isStatus: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Bottom buttons ────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            color: const Color(0xFFF4F6F9),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  children: [
                    // Back to dashboard
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.go(AppRoutes.dashboard),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Back to Dashboard',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.dashboard_outlined, size: 18),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // View receipt
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.withdrawals),
                      child: Text(
                        'View Withdrawals',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    String? subtitle,
    bool isStatus = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isStatus)
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    value,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              )
            else
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            if (subtitle != null) ...[
              SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}