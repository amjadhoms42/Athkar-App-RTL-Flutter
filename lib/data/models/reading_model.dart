import 'base_content_fields.dart';

class ReadingModel {
  const ReadingModel({
    required this.base,
    required this.title,
    required this.readingType,
    required this.section,
    this.shortDescription,
    this.source,
    this.benefit,
    this.suggestedTime,
    this.reminderEnabledDefault = false,
    this.afterPrayerLink = false,
    this.segmentCount,
    this.estimatedMinutes,
    this.externalLink,
    this.notes,
  });

  final BaseContentFields base;
  final String title;
  final String readingType;
  final String section;
  final String? shortDescription;
  final String? source;
  final String? benefit;
  final String? suggestedTime;
  final bool reminderEnabledDefault;
  final bool afterPrayerLink;
  final int? segmentCount;
  final int? estimatedMinutes;
  final String? externalLink;
  final String? notes;

  Map<String, dynamic> toJson() {
    return {
      ...base.toJson(),
      'title': title,
      'reading_type': readingType,
      'section': section,
      'short_description': shortDescription,
      'source': source,
      'benefit': benefit,
      'suggested_time': suggestedTime,
      'reminder_enabled_default': reminderEnabledDefault,
      'after_prayer_link': afterPrayerLink,
      'segment_count': segmentCount,
      'estimated_minutes': estimatedMinutes,
      'external_link': externalLink,
      'notes': notes,
    };
  }

  static ReadingModel fromJson(Map<String, dynamic> json) {
    return ReadingModel(
      base: BaseContentFields.fromJson(json),
      title: json['title'] as String? ?? '',
      readingType: json['reading_type'] as String? ?? 'wird',
      section: json['section'] as String? ?? '',
      shortDescription: json['short_description'] as String?,
      source: json['source'] as String?,
      benefit: json['benefit'] as String?,
      suggestedTime: json['suggested_time'] as String?,
      reminderEnabledDefault: json['reminder_enabled_default'] as bool? ?? false,
      afterPrayerLink: json['after_prayer_link'] as bool? ?? false,
      segmentCount: json['segment_count'] as int?,
      estimatedMinutes: json['estimated_minutes'] as int?,
      externalLink: json['external_link'] as String?,
      notes: json['notes'] as String?,
    );
  }
}
