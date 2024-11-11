class APIResponse {
  final bool success;
  final dynamic data;
  final String? message;
APIResponse({required this.success, this.data, this.message});
  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      success: json['success'] ?? false,
      data: json['data'],
      message: json['message'],
    );
  }
  factory APIResponse.withError(String error) {
    return APIResponse(success: false, message: error);
  }
}