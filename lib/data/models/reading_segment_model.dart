import 'base_content_fields.dart';

class ReadingSegmentModel {
  const ReadingSegmentModel({
    required this.base,
    required this.readingId,
    required this.segmentNumber,
    required this.body,
    this.subtitle,
    this.shortExplanation,
    this.benefit,
    this.shareable = false,
    this.trackCompletionSeparately = false,
    this.externalLink,
    this.notes,
  });

  final BaseContentFields base;
  final String readingId;
  final int segmentNumber;
  final String body;
  final String? subtitle;
  final String? shortExplanation;
  final String? benefit;
  final bool shareable;
  final bool trackCompletionSeparately;
  final String? externalLink;
  final String? notes;

  Map<String, dynamic> toJson() {
    return {
      ...base.toJson(),
      'reading_id': readingId,
      'segment_number': segmentNumber,
      'body': body,
      'subtitle': subtitle,
      'short_explanation': shortExplanation,
      'benefit': benefit,
      'shareable': shareable,
      'track_completion_separately': trackCompletionSeparately,
      'external_link': externalLink,
      'notes': notes,
    };
  }

  static ReadingSegmentModel fromJson(Map<String, dynamic> json) {
    return ReadingSegmentModel(
      base: BaseContentFields.fromJson(json),
      readingId: json['reading_id'] as String? ?? '',
      segmentNumber: json['segment_number'] as int? ?? 1,
      body: json['body'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
      shortExplanation: json['short_explanation'] as String?,
      benefit: json['benefit'] as String?,
      shareable: json['shareable'] as bool? ?? false,
      trackCompletionSeparately:
          json['track_completion_separately'] as bool? ?? false,
      externalLink: json['external_link'] as String?,
      notes: json['notes'] as String?,
    );
  }
}
