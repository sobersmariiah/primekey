import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../../data/models/loan_application_model.dart';
import '../../../../data/providers/service_providers.dart';
import '../../../../data/services/firestore_service.dart';
import '../../../../data/services/storage_service.dart';
import '../../auth/providers/auth_provider.dart';

// Loan state
class LoanState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;
  final List<LoanApplicationModel> applications;

  const LoanState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
    this.applications = const [],
  });

  LoanState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
    List<LoanApplicationModel>? applications,
  }) {
    return LoanState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
      applications: applications ?? this.applications,
    );
  }
}

// Loan notifier
class LoanNotifier extends StateNotifier<LoanState> {
  final FirestoreService _firestoreService;
  final StorageService _storageService;
  final String _userId;
  final String _countryCode;

  LoanNotifier(
    this._firestoreService,
    this._storageService,
    this._userId,
    this._countryCode,
  ) : super(const LoanState()) {
    if (_userId.isNotEmpty) {
      fetchApplications();
    }
  }

  // Submit application
  Future<LoanApplicationModel?> submitApplication({
    required String fullName,
    required String phone,
    required String employmentStatus,
    required String employer,
    required double monthlyIncome,
    // required double interestRate,
    required double loanAmount,
    required String loanPurpose,
    required int loanDuration,
    required String bankName,
    required String accountNumber,
    required List<PlatformFile> documents,
  }) async {
    print('LoanNotifier: Starting submitApplication');
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      final applicationId = const Uuid().v4();
      print('LoanNotifier: Generated applicationId: $applicationId');

      final documentUrls = <String>[];
      for (final document in documents) {
        print('LoanNotifier: Uploading document: ${document.name}');
        final url = await _storageService.uploadFile(
          userId: _userId,
          applicationId: applicationId,
          file: document,
        );
        print('LoanNotifier: Document uploaded, URL: $url');
        documentUrls.add(url);
      }

      final application = LoanApplicationModel(
        id: applicationId,
        userId: _userId,
        fullName: fullName,
        phone: phone,
        countryCode: _countryCode,
        employmentStatus: employmentStatus,
        employer: employer,
        monthlyIncome: monthlyIncome,
        loanAmount: loanAmount,
        loanPurpose: loanPurpose,
        loanDuration: loanDuration,
        // interestRate: interestRate,
        bankName: bankName,
        accountNumber: accountNumber,
        documentUrls: documentUrls,
        status: LoanStatus.pending,
        createdAt: DateTime.now(),
      );

      print('LoanNotifier: Saving application to Firestore');
      await _firestoreService.saveApplication(application);
      print('LoanNotifier: Application saved successfully');

      // Refetch applications so dashboard is up to date
      print('LoanNotifier: Fetching applications after submission');
      await fetchApplications();

      state = state.copyWith(isLoading: false, isSuccess: true);
      return application;
    } catch (e, stack) {
      print('LoanNotifier: Error during submission: $e');
      print(stack);
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  // Fetch user applications
  Future<void> fetchApplications() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final applications = await _firestoreService.getUserApplications(_userId);

      state = state.copyWith(
        isLoading: false,
        applications: applications,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearSuccess() {
    state = state.copyWith(isSuccess: false);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Loan provider
final loanNotifierProvider =
    StateNotifierProvider<LoanNotifier, LoanState>((ref) {
  print('loanNotifierProvider: Building new Notifier instance');
  final firestoreService = ref.watch(firestoreServiceProvider);
  final storageService = ref.watch(storageServiceProvider);
  final currentUser = ref.watch(currentUserProvider).value;

  print('loanNotifierProvider: Current user ID: ${currentUser?.id}');

  // Rebuild provider when user changes
  ref.listen(currentUserProvider, (prev, next) {
    print('loanNotifierProvider: currentUserProvider changed! Reloading notifier.');
  });

  return LoanNotifier(
    firestoreService,
    storageService,
    currentUser?.id ?? '',
    currentUser?.countryCode ?? 'BZ',
  );
});
