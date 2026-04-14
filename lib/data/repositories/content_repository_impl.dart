import '../local/content_local_data_source.dart';
import '../models/hijri_content_model.dart';
import '../models/main_item_model.dart';
import '../models/reading_model.dart';
import '../models/reading_segment_model.dart';
import '../models/reminder_model.dart';
import '../models/section_model.dart';
import 'content_repository.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl(this._localDataSource);

  final ContentLocalDataSource _localDataSource;

  @override
  Future<List<SectionModel>> getSections() => _localDataSource.getSections();

  @override
  Future<List<MainItemModel>> getMainItems() => _localDataSource.getMainItems();

  @override
  Future<List<ReadingModel>> getReadings() => _localDataSource.getReadings();

  @override
  Future<List<ReadingSegmentModel>> getReadingSegments(String readingId) {
    return _localDataSource.getReadingSegments(readingId);
  }

  @override
  Future<List<ReminderModel>> getReminders() => _localDataSource.getReminders();

  @override
  Future<List<HijriContentModel>> getHijriContent() {
    return _localDataSource.getHijriContent();
  }
}
