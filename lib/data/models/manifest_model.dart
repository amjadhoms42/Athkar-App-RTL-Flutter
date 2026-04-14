class ManifestFileModel {
  const ManifestFileModel({
    required this.name,
    required this.checksum,
    required this.size,
    required this.required,
  });

  final String name;
  final String checksum;
  final int size;
  final bool required;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'checksum': checksum,
      'size': size,
      'required': required,
    };
  }

  static ManifestFileModel fromJson(Map<String, dynamic> json) {
    return ManifestFileModel(
      name: json['name'] as String,
      checksum: json['checksum'] as String,
      size: json['size'] as int,
      required: json['required'] as bool? ?? true,
    );
  }
}

class ManifestModel {
  const ManifestModel({
    required this.contentVersion,
    required this.generatedAt,
    required this.files,
    this.minimumSupportedAppVersion,
    this.notes,
    this.metadata,
  });

  final String contentVersion;
  final DateTime generatedAt;
  final List<ManifestFileModel> files;
  final String? minimumSupportedAppVersion;
  final String? notes;
  final Map<String, dynamic>? metadata;

  Map<String, dynamic> toJson() {
    return {
      'content_version': contentVersion,
      'generated_at': generatedAt.toUtc().toIso8601String(),
      'minimum_supported_app_version': minimumSupportedAppVersion,
      'notes': notes,
      'metadata': metadata,
      'files': files.map((e) => e.toJson()).toList(),
    };
  }

  static ManifestModel fromJson(Map<String, dynamic> json) {
    return ManifestModel(
      contentVersion: json['content_version'] as String,
      generatedAt: DateTime.parse(json['generated_at'] as String),
      minimumSupportedAppVersion:
          json['minimum_supported_app_version'] as String?,
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      files: (json['files'] as List<dynamic>? ?? <dynamic>[])
          .map((entry) => ManifestFileModel.fromJson(entry as Map<String, dynamic>))
          .toList(),
    );
  }

  bool isNewerThan(String localVersion) {
    List<int> parseVersion(String value) {
      return value
          .split('.')
          .map((part) => int.tryParse(part) ?? 0)
          .toList(growable: false);
    }

    final remote = parseVersion(contentVersion);
    final local = parseVersion(localVersion);
    final maxLength = remote.length > local.length ? remote.length : local.length;

    for (var i = 0; i < maxLength; i++) {
      final remotePart = i < remote.length ? remote[i] : 0;
      final localPart = i < local.length ? local[i] : 0;
      if (remotePart > localPart) return true;
      if (remotePart < localPart) return false;
    }
    return false;
  }
}
