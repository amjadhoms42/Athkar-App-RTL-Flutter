import 'base_content_fields.dart';

class SectionModel {
  const SectionModel({
    required this.base,
    required this.nameAr,
    required this.slug,
    required this.level,
    required this.showInNav,
    required this.screenType,
    this.parentId,
    this.notes,
  });

  final BaseContentFields base;
  final String nameAr;
  final String slug;
  final String? parentId;
  final String level;
  final bool showInNav;
  final String screenType;
  final String? notes;

  Map<String, dynamic> toJson() {
    return {
      ...base.toJson(),
      'name_ar': nameAr,
      'slug': slug,
      'parent_id': parentId,
      'level': level,
      'show_in_nav': showInNav,
      'screen_type': screenType,
      'notes': notes,
    };
  }

  static SectionModel fromJson(Map<String, dynamic> json) {
    return SectionModel(
      base: BaseContentFields.fromJson(json),
      nameAr: json['name_ar'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      parentId: json['parent_id'] as String?,
      level: json['level'] as String? ?? 'main',
      showInNav: json['show_in_nav'] as bool? ?? false,
      screenType: json['screen_type'] as String? ?? 'list',
      notes: json['notes'] as String?,
    );
  }
}
