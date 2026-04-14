import '../models/manifest_model.dart';

abstract class ManifestRemoteDataSource {
  Future<ManifestModel?> fetchManifest();
  Future<Map<String, dynamic>> fetchJsonFile(String fileName);
}
