import 'base_content_fields.dart';

class MainItemModel {
  const MainItemModel({
    required this.base,
    required this.title,
    required this.body,
    required this.itemType,
    required this.mainSection,
    required this.interactionType,
    required this.defaultCount,
    required this.allowCustomCount,
    required this.showInHome,
    this.subSection,
    this.contentState,
    this.evidence,
    this.source,
    this.benefit,
    this.displayNotes,
    this.afterPrayerLink = false,
    this.showInDhikrAllah = false,
    this.externalLink,
  });

  final BaseContentFields base;
  final String title;
  final String body;
  final String itemType;
  final String mainSection;
  final String? subSection;
  final String? contentState;
  final String interactionType;
  final int defaultCount;
  final bool allowCustomCount;
  final String? evidence;
  final String? source;
  final String? benefit;
  final String? displayNotes;
  final bool afterPrayerLink;
  final bool showInDhikrAllah;
  final bool showInHome;
  final String? externalLink;

  Map<String, dynamic> toJson() {
    return {
      ...base.toJson(),
      'title': title,
      'body': body,
      'item_type': itemType,
      'main_section': mainSection,
      'sub_section': subSection,
      'content_state': contentState,
      'interaction_type': interactionType,
      'default_count': defaultCount,
      'allow_custom_count': allowCustomCount,
      'evidence': evidence,
      'source': source,
      'benefit': benefit,
      'display_notes': displayNotes,
      'after_prayer_link': afterPrayerLink,
      'show_in_dhikr_allah': showInDhikrAllah,
      'show_in_home': showInHome,
      'external_link': externalLink,
    };
  }

  static MainItemModel fromJson(Map<String, dynamic> json) {
    return MainItemModel(
      base: BaseContentFields.fromJson(json),
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      itemType: json['item_type'] as String? ?? 'general',
      mainSection: json['main_section'] as String? ?? '',
      subSection: json['sub_section'] as String?,
      contentState: json['content_state'] as String?,
      interactionType: json['interaction_type'] as String? ?? 'counter',
      defaultCount: json['default_count'] as int? ?? 1,
      allowCustomCount: json['allow_custom_count'] as bool? ?? false,
      evidence: json['evidence'] as String?,
      source: json['source'] as String?,
      benefit: json['benefit'] as String?,
      displayNotes: json['display_notes'] as String?,
      afterPrayerLink: json['after_prayer_link'] as bool? ?? false,
      showInDhikrAllah: json['show_in_dhikr_allah'] as bool? ?? false,
      showInHome: json['show_in_home'] as bool? ?? false,
      externalLink: json['external_link'] as String?,
    );
  }
}
