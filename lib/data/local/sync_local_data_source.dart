import '../models/sync_state_model.dart';

abstract class SyncLocalDataSource {
  Future<SyncStateModel> getSyncState();
  Future<void> saveSyncState(SyncStateModel state);
}
