import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/domain/repository/course_repository.dart';


final addCourseUsecaseProvider = Provider.autoDispose<AddCourseUsecase>(
  (ref) => AddCourseUsecase(repository: ref.read(courseRepositoryProvider)),
);

class AddCourseUsecase {
  final ICourseRepository repository;

  AddCourseUsecase({required this.repository});

  Future<Either<Failure, bool>> addCourse(CourseEntity course) async {
    return await repository.addCourse(course);
    //shared preferences ko code or some other logic
  }
}
