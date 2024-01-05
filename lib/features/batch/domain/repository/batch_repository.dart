import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/common/provider/is_network_provider.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/auth/domain/entity/auth_entity.dart';
import 'package:student_management_hive_api/features/batch/data/repository/batch_local_repo_impl.dart';
import 'package:student_management_hive_api/features/batch/data/repository/batch_remote_repo_impl.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';

final batchRepositoryProvider = Provider.autoDispose<IBatchRepository>((ref) {
  //* internet chain bhane local data tana
  if(ref.watch(connectivityStatusProvider)== ConnectivityStatus.isConnected){
    return  ref.read(batchRemoteRepositoryProvider);
  }else{
  return ref.read(batchLocalRepositoryProvider);
  }
});

abstract class IBatchRepository {
  Future<Either<Failure, List<BatchEntity>>> getAllBatches();
  Future<Either<Failure, bool>> addBatch(BatchEntity batch);
  Future<Either<Failure, List<AuthEntity>>> getAllStudentsByBatch(
      String batchId);
}
