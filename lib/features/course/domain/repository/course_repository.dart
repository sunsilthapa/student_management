import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/common/provider/is_network_provider.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/course/data/repository/course_local_repository.dart';
import 'package:student_management_hive_api/features/course/data/repository/course_remote_repository.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';

final courseRepositoryProvider = Provider.autoDispose<ICourseRepository>((ref) {
  if (ref.watch(connectivityStatusProvider) == ConnectivityStatus.isConnected) {
    return ref.read(courseRemoteRepositoryProvider);
  } else {
    return ref.read(courseLocalRepositoryProvider);
  }
});

abstract class ICourseRepository {
  Future<Either<Failure, bool>> addCourse(CourseEntity course);
  Future<Either<Failure, List<CourseEntity>>> getAllCourses();
  Future<Either<Failure, bool>> deleteCourse(String id);
}
