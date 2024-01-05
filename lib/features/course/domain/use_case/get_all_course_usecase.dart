import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/domain/repository/course_repository.dart';

final getAllCourseUsecaseProvider = Provider.autoDispose<GetAllCourseUsecase>(
  (ref) => GetAllCourseUsecase(repository: ref.read(courseRepositoryProvider)),
);


class GetAllCourseUsecase{
  final ICourseRepository repository;

  GetAllCourseUsecase({required this.repository});

  Future<Either<Failure, List<CourseEntity>>> getAllCourse() async{
    return await repository.getAllCourses();
    //shared preferences ko code or some other logic
  }
}