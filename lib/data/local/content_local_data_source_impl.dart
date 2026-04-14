import '../../core/storage/local_database.dart';
import '../models/hijri_content_model.dart';
import '../models/main_item_model.dart';
import '../models/reading_model.dart';
import '../models/reading_segment_model.dart';
import '../models/reminder_model.dart';
import '../models/section_model.dart';
import 'content_local_data_source.dart';

class ContentLocalDataSourceImpl implements ContentLocalDataSource {
  ContentLocalDataSourceImpl(this._db);

  final LocalDatabase _db;

  static const _sectionsBox = 'content_sections';
  static const _mainItemsBox = 'content_main_items';
  static const _readingsBox = 'content_readings';
  static const _readingSegmentsBox = 'content_reading_segments';
  static const _remindersBox = 'content_reminders';
  static const _hijriBox = 'content_hijri';

  @override
  Future<void> upsertSections(List<SectionModel> sections) async {
    for (final entry in sections) {
      await _db.put(_sectionsBox, entry.base.id, entry.toJson());
    }
  }

  @override
  Future<void> upsertMainItems(List<MainItemModel> items) async {
    for (final entry in items) {
      await _db.put(_mainItemsBox, entry.base.id, entry.toJson());
    }
  }

  @override
  Future<void> upsertReadings(List<ReadingModel> readings) async {
    for (final entry in readings) {
      await _db.put(_readingsBox, entry.base.id, entry.toJson());
    }
  }

  @override
  Future<void> upsertReadingSegments(List<ReadingSegmentModel> segments) async {
    for (final entry in segments) {
      await _db.put(_readingSegmentsBox, entry.base.id, entry.toJson());
    }
  }

  @override
  Future<void> upsertReminders(List<ReminderModel> reminders) async {
    for (final entry in reminders) {
      await _db.put(_remindersBox, entry.base.id, entry.toJson());
    }
  }

  @override
  Future<void> upsertHijriContent(List<HijriContentModel> hijriContent) async {
    for (final entry in hijriContent) {
      await _db.put(_hijriBox, entry.base.id, entry.toJson());
    }
  }

  @override
  Future<List<SectionModel>> getSections() async {
    final rows = await _db.getAll(_sectionsBox);
    return rows.map(SectionModel.fromJson).toList(growable: false)
      ..sort((a, b) => a.base.sortOrder.compareTo(b.base.sortOrder));
  }

  @override
  Future<List<MainItemModel>> getMainItems() async {
    final rows = await _db.getAll(_mainItemsBox);
    return rows.map(MainItemModel.fromJson).toList(growable: false)
      ..sort((a, b) => a.base.sortOrder.compareTo(b.base.sortOrder));
  }

  @override
  Future<List<ReadingModel>> getReadings() async {
    final rows = await _db.getAll(_readingsBox);
    return rows.map(ReadingModel.fromJson).toList(growable: false)
      ..sort((a, b) => a.base.sortOrder.compareTo(b.base.sortOrder));
  }

  @override
  Future<List<ReadingSegmentModel>> getReadingSegments(String readingId) async {
    final rows = await _db.getAll(_readingSegmentsBox);
    final segments = rows
        .map(ReadingSegmentModel.fromJson)
        .where((segment) => segment.readingId == readingId)
        .toList(growable: false);
    segments.sort((a, b) => a.base.sortOrder.compareTo(b.base.sortOrder));
    return segments;
  }

  @override
  Future<List<ReminderModel>> getReminders() async {
    final rows = await _db.getAll(_remindersBox);
    return rows.map(ReminderModel.fromJson).toList(growable: false)
      ..sort((a, b) => a.base.sortOrder.compareTo(b.base.sortOrder));
  }

  @override
  Future<List<HijriContentModel>> getHijriContent() async {
    final rows = await _db.getAll(_hijriBox);
    return rows.map(HijriContentModel.fromJson).toList(growable: false)
      ..sort((a, b) => a.base.sortOrder.compareTo(b.base.sortOrder));
  }
}
