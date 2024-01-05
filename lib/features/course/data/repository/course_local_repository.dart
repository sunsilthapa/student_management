import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/course/data/data_source/course_local_data_source.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/domain/repository/course_repository.dart';

final courseLocalRepositoryProvider = Provider.autoDispose<ICourseRepository>(
  (ref) => CourseLocalRepositoryImpl(
    courseLocalDataSource: ref.read(courseLocalDatasourceProvider),
  ),
);


class CourseLocalRepositoryImpl implements ICourseRepository {
  final CourseLocalDataSource courseLocalDataSource;

  CourseLocalRepositoryImpl({required this.courseLocalDataSource});

  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    return courseLocalDataSource.addCourse(course);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    return courseLocalDataSource.getAllCourses();
  }

  @override
  Future<Either<Failure, bool>> deleteCourse(String id) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }
}
