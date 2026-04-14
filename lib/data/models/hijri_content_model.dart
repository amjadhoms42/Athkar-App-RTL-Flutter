import 'base_content_fields.dart';

class HijriContentModel {
  const HijriContentModel({
    required this.base,
    required this.hijriMonth,
    required this.hijriDay,
    required this.entryType,
    required this.title,
    this.eventDescription,
    this.benefit,
    this.recommendedActions,
    this.references,
    this.showInHome = false,
    this.showInWidget = false,
    this.priority = 'medium',
    this.notes,
  });

  final BaseContentFields base;
  final String hijriMonth;
  final int hijriDay;
  final String entryType;
  final String title;
  final String? eventDescription;
  final String? benefit;
  final String? recommendedActions;
  final String? references;
  final bool showInHome;
  final bool showInWidget;
  final String priority;
  final String? notes;

  Map<String, dynamic> toJson() {
    return {
      ...base.toJson(),
      'hijri_month': hijriMonth,
      'hijri_day': hijriDay,
      'entry_type': entryType,
      'title': title,
      'event_description': eventDescription,
      'benefit': benefit,
      'recommended_actions': recommendedActions,
      'references': references,
      'show_in_home': showInHome,
      'show_in_widget': showInWidget,
      'priority': priority,
      'notes': notes,
    };
  }

  static HijriContentModel fromJson(Map<String, dynamic> json) {
    return HijriContentModel(
      base: BaseContentFields.fromJson(json),
      hijriMonth: json['hijri_month'] as String? ?? '',
      hijriDay: json['hijri_day'] as int? ?? 1,
      entryType: json['entry_type'] as String? ?? 'day_note',
      title: json['title'] as String? ?? '',
      eventDescription: json['event_description'] as String?,
      benefit: json['benefit'] as String?,
      recommendedActions: json['recommended_actions'] as String?,
      references: json['references'] as String?,
      showInHome: json['show_in_home'] as bool? ?? false,
      showInWidget: json['show_in_widget'] as bool? ?? false,
      priority: json['priority'] as String? ?? 'medium',
      notes: json['notes'] as String?,
    );
  }
}
