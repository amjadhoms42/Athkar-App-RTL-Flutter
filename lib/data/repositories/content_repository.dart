import '../models/hijri_content_model.dart';
import '../models/main_item_model.dart';
import '../models/reading_model.dart';
import '../models/reading_segment_model.dart';
import '../models/reminder_model.dart';
import '../models/section_model.dart';

abstract class ContentRepository {
  Future<List<SectionModel>> getSections();
  Future<List<MainItemModel>> getMainItems();
  Future<List<ReadingModel>> getReadings();
  Future<List<ReadingSegmentModel>> getReadingSegments(String readingId);
  Future<List<ReminderModel>> getReminders();
  Future<List<HijriContentModel>> getHijriContent();
}
