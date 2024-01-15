class UserRes {
  String? error;
  String? message;
  UserData? success;

  UserRes({success, this.error, this.message});

  UserRes.fromJson(Map<String, dynamic> json) {
    error = json["error"];
    message = json["message"];
    success = json['Success'] != null
        ? UserData.fromJson(json['Success'])
        : UserData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["error"] = error;
    data["message"] = message;
    if (success != null) {
      data['Success'] = success!.toJson();
    } else {
      data['data'] = success!.toJson();
    }
    return data;
  }
}

class UserData {
  String? id;
  String? deviceToken;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? email;
  String? mobile;
  dynamic username;
  String? password;
  String? jobTitle;
  String? yearOfFormation;
  String? location;
  String? website;
  String? country;
  String? averageGuests;
  String? companyName;
  String? logo;
  String? logo2;
  String? logo3;
  String? companyProfile;
  String? personalBio;
  String? additionalPreferences;
  String? venuePreference;
  String? meetingPreference;
  String? meetingPreferenceOther;
  String? status;
  String? venue1City;
  String? venue1Year;
  String? venue1Pax;
  String? venue2City;
  String? venue2Year;
  String? venue2Pax;
  String? venue3City;
  String? venue3Year;
  String? venue3Pax;
  String? venue4City;
  String? venue4Year;
  String? venue4Pax;
  String? venue5City;
  String? venue5Year;
  String? venue5Pax;
  String? createdAt;
  dynamic updatedAt;
  String? noOfLocationsInWedding;
  String? noOfDestinationWedding;
  String? venue1Name;
  String? venue2Name;
  String? venue3Name;
  String? venue4Name;
  String? venue5Name;
  String? venue2Month;
  String? venue1Month;
  String? venue3Month;
  String? venue4Month;
  String? venue5Month;
  String? tnc1Approval;
  String? tnc2Approval;
  String? tnc3Approval;
  bool? isImageFromStorage;
  UserData(
      {id,
      deviceToken,
      firstName,
      middleName,
      lastName,
      gender,
      email,
      mobile,
      username,
      password,
      jobTitle,
      yearOfFormation,
      location,
      website,
      country,
      averageGuests,
      companyName,
      logo,
      logo2,
      logo3,
      companyProfile,
      personalBio,
      additionalPreferences,
      venuePreferance,
      meetingPreference,
      meetingPreferenceOther,
      status,
      venue1City,
      venue1Year,
      venue1Pax,
      venue2City,
      venue2Year,
      venue2Pax,
      venue3City,
      venue3Year,
      venue3Pax,
      venue4City,
      venue4Year,
      venue4Pax,
      venue5City,
      venue5Year,
      venue5Pax,
      createdAt,
      updatedAt,
      noOfLocationsInWedding,
      noOfDestinationWedding,
      venue1Name,
      venue2Name,
      venue3Name,
      venue4Name,
      venue5Name,
      venue2Month,
      venue1Month,
      venue3Month,
      venue4Month,
      venue5Month,
      tnc1Approval,
      tnc2Approval,
      tnc3Approval,
      this.isImageFromStorage});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceToken = json['device_token'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
    username = json['username'];
    password = json['password'];
    jobTitle = json['job_title'];
    yearOfFormation = json['year_of_formation'];
    location = json['location'];
    website = json['website'];
    country = json['country'];
    averageGuests = json['average_guests'];
    companyName = json['Company_Name'];
    logo = json['logo'];
    logo2 = json['logo2'];
    logo3 = json['logo3'];
    companyProfile = json['Company_Profile'];
    personalBio = json['Personal_Bio'];
    additionalPreferences = json['Additional_preferences'];
    venuePreference = json['venue_preferance'];
    meetingPreference = json['meeting_preference'];
    meetingPreferenceOther = json['meeting_preference_other'];
    status = json['status'];
    venue1City = json['venue1_city'];
    venue1Year = json['venue1_year'];
    venue1Pax = json['venue1_pax'];
    venue2City = json['venue2_city'];
    venue2Year = json['venue2_year'];
    venue2Pax = json['venue2_pax'];
    venue3City = json['venue3_city'];
    venue3Year = json['venue3_year'];
    venue3Pax = json['venue3_pax'];
    venue4City = json['venue4_city'];
    venue4Year = json['venue4_year'];
    venue4Pax = json['venue4_pax'];
    venue5City = json['venue5_city'];
    venue5Year = json['venue5_year'];
    venue5Pax = json['venue5_pax'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    noOfLocationsInWedding = json['no_of_locations_in_wedding'];
    noOfDestinationWedding = json['no_of_destination_wedding'];
    venue1Name = json['venue1_name'];
    venue2Name = json['venue2_name'];
    venue3Name = json['venue3_name'];
    venue4Name = json['venue4_name'];
    venue5Name = json['venue5_name'];
    venue2Month = json['venue2_month'];
    venue1Month = json['venue1_month'];
    venue3Month = json['venue3_month'];
    venue4Month = json['venue4_month'];
    venue5Month = json['venue5_month'];
    tnc1Approval = json['tnc1_approval'];
    tnc2Approval = json['tnc2_approval'];
    tnc3Approval = json['tnc3_approval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['device_token'] = deviceToken;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['email'] = email;
    data['mobile'] = mobile;
    data['username'] = username;
    data['password'] = password;
    data['job_title'] = jobTitle;
    data['year_of_formation'] = yearOfFormation;
    data['location'] = location;
    data['website'] = website;
    data['country'] = country;
    data['average_guests'] = averageGuests;
    data['Company_Name'] = companyName;
    data['logo'] = logo;
    data['logo2'] = logo2;
    data['logo3'] = logo3;
    data['Company_Profile'] = companyProfile;
    data['Personal_Bio'] = personalBio;
    data['Additional_preferences'] = additionalPreferences;
    data['venue_preferance'] = venuePreference;
    data['meeting_preference'] = meetingPreference;
    data['meeting_preference_other'] = meetingPreferenceOther;
    data['status'] = status;
    data['venue1_city'] = venue1City;
    data['venue1_year'] = venue1Year;
    data['venue1_pax'] = venue1Pax;
    data['venue2_city'] = venue2City;
    data['venue2_year'] = venue2Year;
    data['venue2_pax'] = venue2Pax;
    data['venue3_city'] = venue3City;
    data['venue3_year'] = venue3Year;
    data['venue3_pax'] = venue3Pax;
    data['venue4_city'] = venue4City;
    data['venue4_year'] = venue4Year;
    data['venue4_pax'] = venue4Pax;
    data['venue5_city'] = venue5City;
    data['venue5_year'] = venue5Year;
    data['venue5_pax'] = venue5Pax;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['no_of_locations_in_wedding'] = noOfLocationsInWedding;
    data['no_of_destination_wedding'] = noOfDestinationWedding;
    data['venue1_name'] = venue1Name;
    data['venue2_name'] = venue2Name;
    data['venue3_name'] = venue3Name;
    data['venue4_name'] = venue4Name;
    data['venue5_name'] = venue5Name;
    data['venue2_month'] = venue2Month;
    data['venue1_month'] = venue1Month;
    data['venue3_month'] = venue3Month;
    data['venue4_month'] = venue4Month;
    data['venue5_month'] = venue5Month;
    data['tnc1_approval'] = tnc1Approval;
    data['tnc2_approval'] = tnc2Approval;
    data['tnc3_approval'] = tnc3Approval;
    return data;
  }
}
