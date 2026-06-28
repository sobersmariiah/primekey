import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/notification_model.dart';
import '../../../data/providers/service_providers.dart';
import '../../auth/providers/auth_provider.dart';

part 'notification_provider.g.dart';

@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  @override
  Stream<List<NotificationModel>> build() {
    final user = ref.watch(currentUserProvider).value;
    if (user == null) return Stream.value([]);

    return ref.watch(firestoreServiceProvider).streamUserNotifications(user.id);
  }

  Future<void> markAsRead(String notificationId) async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;
    
    await ref.read(firestoreServiceProvider).markNotificationAsRead(user.id, notificationId);
  }

  Future<void> markAllAsRead() async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;
    
    await ref.read(firestoreServiceProvider).markAllNotificationsAsRead(user.id);
  }
}

@riverpod
int unreadNotificationsCount(UnreadNotificationsCountRef ref) {
  final notifications = ref.watch(notificationNotifierProvider).value ?? [];
  return notifications.where((n) => !n.isRead).length;
}
