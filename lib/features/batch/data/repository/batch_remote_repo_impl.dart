import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/auth/domain/entity/auth_entity.dart';
import 'package:student_management_hive_api/features/batch/data/data_source/batch_remote_data_source.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_hive_api/features/batch/domain/repository/batch_repository.dart';

final batchRemoteRepositoryProvider = Provider.autoDispose<IBatchRepository>(
  (ref) => BatchRemoteRepoImpl(
    batchRemoteDatSource: ref.read(batchRemoteDataSourceProvider),
  ),
);

class BatchRemoteRepoImpl implements IBatchRepository {
  final BatchRemoteDatSource batchRemoteDatSource;

  const BatchRemoteRepoImpl({required this.batchRemoteDatSource});

  @override
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) {
    // TODO: implement addBatch
    return batchRemoteDatSource.addBatch(batch);
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() {
    return batchRemoteDatSource.getAllBatches();
  }

  @override
  Future<Either<Failure, List<AuthEntity>>> getAllStudentsByBatch(
      String batchId) {
    // TODO: implement getAllStudentsByBatch
    throw UnimplementedError();
  }
}