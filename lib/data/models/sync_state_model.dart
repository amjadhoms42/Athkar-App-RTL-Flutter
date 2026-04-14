class SyncStateModel {
  const SyncStateModel({
    required this.contentVersion,
    this.lastSyncAt,
    this.lastError,
  });

  final String contentVersion;
  final DateTime? lastSyncAt;
  final String? lastError;

  Map<String, dynamic> toJson() {
    return {
      'content_version': contentVersion,
      'last_sync_at': lastSyncAt?.toUtc().toIso8601String(),
      'last_error': lastError,
    };
  }

  static SyncStateModel fromJson(Map<String, dynamic> json) {
    return SyncStateModel(
      contentVersion: json['content_version'] as String? ?? '0.0.0',
      lastSyncAt: json['last_sync_at'] != null
          ? DateTime.parse(json['last_sync_at'] as String)
          : null,
      lastError: json['last_error'] as String?,
    );
  }

  SyncStateModel copyWith({
    String? contentVersion,
    DateTime? lastSyncAt,
    String? lastError,
  }) {
    return SyncStateModel(
      contentVersion: contentVersion ?? this.contentVersion,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      lastError: lastError,
    );
  }
}
