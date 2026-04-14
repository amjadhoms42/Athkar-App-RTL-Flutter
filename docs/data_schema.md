# data_schema.md

اسم المشروع الداخلي: `athkar_content_sync_core`

## 1) ملخص تحليل ملف الإكسل الحالي
تم تحليل الملف `تطبيق_الاذكار_معدل.xlsx` واستخراج الأوراق الفعلية التالية:

1. `القوائم_المساعدة`
2. `دليل_الاستخدام`
3. `الاقسام`
4. `العناصر_الرئيسية`
5. `المقروءات_الرئيسية`
6. `مقاطع_المقروءات`
7. `التذكيرات`
8. `إعدادات_الصلاة`
9. `الفوائت`
10. `المحتوى_الهجري`
11. `الودجت`
12. `مكتبتي_الخاصة`

> ملاحظة: الورقة `دليل_الاستخدام` و`الودجت` مرجعيتان/تشغيليتان ويمكن تجاهلهما في أول نسخة من seed unless needed.

---

## 2) تصنيف البيانات: Content vs User

### A) Content Data (قادمة من Excel وقابلة للتحديث عن بُعد)
- `sections`
- `main_items`
- `readings`
- `reading_segments`
- `reminders` (قوالب/افتراضيات)
- `prayer_settings_defaults`
- `hijri_content`
- `helper_lists`

### B) User Data (لا تُمسح عند تحديث المحتوى)
- `user_reading_progress`
- `user_azkar_progress`
- `user_private_library`
- `user_qada_progress`
- `user_settings`
- `theme_preferences`
- `sync_state`

---

## 3) Administrative Columns Policy (موحّدة)
أي كيان محتوى رئيسي يجب أن يدعم حقولًا إدارية موحّدة:

- `id` (stable)
- `updated_at` (ISO-8601)
- `is_active` (bool)
- `sort_order` (int)
- `source_type` (excel|remote|seed)
- `revision` (int)
- `is_deleted` (bool soft delete)

هذه الحقول تُطبّق على الأقل على:
- `main_items`
- `readings`
- `reading_segments`
- `hijri_content`
- `benefits` (من `main_items` حسب النوع)
- الجزء القابل للمزامنة من `my_library` إن وجد مستقبلاً

---

## 4) Mapping مفصل من أوراق Excel إلى جداول/نماذج التطبيق

## 4.1 الاقسام -> `sections`
**Excel columns**: `section_id`, `الاسم`, `slug`, `القسم_الأعلى`, `المستوى`, `الترتيب`, `ظاهر_في_الشريط`, `نوع_الشاشة`, `ملاحظات`, `حالة`

**Target schema**:
- `id` <- `section_id`
- `name_ar` <- `الاسم`
- `slug` <- `slug`
- `parent_id` <- `القسم_الأعلى` (nullable)
- `level` <- `المستوى`
- `sort_order` <- `الترتيب`
- `show_in_nav` <- (`ظاهر_في_الشريط` == نعم)
- `screen_type` <- `نوع_الشاشة`
- `notes` <- `ملاحظات`
- `is_active` <- (`حالة` == مفعل)
- `updated_at`, `source_type`, `revision`, `is_deleted`

## 4.2 العناصر_الرئيسية -> `main_items`
**Excel columns**: `item_id`, `العنوان`, `النص`, `نوع_العنصر`, `القسم_الرئيسي`, `القسم_الفرعي`, `حالة_المادة`, `طريقة_التفاعل`, `العدد_الافتراضي`, `يسمح_بعدد_مخصص`, `الدليل`, `المصدر`, `الفائدة`, `ملاحظات_عرض`, `صلة_بعد_الصلاة`, `يظهر_في_ذكر_الله`, `يظهر_في_الرئيسية`, `ترتيب`, `حالة`, `رابط`

**Target schema**:
- `id` <- `item_id`
- `title` <- `العنوان`
- `body` <- `النص`
- `item_type` <- `نوع_العنصر`
- `main_section` <- `القسم_الرئيسي`
- `sub_section` <- `القسم_الفرعي`
- `content_state` <- `حالة_المادة`
- `interaction_type` <- `طريقة_التفاعل`
- `default_count` <- int(`العدد_الافتراضي`, default=1)
- `allow_custom_count` <- (`يسمح_بعدد_مخصص` == نعم)
- `evidence` <- `الدليل`
- `source` <- `المصدر`
- `benefit` <- `الفائدة`
- `display_notes` <- `ملاحظات_عرض`
- `after_prayer_link` <- (`صلة_بعد_الصلاة` == نعم)
- `show_in_dhikr_allah` <- (`يظهر_في_ذكر_الله` == نعم)
- `show_in_home` <- (`يظهر_في_الرئيسية` == نعم)
- `sort_order` <- `ترتيب`
- `external_link` <- `رابط`
- `is_active`, `updated_at`, `source_type`, `revision`, `is_deleted`

## 4.3 المقروءات_الرئيسية -> `readings`
**Excel columns**: `reading_id`, `العنوان`, `نوع_المقروء`, `القسم`, `الوصف_المختصر`, `المصدر`, `الفائدة`, `الوقت_المقترح`, `تذكير_مفعل`, `صلة_بعد_الصلاة`, `ترتيب`, `حالة`, `عدد_المقاطع`, `مدة_تقديرية_بالدقائق`, `رابط`, `ملاحظات`

