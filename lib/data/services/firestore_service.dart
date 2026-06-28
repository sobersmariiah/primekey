import 'dart:developer' as developer;
import 'package:primekey_loan_app/data/models/withdrawal_model.dart';
import 'package:primekey_loan_app/data/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/loan_application_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  // Collection references
  CollectionReference get _users => _firestore.collection('users');

  CollectionReference get _applications =>
      _firestore.collection('loan_applications');

  Future<void> updateBankVerificationStatus({
    required String userId,
    required String bankAccountId,
    required BankVerificationStatus status,
  }) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    final user = UserModel.fromMap(userDoc.data()!);

    final updatedAccounts = user.bankAccounts.map((account) {
      if (account.id == bankAccountId) {
        return BankAccount(
          id: account.id,
          bankName: account.bankName,
          accountNumber: account.accountNumber,
          accountName: account.accountName,
          verificationStatus: status,
        );
      }
      return account;
    }).toList();

    final updatedUser = user.copyWith(bankAccounts: updatedAccounts);
    await _firestore
        .collection('users')
        .doc(userId)
        .update(updatedUser.toMap());
  }

  Future<void> deleteBankAccount({
    required String userId,
    required String bankAccountId,
  }) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) return;

    final user = UserModel.fromMap(userDoc.data()!);

    final updatedAccounts = user.bankAccounts
        .where((account) => account.id != bankAccountId)
        .toList();

    final updatedUser = user.copyWith(bankAccounts: updatedAccounts);
    await _firestore
        .collection('users')
        .doc(userId)
        .update(updatedUser.toMap());
  }

  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _firestore
        .collection('users')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }

  // --- Notification Methods ---

  Stream<List<NotificationModel>> streamUserNotifications(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addNotification(String userId, NotificationModel notification) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .add(notification.toMap());
  }

  Future<void> markNotificationAsRead(String userId, String notificationId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }

  Future<void> markAllNotificationsAsRead(String userId) async {
    final batch = _firestore.batch();
    final unread = await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in unread.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  // Save user
  Future<void> saveUser(UserModel user) async {
    try {
      await _users.doc(user.id).set(user.toMap());
    } catch (e) {
      print('Firestore saveUser error: $e');
      throw 'Failed to save user profile. Please try again.';
    }
  }

  Future<LoanApplicationModel?> getLoanApplicationById(String id) async {
    final doc = await _firestore.collection('loan_applications').doc(id).get();
    if (!doc.exists) return null;
    return LoanApplicationModel.fromMap(
      doc.data()!,
    );
  }

  Future<void> updateVerificationStatus(
      String userId, VerificationStatus status,
      {String? rejectionReason}) async {
    await _firestore.collection('users').doc(userId).update({
      'verificationStatus': status.name,
      'kycRejectionReason': rejectionReason,
    });
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  Future<void> deleteApplication(String applicationId) async {
    await _firestore
        .collection('loan_applications')
        .doc(applicationId)
        .delete();
  }

  // Get user
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _users.doc(userId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw 'Failed to fetch user profile. Please try again.';
    }
  }

  // Save loan application
  Future<void> saveApplication(LoanApplicationModel application) async {
    try {
      print('FirestoreService: Saving application ${application.id}');
      await _applications.doc(application.id).set(application.toMap());
      print('FirestoreService: Application ${application.id} saved');
    } catch (e) {
      print('FirestoreService: Error saving application: $e');
      throw 'Failed to submit application. Please try again.';
    }
  }

  Future<void> saveKycDocuments({
    required String userId,
    required String idDocumentUrl,
    required String selfieUrl,
  }) async {
    await _firestore.collection('users').doc(userId).update({
      'idDocumentUrl': idDocumentUrl,
      'selfieUrl': selfieUrl,
      'verificationStatus': VerificationStatus.pending.name,
    });
  }

// Save a withdrawal
  Future<WithdrawalModel> createWithdrawal(WithdrawalModel withdrawal) async {
    final doc =
        await _firestore.collection('withdrawals').add(withdrawal.toMap());
    return WithdrawalModel.fromMap(withdrawal.toMap(), doc.id);
  }

// Fetch withdrawals for a user
  Future<List<WithdrawalModel>> getUserWithdrawals(String userId) async {
    final snapshot = await _firestore
        .collection('withdrawals')
        .where('userId', isEqualTo: userId)
        .get();

    final list = snapshot.docs
        .map((doc) => WithdrawalModel.fromMap(doc.data(), doc.id))
        .toList();

    // Sort in memory by createdAt descending
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

// Fetch all withdrawals (admin)
  Future<List<WithdrawalModel>> getAllWithdrawals() async {
    final snapshot = await _firestore
        .collection('withdrawals')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => WithdrawalModel.fromMap(doc.data(), doc.id))
        .toList();
  }

// Update withdrawal status (admin)
  Future<void> updateWithdrawalStatus(
      String withdrawalId, WithdrawalStatus status) async {
    await _firestore.collection('withdrawals').doc(withdrawalId).update({
      'status': status.name,
      if (status == WithdrawalStatus.completed)
        'completedAt': DateTime.now().toIso8601String(),
    });
  }

  // Get applications for a specific user
  Future<List<LoanApplicationModel>> getUserApplications(String userId) async {
    try {
      print('FirestoreService: Fetching applications for user $userId');
      final snapshot = await _applications
          .where('userId', isEqualTo: userId)
          .get();

      print('FirestoreService: Found ${snapshot.docs.length} applications');
      final list = snapshot.docs
          .map((doc) =>
              LoanApplicationModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Sort in memory by createdAt descending
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    } catch (e, stack) {
      print('FirestoreService: Error fetching applications: $e');
      print(stack);
      throw 'Failed to fetch applications. Please try again.';
    }
  }

  // Get all applications (admin only)
  Future<List<LoanApplicationModel>> getAllApplications() async {
    try {
      final snapshot =
          await _applications.orderBy('createdAt', descending: true).get();

      return snapshot.docs
          .map((doc) =>
              LoanApplicationModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw 'Failed to fetch applications. Please try again.';
    }
  }

  // Update application status (admin only)
  Future<void> updateApplicationStatus({
    required String applicationId,
    required LoanStatus status,
    required String reviewedBy,
    String? adminNote,
  }) async {
    try {
      await _applications.doc(applicationId).update({
        'status': status.name,
        'reviewedBy': reviewedBy,
        'reviewedAt': DateTime.now().toIso8601String(),
        'adminNote': adminNote,
      });

      // Notify User
      final doc = await _applications.doc(applicationId).get();
      final userId = (doc.data() as Map<String, dynamic>?)?['userId'] as String?;
      
      if (userId != null) {
        final title = 'Loan ${status.name.toUpperCase()}';
        final message = status == LoanStatus.approved 
            ? 'Congratulations! Your loan application has been approved.'
            : 'Your loan application was ${status.name}. ${adminNote ?? ""}';

        await addNotification(userId, NotificationModel(
          id: '',
          title: title,
          message: message,
          type: NotificationType.loan,
          createdAt: DateTime.now(),
          metadata: {'applicationId': applicationId},
        ));
      }
    } catch (e) {
      throw 'Failed to update application. Please try again.';
    }
  }
}
