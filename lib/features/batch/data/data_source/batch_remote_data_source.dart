import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/config/constants/api_endpoints.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/core/network/http_service.dart';
import 'package:student_management_hive_api/features/batch/data/dto/get_all_batch_dto.dart';
import 'package:student_management_hive_api/features/batch/data/model/batch_api_model.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';

final batchRemoteDataSourceProvider =
    Provider.autoDispose<BatchRemoteDatSource>(
  (ref) => BatchRemoteDatSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class BatchRemoteDatSource {
  final Dio dio;

  BatchRemoteDatSource({required this.dio});

  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllBatch);
      if (response.statusCode == 200) {
       
        GetAllBatchDTO batchAddDTO = GetAllBatchDTO.fromJson(response.data);
        // Convert BatchAPIModel to BatchEntity
        List<BatchEntity> batchList = batchAddDTO.data
            .map((batch) => BatchAPIModel.toEntity(batch))
            .toList();

        return Right(batchList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  //* add batch
   Future<Either<Failure,bool>> addBatch(BatchEntity batch) async{
    try{
      BatchAPIModel batchAPIModel = BatchAPIModel.fromEntity(batch);
      var response=await dio.post(ApiEndpoints.createBatch,
      data:batchAPIModel.toJson());
      if(response.statusCode==201){
        return const Right(true);
 
      }else{
        return Left(
          Failure(error : response.statusMessage.toString(),
          statusCode: response.statusCode.toString(),
          )
        );
      }
    } on DioException catch(e){
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}