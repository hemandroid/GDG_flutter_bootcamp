class Attendees {
  int id;
  String firstName;
  String lastName;
  String password;
  String reEnterPassword;
  String mobileNumber;
  String emailId;
  int gender;
  String city;
  String state;
  String address;

  Attendees(
      {this.id,
      this.firstName,
      this.lastName,
      this.password,
      this.reEnterPassword,
      this.mobileNumber,
      this.emailId,
      this.gender,
      this.city,
      this.state,
      this.address});

  Attendees.map(dynamic obj) {
    this.firstName = obj["firstName"];
    this.lastName = obj["lastName"];
    this.password = obj["password"];
    this.reEnterPassword = obj["reEnterPassword"];
    this.mobileNumber = obj["mobileNumber"];
    this.emailId = obj["emailId"];
    this.gender = obj["gender"];
    this.city = obj["city"];
    this.state = obj["state"];
    this.address = obj["address"];
  }

  String get firstname => firstName;

  String get lastname => lastName;

  String get stateName => state;

  void setUserId(int id) {
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["firstName"] = firstName ?? "";
    map["lastName"] = lastName ?? "";
    map["password"] = password ?? "";
    map["reEnterPassword"] = reEnterPassword ?? "";
    map["mobileNumber"] = mobileNumber ?? "";
    map["emailId"] = emailId ?? "";
    map["gender"] = gender ?? 0;
    map["city"] = city ?? "";
    map["state"] = state ?? "";
    map["address"] = address ?? "";
    return map;
  }

  @override
  String toString() {
    return 'Attendees{'
        'id:$id'
        'firstName:$firstName,'
        'lastName:$lastName,'
        'password:$password,'
        'reEnterPassword:$reEnterPassword,'
        'mobileNumber:$mobileNumber,'
        'emailId:$emailId,'
        'gender:$gender,'
        'city:$city,'
        'state:$state,'
        'address:$address}';
  }
}
