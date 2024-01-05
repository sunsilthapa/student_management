import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/domain/use_case/add_course_usecase.dart';
import 'package:student_management_hive_api/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:student_management_hive_api/features/course/presentation/state/course_state.dart';


// View model ma kaile pani build context use na garne

final courseViewModelProvider =
    StateNotifierProvider.autoDispose<CourseViewModel, CourseState>(
  (ref) => CourseViewModel(
    addCourseUsecase: ref.read(addCourseUsecaseProvider),
    getAllCourseUsecase: ref.read(getAllCourseUsecaseProvider),
  ),
);

class CourseViewModel extends StateNotifier<CourseState> {
  final AddCourseUsecase addCourseUsecase;
  final GetAllCourseUsecase getAllCourseUsecase;

  CourseViewModel({
    required this.addCourseUsecase,
    required this.getAllCourseUsecase,
  }) : super(CourseState.initialState()) {
    getAllCourse();
  }

  void addCourse(CourseEntity course) {
    state = state.copyWith(isLoading: true);

    addCourseUsecase.addCourse(course).then((value) {
      value.fold(
        (failure) => state = state.copyWith(isLoading: false),
        (success) {
          state = state.copyWith(isLoading: false, showMessage: true);
          getAllCourse();
        },
      );
    });
  }

  void getAllCourse() {
    state = state.copyWith(isLoading: true);
    getAllCourseUsecase.getAllCourse().then((value) {
      value.fold(
        (failure) => state = state.copyWith(isLoading: false),
        (courses) {
          state = state.copyWith(isLoading: false, coursees: courses);
        },
      );
    });
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
