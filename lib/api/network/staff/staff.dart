import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/staff/staff_model.dart';

class StaffNetwork {
  static const String staffUrl = "auth-api.php/getStaffList";
  static Future<dynamic> getStaff() async {
    final result = await httpManager.post(
      url: staffUrl,
    );

    StaffRes staffRes = StaffRes.fromJson(result);
    return staffRes;
  }
}
