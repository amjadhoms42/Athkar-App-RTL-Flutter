import '../models/manifest_model.dart';
import '../models/sync_state_model.dart';

abstract class SyncRepository {
  Future<SyncStateModel> getLocalSyncState();
  Future<ManifestModel?> fetchRemoteManifest();
  Future<Map<String, dynamic>> fetchRemoteJsonFile(String fileName);
  Future<void> saveSyncState(SyncStateModel state);
}
