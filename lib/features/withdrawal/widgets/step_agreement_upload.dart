import 'package:primekey_loan_app/shared/widgets/custom_popup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/withdrawal_provider.dart';

class StepAgreementUpload extends ConsumerWidget {
  const StepAgreementUpload({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalProvider);
    final notifier = ref.read(withdrawalProvider.notifier);

    Future<void> pickFile() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        withData: true,
        allowMultiple: true,
      );

      if (result == null || result.files.isEmpty) return;
      try {
        for (final file in result.files) {
          await notifier.uploadDocument(file);
        }
      } catch (e) {
        if (context.mounted) {
          CustomPopup.show(
            context,
            title: 'Upload Failed',
            message: 'One or more uploads failed: $e',
            isWarning: true,
          );
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          'Verification Required for Withdrawal',
          style: TextStyle(fontFamily: 'Ubuntu', 
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            height: 1.2,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'To ensure regulatory compliance and secure your funds, please review and upload your signed withdrawal agreement. You can upload multiple documents if necessary.',
          style: TextStyle(fontFamily: 'Ubuntu', 
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Icon(Icons.insert_drive_file_outlined,
                  color: AppColors.primary, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'WITHDRAWAL_AGREEMENT.PDF',
                  style: TextStyle(fontFamily: 'Ubuntu', 
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        if (state.uploadedDocuments.isNotEmpty) ...[
          Text(
            'Uploaded Documents',
            style: TextStyle(fontFamily: 'Ubuntu', 
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 12),
          ...state.uploadedDocuments.asMap().entries.map((entry) {
            final index = entry.key;
            final file = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle,
                      color: AppColors.success, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      file.name,
                      style: TextStyle(fontFamily: 'Ubuntu', 
                        fontSize: 13,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close,
                        color: AppColors.textSecondary, size: 18),
                    onPressed: () => notifier.removeDocument(index),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 16),
        ],
        GestureDetector(
          onTap: state.isUploading ? null : pickFile,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.isUploading)
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    )
                  else
                    Icon(Icons.upload_file_outlined,
                        color: AppColors.primary, size: 18),
                  SizedBox(width: 10),
                  Text(
                    state.isUploading
                        ? 'Uploading...'
                        : state.uploadedDocuments.isEmpty
                            ? 'Upload Signed Copy'
                            : 'Upload More Documents',
                    style: TextStyle(fontFamily: 'Ubuntu', 
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.shield_outlined,
                    color: AppColors.primary, size: 18),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ENCRYPTED & SECURE',
                      style: TextStyle(fontFamily: 'Ubuntu', 
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Your digital signature is legally binding and protected by 256-bit bank-grade encryption.',
                      style: TextStyle(fontFamily: 'Ubuntu', 
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}