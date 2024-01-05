

import 'package:json_annotation/json_annotation.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';

@JsonSerializable()  //* server bata json ma aaucha so to map
class BatchAPIModel {
  @JsonKey(name: '_id')
  // Server ko name lai batchId sanga map gareko
  final String? batchId;
  // J name server ma cha tei name ya lekhne
  final String batchName;

  BatchAPIModel({this.batchId, required this.batchName});

  // To Json and fromJson without freezed
  factory BatchAPIModel.fromJson(Map<String, dynamic> json) {
    return BatchAPIModel(
      batchId: json['_id'],
      batchName: json['batchName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batchName': batchName,
    };
  }

  // From entity to model
  factory BatchAPIModel.fromEntity(BatchEntity entity) {
    return BatchAPIModel(
      batchName: entity.batchName,
    );
  }

  // From model to entity
  static BatchEntity toEntity(BatchAPIModel model) {
    return BatchEntity(
      batchId: model.batchId,
      batchName: model.batchName,
    );
  }
}