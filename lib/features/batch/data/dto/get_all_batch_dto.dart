import 'package:json_annotation/json_annotation.dart';
import 'package:student_management_hive_api/features/batch/data/model/batch_api_model.dart';

part 'get_all_batch_dto.g.dart';

//dart run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class GetAllBatchDTO {
  final bool success;
  final int count;
  final List<BatchAPIModel> data;

  GetAllBatchDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  factory GetAllBatchDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllBatchDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllBatchDTOToJson(this);
}