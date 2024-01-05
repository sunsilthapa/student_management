import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_hive_api/features/batch/domain/repository/batch_repository.dart';

final getAllBatchUsecaseProvider = Provider.autoDispose<GetAllBatchesUsecase>(
  (ref) => GetAllBatchesUsecase(
    repository: ref.read(batchRepositoryProvider),
  ),
);

class GetAllBatchesUsecase {
  final IBatchRepository repository;

  GetAllBatchesUsecase({required this.repository});

  Future<Either<Failure, List<BatchEntity>>> getAllBAtches() async {
    return await repository.getAllBatches();

    //* shared preferences ko code or some other logic
  }
}
