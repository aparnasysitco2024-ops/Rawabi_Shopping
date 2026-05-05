import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/controller/notificationListController.dart';
import 'package:rawabi/utils/notification/notification_storage_service.dart';
import 'package:rawabi/widget/headerWidget.dart';

import '../../utils/colors.dart';
import '../../widget/Commonwidget/reusable_text.dart';
import '../../widget/notificationTile.dart';

class NotificationListScreen extends StatelessWidget {
  var title;

  NotificationListScreen({super.key, this.title});

  final notificationListController = Get.put(NotificationListController());

  @override
  Widget build(BuildContext context) {
    notificationListController.getNotificationList();

    return Scaffold(
      backgroundColor: silver,
      body: Column(
        children: [
          _buildHeader(context),
          Obx(
                () => notificationListController.loading.value
                ? SizedBox(
              height: MediaQuery.of(context).size.height - 180,
              child: const Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
            )
                : notificationListController.notifications.isNotEmpty
                ? Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount:
                notificationListController.notifications.length,
                itemBuilder: (context, index) {
                  final n = notificationListController
                      .notifications[index];
                  return NotificationTile(
                    title: n.title,
                    body: n.body,
                    timestamp: n.timestamp,
                    isUnread: n.isUnread,
                    onDelete: () =>
                        notificationListController.deleteNotification(n),
                    onTap: () => _handleNotificationTap(n),
                  );
                },
                separatorBuilder: (_, __) =>
                const SizedBox(height: 5),
              ),
            )
                : Flexible(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/logo.svg",
                      height: 80,
                    ),
                    ReusableText(
                      title: "No notification found!!".tr,
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

  // ── Header ────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          // Your existing HeaderWidget — kept exactly as-is
          HeaderWidget(
            onBack: () {},
            title: title,
          ),
          // ✅ Clear All row — only shows when there are notifications
          Obx(() {
            if (notificationListController.notifications.isEmpty) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${notificationListController.notifications.length} ${'notifications'.tr}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _confirmClearAll(context),
                    child: Text(
                      'Clear All'.tr,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const Divider(height: 1, color: lightGreyColor),
        ],
      ),
    );
  }

  // ── Clear All confirm dialog ──────────────────────────────────────────

  Future<void> _confirmClearAll(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Clear All'.tr),
        content: Text('Remove all notifications?'.tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Clear'.tr,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirm == true) {
      notificationListController.clearAll();
    }
  }

  // ── Deep link handler ─────────────────────────────────────────────────

  void _handleNotificationTap(StoredNotification n) {
    // If no data payload, nothing to route
    if (n.data == null || n.data!.isEmpty) return;

    try {
      final type = n.data!['type']?.toString();
      final id = n.data!['id']?.toString();

      if (type == null) return;

      if (type == 'product' && id != null) {
        Navigator.pushNamed(
          Get.context!,
          '/ProductDetailsScreen',
          arguments: {'productID': id},
        );
      } else if (type == 'itemgroup' && id != null) {
        Navigator.pushNamed(
          Get.context!,
          '/ProductsFromHomeScreen',
          arguments: {'title': '', 'grp_id': id},
        );
      }
    } catch (e) {
      print('Error handling notification tap: $e');
    }
  }
}

// ── Swipeable tile ──────────────────────────────────────────────────────

class _SwipeableNotificationTile extends StatelessWidget {
  final StoredNotification notification;
  final VoidCallback onDelete;

  const _SwipeableNotificationTile({
    required this.notification,
    required this.onDelete,
  });

  String _formatTime(String iso) {
    try {
      final date = DateTime.parse(iso);
      final now = DateTime.now();
      final diff = now.difference(date);
      if (diff.inMinutes < 1) return 'Just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      if (diff.inDays == 1) return 'Yesterday';
      return '${date.day} ${_month(date.month)}';
    } catch (_) {
      return '';
    }
  }

  String _month(int m) => const [
    '',
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ][m];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      key: ValueKey(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Colors.red.shade600,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_outline_rounded, color: Colors.white, size: 22),
            SizedBox(height: 4),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.07),
            width: 0.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Unread dot
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notification.isUnread
                      ? Colors.blue
                      : Colors.transparent,
                ),
              ),
            ),
            // Icon circle
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.blue.withValues(alpha: 0.2)
                    : const Color(0xFFE6F1FB),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.blue,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: notification.isUnread
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatTime(notification.timestamp),
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.white38 : Colors.black38,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}