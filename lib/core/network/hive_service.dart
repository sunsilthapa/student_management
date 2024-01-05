import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_management_hive_api/config/constants/hive_table_constant.dart';
import 'package:student_management_hive_api/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management_hive_api/features/course/data/model/course_hive_model.dart';


//* create object using a provider
final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());


class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    // Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(BatchHiveModelAdapter());
    Hive.registerAdapter(CourseHiveModelAdapter());
  }

  // ======================== Batch Queries ========================
  Future<void> addBatch(BatchHiveModel batch) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.put(batch.batchId, batch);
  }

  Future<List<BatchHiveModel>> getAllBatches() async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    var batches = box.values.toList();
    return batches;
  }

  Future<void> deleteBatch(String batchId) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.delete(batchId);
  }

  // ======================== Course Queries ========================
  Future<void> addCourse(CourseHiveModel course) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.put(course.courseId, course);
  }

  Future<List<CourseHiveModel>> getAllCourses() async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    var courses = box.values.toList();
    return courses;
  }

  Future<void> deleteCourse(String courseId) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.delete(courseId);
  }

  // ======================== Auth Queries ========================

  // Future<void> addAuth(AuthHiveModel auth) async {
  //   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
  //   await box.put(auth.studentId, auth);
  // }

  // Future<List<AuthHiveModel>> getAllAuth() async {
  //   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
  //   var auths = box.values.toList();
  //   return auths;
  // }

  // Future<void> deleteAuth(String studentId) async {
  //   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
  //   await box.delete(studentId);
  // }

  // Delete hive
  Future<void> deleteHive() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.studentBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.batchBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.courseBox);
  }
}