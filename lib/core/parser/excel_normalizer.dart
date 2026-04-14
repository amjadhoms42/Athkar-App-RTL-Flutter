class ExcelNormalizer {
  const ExcelNormalizer();

  String? normalizeString(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  bool normalizeBool(dynamic value, {bool defaultValue = false}) {
    final text = normalizeString(value)?.toLowerCase();
    if (text == null) return defaultValue;
    if (text == 'نعم' || text == 'true' || text == '1') return true;
    if (text == 'لا' || text == 'false' || text == '0') return false;
    return defaultValue;
  }

  int? normalizeInt(dynamic value) {
    final text = normalizeString(value);
    if (text == null) return null;
    return int.tryParse(text);
  }
}
