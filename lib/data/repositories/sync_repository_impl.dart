import '../local/sync_local_data_source.dart';
import '../models/manifest_model.dart';
import '../models/sync_state_model.dart';
import '../remote/manifest_remote_data_source.dart';
import 'sync_repository.dart';

class SyncRepositoryImpl implements SyncRepository {
  SyncRepositoryImpl({
    required SyncLocalDataSource syncLocalDataSource,
    required ManifestRemoteDataSource manifestRemoteDataSource,
  })  : _syncLocalDataSource = syncLocalDataSource,
        _manifestRemoteDataSource = manifestRemoteDataSource;

  final SyncLocalDataSource _syncLocalDataSource;
  final ManifestRemoteDataSource _manifestRemoteDataSource;

  @override
  Future<ManifestModel?> fetchRemoteManifest() {
    return _manifestRemoteDataSource.fetchManifest();
  }

  @override
  Future<Map<String, dynamic>> fetchRemoteJsonFile(String fileName) {
    return _manifestRemoteDataSource.fetchJsonFile(fileName);
  }

  @override
  Future<SyncStateModel> getLocalSyncState() {
    return _syncLocalDataSource.getSyncState();
  }

  @override
  Future<void> saveSyncState(SyncStateModel state) {
    return _syncLocalDataSource.saveSyncState(state);
  }
}
