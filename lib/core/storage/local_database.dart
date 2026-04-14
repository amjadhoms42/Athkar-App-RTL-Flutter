abstract class LocalDatabase {
  Future<void> init();
  Future<void> put(String box, String key, Map<String, dynamic> value);
  Future<Map<String, dynamic>?> get(String box, String key);
  Future<List<Map<String, dynamic>>> getAll(String box);
  Future<void> delete(String box, String key);
  Future<void> clearBox(String box);
}
