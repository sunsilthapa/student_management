import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management_hive_api/config/constants/hive_table_constant.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:uuid/uuid.dart';

part 'course_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.courseTableId)
class CourseHiveModel {
  @HiveField(0)
  final String courseId;

  @HiveField(1)
  final String courseName;

  // empty constructor
  CourseHiveModel.empty() : this(courseId: '', courseName: '');

  CourseHiveModel({
    String? courseId,
    required this.courseName,
  }) : courseId = courseId ?? const Uuid().v4();

  // Convert Entity to Hive Object
  factory CourseHiveModel.toHiveModel(CourseEntity entity) => CourseHiveModel(
        courseName: entity.courseName,
      );

  // Convert Hive Object to Entity
  static CourseEntity toEntity(CourseHiveModel hiveModel) => CourseEntity(
        courseId: hiveModel.courseId,
        courseName: hiveModel.courseName,
      );

  @override
  String toString() {
    return 'batchId: $courseId, batchName: $courseName';
  }
}

// dart run build_runner build --delete-conflicting-outputs