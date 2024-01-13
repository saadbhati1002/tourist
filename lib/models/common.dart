class Common {
  String? success;
  String? error;
  Common({this.success, this.error});

  Common.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? json['Success'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    return data;
  }
}
