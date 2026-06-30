import 'package:sabalpara_family/sabalpara_family.dart';

class ApiResponseModel<T> {
  final int? status;
  final dynamic message;
  final T? data;

  ApiResponseModel({this.status, this.message, this.data});

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json, {
    T? Function(dynamic rawData)? dataParser,
  }) {
    final rawData = json["data"];
    T? parsedData;

    try {
      parsedData = dataParser != null
          ? dataParser(rawData)
          : (rawData is T ? rawData : null);
    } catch (e, stackTrace) {
      debugPrint('━━━━━━━━━━ API PARSE ERROR ━━━━━━━━━━');
      debugPrint('Model Type: $T');
      debugPrint('Status: ${json["status"]}');
      debugPrint('Message: ${json["message"]}');
      debugPrint('Raw data type: ${rawData.runtimeType}');
      debugPrint('Error: $e');
      debugPrint('Stack: $stackTrace');
      CrashlyticsService.recordError(
        CrashArea.businessLogic,
        e,
        stackTrace,
        info: {
          'model_type': T.toString(),
          'status': '${json["status"]}',
        },
      );
      rethrow;
    }

    final rawStatus = json["status"];
    final parsedStatus = rawStatus is int
        ? rawStatus
        : int.tryParse(rawStatus?.toString() ?? '');

    return ApiResponseModel<T>(
      status: parsedStatus,
      message: json["message"],
      data: parsedData,
    );
  }

  bool get isSuccess => status == 100;

  String get messageText {
    if (message is String && (message as String).isNotEmpty) {
      return message as String;
    }

    if (message is Map) {
      final errors = <String>[];
      (message as Map).forEach((_, value) {
        if (value is List && value.isNotEmpty) {
          errors.add(value.first.toString());
        } else if (value != null) {
          errors.add(value.toString());
        }
      });
      if (errors.isNotEmpty) {
        return errors.join('\n');
      }
    }

    if (message is List && (message as List).isNotEmpty) {
      return (message as List).first.toString();
    }

    return 'Something went wrong';
  }
}
