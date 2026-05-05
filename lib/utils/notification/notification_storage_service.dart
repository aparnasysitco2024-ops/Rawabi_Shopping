import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StoredNotification {
  final String id;
  final String title;
  final String body;
  final String timestamp;
  final Map<String, dynamic>? data;
  final bool isUnread;

  StoredNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.data,
    this.isUnread = true,
  });

  factory StoredNotification.fromJson(Map<String, dynamic> json) {
    return StoredNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      timestamp: json['timestamp'] as String,
      data: json['data'] != null
          ? Map<String, dynamic>.from(json['data'] as Map)
          : null,
      isUnread: json['isUnread'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'timestamp': timestamp,
    'data': data,
    'isUnread': isUnread,
  };

  StoredNotification copyWith({bool? isUnread}) => StoredNotification(
    id: id,
    title: title,
    body: body,
    timestamp: timestamp,
    data: data,
    isUnread: isUnread ?? this.isUnread,
  );
}

class NotificationStorageService {
  static const _key = 'stored_notifications';
  static const _expiryDays = 3;

  /// Save a new notification. Automatically purges expired ones first.
  static Future<void> saveNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final all = await _loadRaw(prefs);

    // Remove notifications older than 3 days
    final cutoff = DateTime.now().subtract(const Duration(days: _expiryDays));
    final fresh = all.where((n) {
      try {
        return DateTime.parse(n.timestamp).isAfter(cutoff);
      } catch (_) {
        return false;
      }
    }).toList();

    // Add the new notification at the top
    fresh.insert(
      0,
      StoredNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        body: body,
        timestamp: DateTime.now().toIso8601String(),
        data: data,
        isUnread: true,
      ),
    );

    await prefs.setString(
      _key,
      jsonEncode(fresh.map((n) => n.toJson()).toList()),
    );
  }

  /// Load all non-expired notifications.
  static Future<List<StoredNotification>> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final all = await _loadRaw(prefs);

    final cutoff = DateTime.now().subtract(const Duration(days: _expiryDays));
    final fresh = all.where((n) {
      try {
        return DateTime.parse(n.timestamp).isAfter(cutoff);
      } catch (_) {
        return false;
      }
    }).toList();

    // Persist purged list back
    if (fresh.length != all.length) {
      await prefs.setString(
        _key,
        jsonEncode(fresh.map((n) => n.toJson()).toList()),
      );
    }

    return fresh;
  }

  /// Delete a single notification by id.
  static Future<void> deleteNotification(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final all = await _loadRaw(prefs);
    final updated = all.where((n) => n.id != id).toList();
    await prefs.setString(
      _key,
      jsonEncode(updated.map((n) => n.toJson()).toList()),
    );
  }

  /// Mark all as read.
  static Future<void> markAllRead() async {
    final prefs = await SharedPreferences.getInstance();
    final all = await _loadRaw(prefs);
    final updated = all.map((n) => n.copyWith(isUnread: false)).toList();
    await prefs.setString(
      _key,
      jsonEncode(updated.map((n) => n.toJson()).toList()),
    );
  }

  /// Clear everything.
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static Future<List<StoredNotification>> _loadRaw(
      SharedPreferences prefs) async {
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => StoredNotification.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Debug: print all stored notifications to console
  static Future<void> debugPrint() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    print('🗄️ RAW STORAGE: $raw');
    final list = await loadNotifications();
    print('🔔 Total notifications: ${list.length}');
    for (final n in list) {
      print('   [${n.id}] ${n.title} — ${n.timestamp}');
    }
  }
}