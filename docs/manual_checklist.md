# manual_checklist.md

## Checklist - Phase 1 (Excel analysis + documentation)

- [x] التأكد من وجود ملف `تطبيق_الاذكار_معدل.xlsx` في جذر المشروع.
- [x] التأكد من استخراج أسماء الأوراق الفعلية بنجاح.
- [x] مراجعة `docs/data_schema.md` ومطابقة mapping مع الأعمدة.
- [x] مراجعة `docs/missing_data.md` واعتماد الفجوات الحرجة.
- [x] مراجعة `docs/content_architecture.md` واعتماد فصل Content/User data.
- [x] اعتماد خطة المرحلة القادمة (Excel->JSON ثم Local DB ثم Sync).

## Checklist - Phase 2 (Core foundation implemented)
- [x] إنشاء models الأساسية للمحتوى وmanifest وsync state.
- [x] إنشاء local database foundation (واجهة + in-memory adapter).
- [x] إنشاء content repositories الأساسية.
- [x] إنشاء sync service interfaces + implementation أولي.
- [x] إنشاء foundation لأداة `tools/excel_to_json.dart`.
- [ ] ربط parser فعلي لقراءة xlsx بدل unsupported adapter.

## Checklist - Next phase preview
- [ ] تنفيذ Excel parser adapter فعلي وتوليد `assets/seed/*.json` من الملف مباشرة.
- [ ] إضافة validation report مفصل `validation_report.json`.
- [ ] إضافة checksum verification داخل sync قبل الدمج.
- [ ] إضافة safe merge policies للوضعيات المتقدمة (soft delete, differential update).
- [ ] إضافة اختبارات تكامل إضافية لسيناريو rollback عند فشل ملف واحد.