**Target schema**:
- `id` <- `reading_id`
- `title` <- `العنوان`
- `reading_type` <- `نوع_المقروء`
- `section` <- `القسم`
- `short_description` <- `الوصف_المختصر`
- `source` <- `المصدر`
- `benefit` <- `الفائدة`
- `suggested_time` <- `الوقت_المقترح`
- `reminder_enabled_default` <- (`تذكير_مفعل` == نعم)
- `after_prayer_link` <- (`صلة_بعد_الصلاة` == نعم)
- `segment_count` <- int(`عدد_المقاطع`, nullable)
- `estimated_minutes` <- int(`مدة_تقديرية_بالدقائق`, nullable)
- `external_link` <- `رابط`
- `notes` <- `ملاحظات`
- `sort_order`, `is_active`, `updated_at`, `source_type`, `revision`, `is_deleted`

## 4.4 مقاطع_المقروءات -> `reading_segments`
**Excel columns**: `segment_id`, `reading_id`, `رقم_المقطع`, `العنوان_الفرعي`, `النص`, `شرح_مختصر`, `فائدة`, `قابل_للمشاركة`, `له_إنجاز_مستقل`, `ترتيب`, `حالة`, `رابط`, `ملاحظات`, `آخر_تعديل`

**Target schema**:
- `id` <- `segment_id`
- `reading_id` <- `reading_id`
- `segment_number` <- int(`رقم_المقطع`)
- `subtitle` <- `العنوان_الفرعي`
- `body` <- `النص`
- `short_explanation` <- `شرح_مختصر`
- `benefit` <- `فائدة`
- `shareable` <- (`قابل_للمشاركة` == نعم)
- `track_completion_separately` <- (`له_إنجاز_مستقل` == نعم)
- `sort_order` <- `ترتيب`
- `external_link` <- `رابط`
- `notes` <- `ملاحظات`
- `updated_at` <- `آخر_تعديل` أو وقت التوليد
- `is_active`, `source_type`, `revision`, `is_deleted`

## 4.5 التذكيرات -> `reminders`
**Excel columns**: `reminder_id`, `نوع_المرجع`, `reference_id`, `العنوان`, `نوع_التذكير`, `وقت_التذكير`, `أيام_التفعيل`, `مرتبط_بالأذان`, `مرتبط_بما_بعد_الصلاة`, `نوع_الصلاة`, `يكرر_حتى_الإنجاز`, `أولوية`, `رسالة_الإشعار`, `حالة`, `ودجت_مرتبط`, `ترتيب`, `ملاحظات`

**Target schema**:
- `id`, `reference_type`, `reference_id`, `title`
- `reminder_type`, `time_of_day`, `active_days`
- `linked_to_adhan`, `linked_to_post_prayer`, `prayer_type`
- `repeat_until_done`, `priority`, `notification_message`
- `linked_widget`, `notes`
- `sort_order`, `is_active`, `updated_at`, `source_type`, `revision`, `is_deleted`

## 4.6 إعدادات_الصلاة -> `prayer_settings_defaults`
**Excel columns**: `setting_id`, `المجموعة`, `المفتاح`, `القيمة`, `وصف`, `مثال`, `مرتبط_بالمستخدم`, `قابل_للتعديل`, `نوع_الحقل`, `ترتيب`, `حالة`, `ملاحظات`, `رابط`, `مصدر`

**Target schema**:
- `id`, `group`, `key`, `value`
- `description`, `example`
- `is_user_related`, `is_editable`, `field_type`
- `sort_order`, `is_active`, `notes`, `external_link`, `source`
- `updated_at`, `source_type`, `revision`, `is_deleted`

## 4.7 الفوائت -> split
- **Template content** من Excel: `qada_seed_templates`.
- **Runtime user state**: `user_qada_progress`.

هذا الفصل ضروري لضمان safe merge وعدم فقدان تقدم المستخدم.

## 4.8 المحتوى_الهجري -> `hijri_content`
**Excel columns**: `hijri_id`, `الشهر_الهجري`, `اليوم_الهجري`, `نوع_المدخل`, `العنوان`, `ماذا_حدث`, `الفائدة`, `ما_يستحب`, `مرجع_أو_روابط`, `يظهر_في_الرئيسية`, `يظهر_في_الودجت`, `أولوية`, `ترتيب`, `حالة`, `ملاحظات`

**Target schema**:
- `id`, `hijri_month`, `hijri_day`, `entry_type`, `title`
- `event_description`, `benefit`, `recommended_actions`
- `references`
- `show_in_home`, `show_in_widget`
- `priority`, `sort_order`, `notes`
- `is_active`, `updated_at`, `source_type`, `revision`, `is_deleted`

## 4.9 مكتبتي_الخاصة -> split
- `my_library_seed` (اختياري كبداية)
- `user_private_library` (المصدر الفعلي أثناء الاستخدام)

---

## 5) مفاتيح الربط الأساسية
- `sections.id` <- مرجعية عامة للأقسام.
- `main_items.main_section/sub_section` تحتاج قاموس تطبيع وربط بـ `sections.slug` أو `sections.id`.
- `reading_segments.reading_id` -> `readings.id`.
- `reminders.reference_id` قد يشير إلى `main_items.id` أو `readings.id` أو `user_qada_progress.id`.

---

## 6) قواعد التحويل والتطبيع
- تحويل نعم/لا، مفعل/غير مفعل إلى bools.
- Trim لكل النصوص وإزالة المسافات الزائدة.
- أي رقم فارغ -> `null` أو default حسب الحقل.
- أي `id` مفقود في صف محتوى => الصف يُرفض ويُسجّل في تقرير أخطاء.
- أي FK مكسور (مثل segment بدون reading) => الصف يُعزل (quarantine) ولا يوقف كامل التوليد.

---

## 7) اقتراح JSON Seeds الأساسية
- `sections.json`
- `main_items.json`
- `readings.json`
- `reading_segments.json`
- `reminders.json`
- `prayer_settings_defaults.json`
- `qada_seed.json`
- `hijri_content.json`
- `my_library_seed.json`
- `helper_lists.json`
- `manifest.json`

