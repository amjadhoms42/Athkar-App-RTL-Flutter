import 'package:athkar_content_sync_core/athkar_content_sync_core.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeManifestRemoteDataSource implements ManifestRemoteDataSource {
  FakeManifestRemoteDataSource({required this.manifest, required this.files});

  final ManifestModel? manifest;
  final Map<String, Map<String, dynamic>> files;

  @override
  Future<ManifestModel?> fetchManifest() async => manifest;

  @override
  Future<Map<String, dynamic>> fetchJsonFile(String fileName) async {
    final payload = files[fileName];
    if (payload == null) {
      throw StateError('file not found: $fileName');
    }
    return payload;
  }
}

void main() {
  group('ManifestModel version compare', () {
    test('detects newer semantic-like version', () {
      const manifest = ManifestModel(
        contentVersion: '2026.04.14.2',
        generatedAt: DateTime.utc(2026, 4, 14),
        files: <ManifestFileModel>[],
      );
      expect(manifest.isNewerThan('2026.04.14.1'), true);
      expect(manifest.isNewerThan('2026.04.14.2'), false);
      expect(manifest.isNewerThan('2026.04.15.1'), false);
    });
  });

  test('sync updates content and keeps state version', () async {
    final db = InMemoryLocalDatabase();
    await db.init();

    final contentLocal = ContentLocalDataSourceImpl(db);
    final syncLocal = SyncLocalDataSourceImpl(db);

    final manifest = ManifestModel(
      contentVersion: '1.0.1',
      generatedAt: DateTime.utc(2026, 4, 14),
      files: const <ManifestFileModel>[
        ManifestFileModel(
          name: 'sections.json',
          checksum: 'sha256:abc',
          size: 10,
          required: true,
        ),
      ],
    );

    final remote = FakeManifestRemoteDataSource(
      manifest: manifest,
      files: <String, Map<String, dynamic>>{
        'sections.json': <String, dynamic>{
          'items': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': 'SEC-1',
              'updated_at': '2026-04-14T00:00:00Z',
              'is_active': true,
              'sort_order': 1,
              'source_type': 'remote',
              'revision': 1,
              'is_deleted': false,
              'name_ar': 'الرئيسية',
              'slug': 'home',
              'level': 'main',
              'show_in_nav': true,
              'screen_type': 'dashboard',
            },
          ],
        },
      },
    );

    final service = ContentSyncServiceImpl(
      syncLocalDataSource: syncLocal,
      contentLocalDataSource: contentLocal,
      manifestRemoteDataSource: remote,
    );

    final result = await service.syncIfNeeded();
    expect(result.updated, true);

    final sections = await contentLocal.getSections();
    expect(sections.length, 1);
    expect(sections.first.slug, 'home');

    final state = await syncLocal.getSyncState();
    expect(state.contentVersion, '1.0.1');
  });
}
