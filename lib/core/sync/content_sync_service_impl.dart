import '../../data/local/content_local_data_source.dart';
import '../../data/local/sync_local_data_source.dart';
import '../../data/models/hijri_content_model.dart';
import '../../data/models/main_item_model.dart';
import '../../data/models/reading_model.dart';
import '../../data/models/reading_segment_model.dart';
import '../../data/models/reminder_model.dart';
import '../../data/models/section_model.dart';
import '../../data/models/sync_state_model.dart';
import '../../data/remote/manifest_remote_data_source.dart';
import 'content_sync_service.dart';

class ContentSyncServiceImpl implements ContentSyncService {
  ContentSyncServiceImpl({
    required SyncLocalDataSource syncLocalDataSource,
    required ContentLocalDataSource contentLocalDataSource,
    required ManifestRemoteDataSource manifestRemoteDataSource,
  })  : _syncLocalDataSource = syncLocalDataSource,
        _contentLocalDataSource = contentLocalDataSource,
        _manifestRemoteDataSource = manifestRemoteDataSource;

  final SyncLocalDataSource _syncLocalDataSource;
  final ContentLocalDataSource _contentLocalDataSource;
  final ManifestRemoteDataSource _manifestRemoteDataSource;

  @override
  Future<SyncStateModel> getSyncState() => _syncLocalDataSource.getSyncState();

  @override
  Future<SyncResult> syncIfNeeded() async {
    final localState = await _syncLocalDataSource.getSyncState();
    try {
      final remoteManifest = await _manifestRemoteDataSource.fetchManifest();
      if (remoteManifest == null) {
        return SyncResult(
          updated: false,
          localVersion: localState.contentVersion,
          remoteVersion: null,
        );
      }

      if (!remoteManifest.isNewerThan(localState.contentVersion)) {
        return SyncResult(
          updated: false,
          localVersion: localState.contentVersion,
          remoteVersion: remoteManifest.contentVersion,
        );
      }

      final files = remoteManifest.files.map((file) => file.name).toSet();

      if (files.contains('sections.json')) {
        final payload = await _manifestRemoteDataSource.fetchJsonFile('sections.json');
        final list = (payload['items'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(SectionModel.fromJson)
            .toList(growable: false);
        await _contentLocalDataSource.upsertSections(list);
      }

      if (files.contains('main_items.json')) {
        final payload = await _manifestRemoteDataSource.fetchJsonFile('main_items.json');
        final list = (payload['items'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(MainItemModel.fromJson)
            .toList(growable: false);
        await _contentLocalDataSource.upsertMainItems(list);
      }

      if (files.contains('readings.json')) {
        final payload = await _manifestRemoteDataSource.fetchJsonFile('readings.json');
        final list = (payload['items'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(ReadingModel.fromJson)
            .toList(growable: false);
        await _contentLocalDataSource.upsertReadings(list);
      }

      if (files.contains('reading_segments.json')) {
        final payload = await _manifestRemoteDataSource.fetchJsonFile('reading_segments.json');
        final list = (payload['items'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(ReadingSegmentModel.fromJson)
            .toList(growable: false);
        await _contentLocalDataSource.upsertReadingSegments(list);
      }

      if (files.contains('reminders.json')) {
        final payload = await _manifestRemoteDataSource.fetchJsonFile('reminders.json');
        final list = (payload['items'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(ReminderModel.fromJson)
            .toList(growable: false);
        await _contentLocalDataSource.upsertReminders(list);
      }

      if (files.contains('hijri_content.json')) {
        final payload = await _manifestRemoteDataSource.fetchJsonFile('hijri_content.json');
        final list = (payload['items'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(HijriContentModel.fromJson)
            .toList(growable: false);
        await _contentLocalDataSource.upsertHijriContent(list);
      }

      final nextState = localState.copyWith(
        contentVersion: remoteManifest.contentVersion,
        lastSyncAt: DateTime.now().toUtc(),
      );
      await _syncLocalDataSource.saveSyncState(nextState);

      return SyncResult(
        updated: true,
        localVersion: localState.contentVersion,
        remoteVersion: remoteManifest.contentVersion,
      );
    } catch (error) {
      await _syncLocalDataSource.saveSyncState(
        localState.copyWith(
          lastError: error.toString(),
          lastSyncAt: DateTime.now().toUtc(),
        ),
      );
      return SyncResult(
        updated: false,
        localVersion: localState.contentVersion,
        remoteVersion: null,
        error: error.toString(),
      );
    }
  }
}
