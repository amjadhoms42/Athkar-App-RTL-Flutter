import '../../data/models/sync_state_model.dart';

class SyncResult {
  const SyncResult({
    required this.updated,
    required this.localVersion,
    required this.remoteVersion,
    this.error,
  });

  final bool updated;
  final String localVersion;
  final String? remoteVersion;
  final String? error;
}

abstract class ContentSyncService {
  Future<SyncResult> syncIfNeeded();
  Future<SyncStateModel> getSyncState();
}
