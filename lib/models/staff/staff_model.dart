class StaffRes {
  List<StaffData>? data;

  StaffRes({this.data});

  StaffRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StaffData>[];
      json['data'].forEach((v) {
        data!.add(new StaffData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataStaff = <String, dynamic>{};

    dataStaff['data'] = data!.map((v) => v.toJson()).toList();

    return dataStaff;
  }
}

class StaffData {
  String? id;
  String? staffName;
  String? staffDesignation;
  String? staffImage;

  StaffData({this.id, this.staffName, this.staffDesignation, this.staffImage});

  StaffData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffName = json['staff_name'];
    staffDesignation = json['staff_designation'];
    staffImage = json['staff_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_name'] = this.staffName;
    data['staff_designation'] = this.staffDesignation;
    data['staff_image'] = this.staffImage;
    return data;
  }
}
