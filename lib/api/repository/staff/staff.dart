import 'package:tourist/api/network/staff/staff.dart';

class StaffRepository {
  Future<dynamic> getStaffApiCall() async {
    return await StaffNetwork.getStaff();
  }
}
