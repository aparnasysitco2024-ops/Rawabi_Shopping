// lib/controller/notificationListController.dart

import 'package:get/get.dart';
import 'package:rawabi/utils/notification/notification_storage_service.dart';

class NotificationListController extends GetxController {
  var loading = true.obs;
  var notifications = <StoredNotification>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNotificationList();
  }

  Future<void> getNotificationList() async {
    loading.value = true;
    final list = await NotificationStorageService.loadNotifications();
    print('🔔 Loaded ${list.length} notifications from storage');
    notifications.value = list;
    await NotificationStorageService.markAllRead();
    loading.value = false;
  }

  Future<void> deleteNotification(StoredNotification n) async {
    await NotificationStorageService.deleteNotification(n.id);
    notifications.removeWhere((x) => x.id == n.id);
  }

  Future<void> clearAll() async {
    await NotificationStorageService.clearAll();
    notifications.clear();
  }

  // Called from splashScreen when new FCM message arrives
  Future<void> onNewNotification() async {
    await getNotificationList();
  }
}