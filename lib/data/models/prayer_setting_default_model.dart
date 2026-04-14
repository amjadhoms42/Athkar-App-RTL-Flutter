import 'base_content_fields.dart';

class PrayerSettingDefaultModel {
  const PrayerSettingDefaultModel({
    required this.base,
    required this.group,
    required this.key,
    required this.value,
    required this.isUserRelated,
    required this.isEditable,
    required this.fieldType,
    this.description,
    this.example,
    this.notes,
    this.externalLink,
    this.source,
  });

  final BaseContentFields base;
  final String group;
  final String key;
  final String value;
  final bool isUserRelated;
  final bool isEditable;
  final String fieldType;
  final String? description;
  final String? example;
  final String? notes;
  final String? externalLink;
  final String? source;

  Map<String, dynamic> toJson() {
    return {
      ...base.toJson(),
      'group': group,
      'key': key,
      'value': value,
      'is_user_related': isUserRelated,
      'is_editable': isEditable,
      'field_type': fieldType,
      'description': description,
      'example': example,
      'notes': notes,
      'external_link': externalLink,
      'source': source,
    };
  }

  static PrayerSettingDefaultModel fromJson(Map<String, dynamic> json) {
    return PrayerSettingDefaultModel(
      base: BaseContentFields.fromJson(json),
      group: json['group'] as String? ?? '',
      key: json['key'] as String? ?? '',
      value: json['value'] as String? ?? '',
      isUserRelated: json['is_user_related'] as bool? ?? true,
      isEditable: json['is_editable'] as bool? ?? true,
      fieldType: json['field_type'] as String? ?? 'string',
      description: json['description'] as String?,
      example: json['example'] as String?,
      notes: json['notes'] as String?,
      externalLink: json['external_link'] as String?,
      source: json['source'] as String?,
    );
  }
}
