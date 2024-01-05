import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/core/network/hive_service.dart';
import 'package:student_management_hive_api/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';


final batchLocalDataSourceProvider = Provider.autoDispose<BatchLocalDataSource>((ref) =>
 BatchLocalDataSource(hiveService: ref.read(hiveServiceProvider)));
class BatchLocalDataSource {
  final HiveService hiveService;

  BatchLocalDataSource({
    required this.hiveService,
  });

  // Add Batch
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try {
      // Convert BatchEntity to BatchHiveModel
      BatchHiveModel batchHiveModel = BatchHiveModel.toHiveModel(batch);
      hiveService.addBatch(batchHiveModel);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      List<BatchHiveModel> batches = await hiveService.getAllBatches();
      // Convert Hive Object to Entity
      List<BatchEntity> batchEntities =
          batches.map((e) => BatchHiveModel.toEntity(e)).toList();
      return Right(batchEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}