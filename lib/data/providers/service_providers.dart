import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../firebase_options.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_service.dart';
import '../services/storage_service.dart';

part 'service_providers.g.dart';

// Firebase Initializer
@Riverpod(keepAlive: true)
Future<FirebaseApp> firebaseInitializer(FirebaseInitializerRef ref) async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// Auth Service
@Riverpod(keepAlive: true)
FirebaseAuthService authService(AuthServiceRef ref) {
  return FirebaseAuthService(FirebaseAuth.instance);
}

// Firestore Service
@Riverpod(keepAlive: true)
FirestoreService firestoreService(FirestoreServiceRef ref) {
  return FirestoreService(FirebaseFirestore.instance);
}

// Storage Service
@Riverpod(keepAlive: true)
StorageService storageService(StorageServiceRef ref) {
  return StorageService(FirebaseStorage.instance);
}
