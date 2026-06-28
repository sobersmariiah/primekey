import 'package:primekey_loan_app/shared/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/withdrawal_provider.dart';
import '../../../data/models/user_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../../../data/providers/service_providers.dart';

class StepBankSelection extends ConsumerWidget {
  const StepBankSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalProvider);
    final notifier = ref.read(withdrawalProvider.notifier);
    final currentUser = ref.watch(currentUserProvider).value;
    final accounts = currentUser?.bankAccounts ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          'Select bank account',
          style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Select a linked account or connect a new one to complete your withdrawal security check.',
          style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'LINKED ACCOUNTS',
          style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 12),
        if (state.selectedAccount != null &&
            state.selectedAccount!.verificationStatus !=
                BankVerificationStatus.verified)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1F0),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFECACA)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_outlined,
                    color: Color(0xFFB91C1C), size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'The selected account is pending verification. Withdrawals to this account may be delayed until verification is complete.',
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                      fontSize: 12,
                      color: Color(0xFFB91C1C),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            children: [
              ...accounts.asMap().entries.map((entry) {
                final index = entry.key;
                final account = entry.value;
                final isSelected = state.selectedAccount?.id == account.id;
                final isLast = index == accounts.length - 1;
                final isVerified = account.verificationStatus ==
                    BankVerificationStatus.verified;

                return Column(
                  children: [
                    InkWell(
                      onTap: () => notifier.selectAccount(account),
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.account_balance_outlined,
                                  color: AppColors.primary, size: 20),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    account.bankName,
                                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    '•••• ${account.accountNumber.length >= 4 ? account.accountNumber.substring(account.accountNumber.length - 4) : account.accountNumber}',
                                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isVerified
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDCFCE7),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11, vertical: 2),
                                      child: Text(
                                        'VERIFIED',
                                        style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.success,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.errorLight,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(
                                        'UNVERIFIED',
                                        style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.error,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(width: 8),
                            if (isSelected)
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.check,
                                    color: Colors.white, size: 14),
                              )
                            else
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xFFE2E8F0), width: 2),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (!isLast)
                      Divider(height: 0.5, color: Color(0xFFF1F5F9)),
                  ],
                );
              }),
              Divider(height: 0.5, color: Color(0xFFF1F5F9)),
              InkWell(
                onTap: () {
                  if (currentUser!.bankAccounts.length >= 3) {
                    CustomPopup.show(
                      context,
                      title: 'Limit Reached',
                      message: 'Maximum of 3 bank accounts allowed',
                      isWarning: true,
                    );
                  } else {
                    _showAddBankAccountSheet(context, ref, currentUser);
                  }
                },
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.add_circle_outline,
                          color: AppColors.primary, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Link a new bank account',
                          style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: AppColors.textSecondary, size: 16),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Verification ensures funds are transferred only to accounts owned by you. Deposits typically reflect within 2-5 business days.',
                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                    fontSize: 12,
                    color: AppColors.textSecondary,
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

  void _showAddBankAccountSheet(
      BuildContext context, WidgetRef ref, UserModel user) {
    final accountNumberController = TextEditingController();
    final accountNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final currentUser = ref.read(currentUserProvider).value;
    final countryCode = currentUser?.countryCode ?? 'BZ';
    final banks = AppStrings.banksByCountry[countryCode] ?? [];
    String selectedBank = banks.isNotEmpty ? banks.first : '';

    bool isSubmitting = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 32,
            bottom: MediaQuery.of(context).viewInsets.bottom + 32),
        child: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setModalState) => Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Add Bank Account',
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Link your account to receive disbursements.',
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Bank Name',
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedBank.isEmpty ? null : selectedBank,
                    style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                      color: AppColors.textPrimary,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: AppColors.border)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: AppColors.border)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.primary, width: 2)),
                    ),
                    items: banks
                        .map((bank) => DropdownMenuItem(
                              value: bank,
                              child: Text(bank,
                                  style: TextStyle(fontFamily: 'Plus Jakarta Sans', )),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setModalState(() => selectedBank = value!),
                    validator: (value) =>
                        value == null ? 'Please select a bank' : null,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'Account Number',
                    hint: 'Enter account number',
                    controller: accountNumberController,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(Icons.credit_card_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Account number is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'Account Name',
                    hint: 'Enter account name',
                    controller: accountNameController,
                    prefixIcon: Icon(Icons.person_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Account name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isSubmitting ? null : () async {
                        if (!formKey.currentState!.validate()) return;
                        
                        setModalState(() => isSubmitting = true);

                        final newAccount = BankAccount(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          bankName: selectedBank,
                          accountNumber: accountNumberController.text.trim(),
                          accountName: accountNameController.text.trim(),
                          verificationStatus: BankVerificationStatus.pending,
                        );
                        final updatedAccounts = [
                          ...user.bankAccounts,
                          newAccount
                        ];
                        final updatedUser =
                            user.copyWith(bankAccounts: updatedAccounts);
                        try {
                          await ref
                              .read(firestoreServiceProvider)
                              .updateUser(updatedUser);
                          ref.invalidate(currentUserProvider);
                          if (context.mounted) {
                            Navigator.pop(context);
                            CustomPopup.show(
                              context,
                              title: 'Success',
                              message: 'Bank account linked successfully',
                              isWarning: false,
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            setModalState(() => isSubmitting = false);
                            CustomPopup.show(
                              context,
                              title: 'Error',
                              message: 'Error linking bank account: $e',
                              isWarning: true,
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: isSubmitting 
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'LINK ACCOUNT',
                            style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
