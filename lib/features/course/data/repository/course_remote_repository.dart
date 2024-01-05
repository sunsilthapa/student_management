import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/course/data/data_source/course_remote_data_source.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/domain/repository/course_repository.dart';

final courseRemoteRepositoryProvider = Provider.autoDispose<ICourseRepository>(
  (ref) => CourseRemoteRepository(
    courseRemoteDataSource: ref.read(courseRemoteDataSourceProvider),
  ),
);

class CourseRemoteRepository implements ICourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;

  const CourseRemoteRepository({required this.courseRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    // TODO: implement addCourse
    return courseRemoteDataSource.addCourse(course);
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteCourse(String id) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    // TODO: implement getAllCourses
    return courseRemoteDataSource.getAllCourses();
    throw UnimplementedError();
  }
}
