import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:primekey_loan_app/core/app_config.dart';

class EmailService {
  static Future<bool> _send({
    required String toEmail,
    required String subject,
    required String content,
    String? status,
    String? fullName,
    String? referenceNo,
    String? loanAmount,
    String? monthlyRepayment,
    String? duration,
    String? reason,
  }) async {
    try {
      final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      final response = await http.post(
        Uri.parse('${AppConfig.agreementApiUrl}/send-notification-email'),
        headers: {
          'Content-Type': 'application/json',
          if (idToken != null) 'Authorization': 'Bearer $idToken',
        },
        body: jsonEncode({
          'to_email': toEmail,
          'subject': subject,
          'content': content,
          if (status != null) 'status': status,
          if (fullName != null) 'full_name': fullName,
          if (referenceNo != null) 'reference_no': referenceNo,
          if (loanAmount != null) 'loan_amount': loanAmount,
          if (monthlyRepayment != null) 'monthly_repayment': monthlyRepayment,
          if (duration != null) 'duration': duration,
          if (reason != null) 'reason': reason,
        }),
      );
      if (response.statusCode != 200) {
        print('EmailService: Failed to send email via Render API. Code: ${response.statusCode}, Body: ${response.body}');
        return false;
      }
      print('EmailService: Email sent successfully via Render API to $toEmail');
      return true;
    } catch (e) {
      print('EmailService: Error sending email: $e');
      return false;
    }
  }

  static Future<bool> sendWelcomeEmail({
    required String toEmail,
    required String toName,
  }) async {
    final firstName = toName.split(' ').first;
    final subject = 'Welcome to Primekey Finance!';
    final content = '''
Hi $firstName,

Welcome to Primekey Finance! We're excited to help you with your financial needs.

To get started, please log in and complete your KYC verification on the dashboard so you can apply for your first loan.

Best regards,
Primekey Finance Team
''';
    return _send(toEmail: toEmail, subject: subject, content: content);
  }

  static Future<bool> sendKycRejectionEmail({
    required String toEmail,
    required String toName,
    String? reason,
  }) async {
    final firstName = toName.split(' ').first;
    final subject = 'KYC Verification Rejected';
    final reasonText = reason != null && reason.isNotEmpty 
        ? '\n\nRemarks:\n"$reason"'
        : '';
    final content = '''
Hi $firstName,

Unfortunately, your identity verification (KYC) documents could not be approved. $reasonText

Please log in to your dashboard to re-upload clear documents.

Best regards,
Primekey Finance Team
''';
    return _send(toEmail: toEmail, subject: subject, content: content);
  }

  static Future<bool> sendKycApprovalEmail({
    required String toEmail,
    required String toName,
  }) async {
    final firstName = toName.split(' ').first;
    final subject = 'KYC Verification Approved!';
    final content = '''
Hi $firstName,

Congratulations! Your identity verification (KYC) has been successfully approved. 

You can now apply for loans and access all features of the Primekey platform.

Best regards,
Primekey Finance Team
''';
    return _send(toEmail: toEmail, subject: subject, content: content);
  }

  static Future<bool> sendBankVerEmail({
    required String toEmail,
    required String toName,
  }) async {
    final firstName = toName.split(' ').first;
    final subject = 'Bank Account Verified';
    final content = '''
Hi $firstName,

Your bank account details have been successfully verified by our underwriting team.

Best regards,
Primekey Finance Team
''';
    return _send(toEmail: toEmail, subject: subject, content: content);
  }

  static Future<bool> sendSubmittedEmail({
    required String toEmail,
    required String toName,
    required String loanAmount,
    required String referenceNo,
    required String repayment,
    required int duration,
  }) async {
    final firstName = toName.split(' ').first;
    final subject = 'Loan Application Received - $referenceNo';
    final content = '''
Hi $firstName,

Thank you for applying for a loan with Primekey Finance.

We have successfully received your application for $loanAmount (Ref: $referenceNo). Our underwriting team will review it shortly.

You can monitor the status of your application from your user dashboard at any time.

Best regards,
Primekey Finance Team
''';
    return _send(
      toEmail: toEmail, 
      subject: subject, 
      content: content,
      status: 'submitted',
      fullName: toName,
      referenceNo: referenceNo,
      loanAmount: loanAmount,
      monthlyRepayment: repayment,
      duration: '$duration months',
    );
  }

  static Future<bool> sendApprovalEmail({
    required String toEmail,
    required String toName,
    required String loanAmount,
    required String referenceNo,
    required String repayment,
    required int duration,
    String? reason,
  }) async {
    return _send(
      toEmail: toEmail,
      subject: 'Loan Application APPROVED - $referenceNo',
      content: 'Congratulations! Your loan application $referenceNo has been approved.',
      status: 'approved',
      fullName: toName,
      referenceNo: referenceNo,
      loanAmount: loanAmount,
      monthlyRepayment: repayment,
      duration: '$duration months',
      reason: reason,
    );
  }

  static Future<bool> sendRejectionEmail({
    required String toEmail,
    required String toName,
    required String loanAmount,
    required String referenceNo,
    required String repayment,
    required int duration,
    String? reason,
  }) async {
    return _send(
      toEmail: toEmail,
      subject: 'Loan Application Rejected - $referenceNo',
      content: 'Unfortunately, your loan application $referenceNo was not approved at this time.',
      status: 'rejected',
      fullName: toName,
      referenceNo: referenceNo,
      loanAmount: loanAmount,
      monthlyRepayment: repayment,
      duration: '$duration months',
      reason: reason,
    );
  }
}
