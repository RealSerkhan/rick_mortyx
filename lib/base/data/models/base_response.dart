//use JsonSerializable base response with T

class BaseResponse<T> {
  const BaseResponse({required this.success, required this.data});

  final bool success;
  final T data;

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return BaseResponse(success: json['success'] as bool, data: fromJsonT(json['data']));
  }
}
