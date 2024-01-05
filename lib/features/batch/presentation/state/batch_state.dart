import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';

class BatchState {
  final bool isLoading;
  final List<BatchEntity> batches;
  final bool showMessage;

  BatchState({
    required this.isLoading,
    required this.batches,
    required this.showMessage,
  });

  factory BatchState.initialState() => BatchState(
        isLoading: false,
        batches: [],
        showMessage: false,
      );

  BatchState copyWith({
    bool? isLoading,
    List<BatchEntity>? batches,
    bool? showMessage,
  }) {
    return BatchState(
      isLoading: isLoading ?? this.isLoading,
      batches: batches ?? this.batches,
      showMessage: showMessage ?? this.showMessage,
    );
  }
}