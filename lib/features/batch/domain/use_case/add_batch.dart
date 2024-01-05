import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_hive_api/features/batch/domain/repository/batch_repository.dart';

final addBatchUsecaseProvider = Provider.autoDispose<AddBatchUsecase>(
  (ref) => AddBatchUsecase(repository: ref.read(batchRepositoryProvider)),
);

class AddBatchUsecase {
  final IBatchRepository repository;

  AddBatchUsecase({required this.repository});

  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    return await repository.addBatch(batch);
    // shared preferrences ko code or some other logic
  }
}