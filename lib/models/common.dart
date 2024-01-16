class Common {
  String? success;
  String? message;
  String? error;
  Common({this.success, this.error, this.message});

  Common.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? json['Success'];
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}
