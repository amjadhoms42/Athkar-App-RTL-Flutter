import 'base_content_fields.dart';

class ReminderModel {
  const ReminderModel({
    required this.base,
    required this.referenceType,
    required this.referenceId,
    required this.title,
    required this.reminderType,
    this.timeOfDay,
    this.activeDays = const <String>[],
    this.linkedToAdhan = false,
    this.linkedToPostPrayer = false,
    this.prayerType,
    this.repeatUntilDone = false,
    this.priority = 'medium',
    this.notificationMessage,
    this.linkedWidget,
    this.notes,
  });

  final BaseContentFields base;
  final String referenceType;
  final String referenceId;
  final String title;
  final String reminderType;
  final String? timeOfDay;
  final List<String> activeDays;
  final bool linkedToAdhan;
  final bool linkedToPostPrayer;
  final String? prayerType;
  final bool repeatUntilDone;
  final String priority;
  final String? notificationMessage;
  final String? linkedWidget;
  final String? notes;

  Map<String, dynamic> toJson() {
    return {
      ...base.toJson(),
      'reference_type': referenceType,
      'reference_id': referenceId,
      'title': title,
      'reminder_type': reminderType,
      'time_of_day': timeOfDay,
      'active_days': activeDays,
      'linked_to_adhan': linkedToAdhan,
      'linked_to_post_prayer': linkedToPostPrayer,
      'prayer_type': prayerType,
      'repeat_until_done': repeatUntilDone,
      'priority': priority,
      'notification_message': notificationMessage,
      'linked_widget': linkedWidget,
      'notes': notes,
    };
  }

  static ReminderModel fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      base: BaseContentFields.fromJson(json),
      referenceType: json['reference_type'] as String? ?? 'item',
      referenceId: json['reference_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      reminderType: json['reminder_type'] as String? ?? 'daily',
      timeOfDay: json['time_of_day'] as String?,
      activeDays: (json['active_days'] as List<dynamic>? ?? <dynamic>[])
          .map((e) => e.toString())
          .toList(),
      linkedToAdhan: json['linked_to_adhan'] as bool? ?? false,
      linkedToPostPrayer: json['linked_to_post_prayer'] as bool? ?? false,
      prayerType: json['prayer_type'] as String?,
      repeatUntilDone: json['repeat_until_done'] as bool? ?? false,
      priority: json['priority'] as String? ?? 'medium',
      notificationMessage: json['notification_message'] as String?,
      linkedWidget: json['linked_widget'] as String?,
      notes: json['notes'] as String?,
    );
  }
}
