class BaseContentFields {
  const BaseContentFields({
    required this.id,
    required this.updatedAt,
    required this.isActive,
    required this.sortOrder,
    required this.sourceType,
    required this.revision,
    required this.isDeleted,
  });

  final String id;
  final DateTime updatedAt;
  final bool isActive;
  final int sortOrder;
  final String sourceType;
  final int revision;
  final bool isDeleted;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'updated_at': updatedAt.toUtc().toIso8601String(),
      'is_active': isActive,
      'sort_order': sortOrder,
      'source_type': sourceType,
      'revision': revision,
      'is_deleted': isDeleted,
    };
  }

  static BaseContentFields fromJson(Map<String, dynamic> json) {
    return BaseContentFields(
      id: json['id'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isActive: json['is_active'] as bool? ?? true,
      sortOrder: json['sort_order'] as int? ?? 0,
      sourceType: json['source_type'] as String? ?? 'seed',
      revision: json['revision'] as int? ?? 1,
      isDeleted: json['is_deleted'] as bool? ?? false,
    );
  }
}
