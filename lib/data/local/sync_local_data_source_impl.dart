import '../../core/storage/local_database.dart';
import '../models/sync_state_model.dart';
import 'sync_local_data_source.dart';

class SyncLocalDataSourceImpl implements SyncLocalDataSource {
  SyncLocalDataSourceImpl(this._db);

  final LocalDatabase _db;

  static const _syncBox = 'system_sync_state';
  static const _stateKey = 'global';

  @override
  Future<SyncStateModel> getSyncState() async {
    final record = await _db.get(_syncBox, _stateKey);
    if (record == null) {
      return const SyncStateModel(contentVersion: '0.0.0');
    }
    return SyncStateModel.fromJson(record);
  }

  @override
  Future<void> saveSyncState(SyncStateModel state) async {
    await _db.put(_syncBox, _stateKey, state.toJson());
  }
}
