import 'package:sabalpara_family/core/utils/enums.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class ResultsModel {
  final int? id;
  final String? resultIdRaw;
  final int? userId;
  final String? name;
  final int? standardId;
  final String? standardName;
  final String? percentage;
  final int? year;
  final File? result;
  final String? resultUrl;
  final String? createdAt;
  final String? updatedAt;

  ResultsModel({
    this.id,
    this.resultIdRaw,
    this.userId,
    this.name,
    this.standardId,
    this.standardName,
    this.percentage,
    this.year,
    this.result,
    this.resultUrl,
    this.createdAt,
    this.updatedAt,
  });

  /// Id used for delete API (`result_id` field).
  String? get deleteResultId {
    if (id != null) {
      return id.toString();
    }
    final raw = resultIdRaw?.trim();
    if (raw != null && raw.isNotEmpty) {
      return raw;
    }
    return null;
  }

  ResultsModel copyWith({
    int? id,
    String? resultIdRaw,
    int? userId,
    String? name,
    int? standardId,
    String? standardName,
    String? percentage,
    int? year,
    File? result,
    String? resultUrl,
    String? createdAt,
    String? updatedAt,
  }) => ResultsModel(
    id: id ?? this.id,
    resultIdRaw: resultIdRaw ?? this.resultIdRaw,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    standardId: standardId ?? this.standardId,
    standardName: standardName ?? this.standardName,
    percentage: percentage ?? this.percentage,
    year: year ?? this.year,
    result: result ?? this.result,
    resultUrl: resultUrl ?? this.resultUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  /// UI compatibility helpers
  String? get standard => standardName ?? standardId?.toString();

  ResultStatus get status => ResultStatus.pending;

  static int? _parseInt(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.toInt();
    }
    final text = value.toString().trim();
    if (text.isEmpty) {
      return null;
    }
    return int.tryParse(text.split('.').first);
  }

  static String? _parseIdRaw(dynamic value) {
    if (value == null) {
      return null;
    }
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  /// Parses API `data` which may be a result map or wrapped in `data` / `result`.
  factory ResultsModel.fromApiData(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      if (raw['data'] is Map<String, dynamic>) {
        return ResultsModel.fromJson(raw['data'] as Map<String, dynamic>);
      }
      if (raw['result'] is Map<String, dynamic>) {
        return ResultsModel.fromJson(raw['result'] as Map<String, dynamic>);
      }
      return ResultsModel.fromJson(raw);
    }
    return ResultsModel();
  }

  factory ResultsModel.fromJson(Map<String, dynamic> json) {
    final idRaw = json['id'] ?? json['result_id'] ?? json['Result_id'];
    final parsedId = _parseInt(idRaw);

    return ResultsModel(
      id: parsedId,
      resultIdRaw: _parseIdRaw(idRaw) ?? parsedId?.toString(),
      userId: _parseInt(json['user_id']),
      name: json['child_name']?.toString() ?? json['name']?.toString(),
      standardId: _parseInt(json['standard_id']),
      standardName: json['standard_name']?.toString(),
      percentage: json['percentage']?.toString(),
      year: _parseInt(json['year']),
      result: json['result'] is File ? json['result'] as File : null,
      resultUrl: json['file']?.toString() ??
          json['result_url']?.toString() ??
          json['result_file']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  bool matchesForDelete(ResultsModel other) {
    final sameName = (name ?? '').trim() == (other.name ?? '').trim();
    final sameYear = year == other.year;
    final samePercentage =
        (percentage ?? '').trim() == (other.percentage ?? '').trim();
    final sameStandard = standardId == other.standardId ||
        (standardName ?? '').trim() == (other.standardName ?? '').trim();
    return sameName && sameYear && samePercentage && sameStandard;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "result_id": resultIdRaw ?? id?.toString(),
    "user_id": userId,
    "child_name": name,
    "standard_id": standardId,
    "standard_name": standardName,
    "percentage": percentage,
    "year": year,
    "result": result,
    "file": resultUrl,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
