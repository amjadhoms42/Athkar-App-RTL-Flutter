# content_architecture.md

اسم المشروع الداخلي: `athkar_content_sync_core`

## 1) الهدف المعماري

- Excel هو **مصدر التحرير**.
- التطبيق لا يعتمد على قراءة xlsx وقت التشغيل.
- التشغيل اليومي من Local DB (offline-first).
- التحديثات تأتي عبر JSON + manifest versioning.
- لا فقدان لبيانات المستخدم عند تحديث المحتوى.

---

## 2) طبقات النظام المقترحة

```text
Excel (authoring)
   -> tools/excel_to_json
      -> assets/seed/*.json + manifest.json
         -> seed importer (first run)
            -> Local DB (content tables)
App runtime -> repositories -> Local DB
Sync service -> remote manifest/files -> validate -> safe merge -> Local DB
```

---

## 3) هيكلة المشروع المستهدفة (قابلة للتنفيذ تدريجيًا)

```text
lib/
  core/
    constants/
    utils/
    services/
    sync/
    storage/
    parser/
  data/
    models/
    repositories/
    local/
    remote/
    seed/
  features/
    home/
    azkar/
    readings/
    salawat/
    hijri/
    benefits/
    my_library/
    prayers/
    qada/
    settings/
  widgets/
  main.dart

tools/
docs/
assets/seed/
```

---

## 4) Data Source Abstraction

### ContentRepository (واجهة موحدة)
المصدر الفعلي للقراءة يكون بالترتيب:
1. Local DB (default)
2. Seed import (first-run only)
3. Remote JSON sync (background/periodic)
4. Future API provider (بدون كسر الطبقات)

### مبدأ الفصل
- `Content Data`: قابلة للاستبدال بالتحديثات.
- `User Data`: تبقى كما هي ولا تتأثر بالمحتوى الجديد.

---

## 5) اختيار قاعدة البيانات المحلية

**الاختيار المقترح: Isar** للأسباب التالية:
- أداء ممتاز على الموبايل مع Dart-first DX.
- يدعم روابط/استعلامات مناسبة لحالات القراءة والتقدم.
- مناسب لتخزين المحتوى + حالات المستخدم مع عمليات upsert سهلة.
- يعمل جيدًا offline-first مع حجم بيانات متوسط.

> بديل مقبول: SQLite/Drift إذا كانت الحاجة لعلاقات SQL معقدة جدًا.

---

## 6) Safe Merge Strategy (ملزم)

عند وصول نسخة محتوى جديدة:
1. تنزيل `manifest.json`.
2. مقارنة `content_version` المحلي والبعيد.
3. تحميل الملفات المطلوبة فقط.
4. التحقق من hash/checksum لكل ملف.
5. تحميل JSON إلى staging in-memory.
6. **تحديث جداول المحتوى فقط** (`sections`, `main_items`, ...).
7. عدم المساس بجداول المستخدم (`user_*`, settings, theme, progress).
8. حفظ `content_version` و`last_sync_at` بعد نجاح كامل العملية.
9. عند أي فشل: rollback وعدم تغيير النسخة الحالية.

---

## 7) First Run Strategy

- عند أول تشغيل:
  - استيراد seed من `assets/seed/*.json` إلى Local DB.
  - ضبط `content_version` الابتدائية من `manifest.json` المحلي.
- بعد ذلك:
  - sync دوري/يدوي عند توفر الإنترنت.
  - التطبيق يبقى قابلاً للاستخدام بالكامل بدون إنترنت.

---

## 8) Manifest Contract (الحد الأدنى)

```json
{
  "content_version": "2026.04.14.1",
  "generated_at": "2026-04-14T12:00:00Z",
  "minimum_supported_app_version": "1.0.0",
  "files": [
    {
      "name": "main_items.json",
      "checksum": "sha256:...",
      "size": 12345,
      "required": true
    }
  ],
  "notes": "seed refresh"
}
```

---

## 9) Error Tolerance

- تعطل ملف JSON واحد لا يجب أن يكسر التطبيق.
- fallback إلى `last-known-good` لكل ملف.
- تسجيل أخطاء sync في جدول `sync_logs` محلي.
- أي فشل جزئي لا يغيّر `content_version`.

---

## 10) خطة تنفيذ المراحل القادمة (بعد هذه المرحلة)

## A) Excel to JSON
1. إنشاء tool Dart في `tools/excel_to_json.dart`.
2. قراءة الأوراق المطلوبة فقط.
3. Validation + normalization + mapping.
4. توليد JSONs + `manifest.json` + `validation_report.json`.

## B) Local DB
1. إعداد Isar models (content + user + sync state).
2. إنشاء DAOs/Local data sources.
3. Seed importer لأول تشغيل.

## C) Sync
1. `ManifestRemoteDataSource` لجلب manifest.
2. `ContentDownloadService` لتنزيل ملفات JSON.
3. `ContentSyncService` للمقارنة والتحقق والتحديث الذري.

## D) Merge
1. تطبيق upsert على جداول المحتوى فقط.
2. soft-delete عبر `is_deleted` بدون حذف جداول المستخدم.
3. حماية user tables بعقود صريحة داخل repository layer.

## E) Testing
1. Unit tests لطبقة mapping/validation.
2. Unit tests لـ version compare + checksum.
3. Integration test: first-run seed import.
4. Integration test: sync success + rollback on failure.
5. Regression checklist يدوي داخل `docs/manual_checklist.md`.

