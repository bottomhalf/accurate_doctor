class UserDetail {
  String _FullName;
  String _userName;
  String _firstName;
  String _lastName;
  int _appointmentId;
  String _address;
  DateTime _DateOfBirth;
  String _Gender;
  String _Email;
  String _MobileNo;
  String _Password;
  String _customerId;
  int _statusCode;
  bool isDoctor = true;
  int _age;
  String _pincode = "";
  int _city = -1;
  int _state = -1;
  String _country = "";
  int _userId;

  int get UserId => _userId;

  set UserId(int value) {
    _userId = value;
  }

  String get Pincode => _pincode;

  set Pincode(String value) {
    _pincode = value;
  }

  int get City => _city;

  set City(int value) {
    _city = value;
  }

  int get State => _state;

  set State(int value) {
    _state = value;
  }

  String get Country => _country;

  set Country(String value) {
    _country = value;
  }

  static UserDetail userDetail;
  static get instance {
    if (userDetail == null) {
      userDetail = UserDetail._internal();
    }
    return userDetail;
  }

  static set destroy(value) {
    userDetail = null;
  }

  UserDetail._internal();

  String get FullName => _FullName;

  set FullName(String value) {
    _FullName = value;
  }

  int get statusCode => _statusCode;

  set Age(int value) {
    _age = value;
  }

  int get age => _age;

  set statusCode(int value) {
    _statusCode = value;
  }

  String get userName => _userName;

  String get customerId => _customerId;

  set customerId(String value) {
    _customerId = value;
  }

  String get Password => _Password;

  set Password(String value) {
    _Password = value;
  }

  String get MobileNo => _MobileNo;

  set MobileNo(String value) {
    _MobileNo = value;
  }

  String get Email => _Email;

  set Email(String value) {
    _Email = value;
  }

  String get Gender => _Gender;

  set Gender(String value) {
    _Gender = value;
  }

  DateTime get DateOfBirth => _DateOfBirth;

  set DateOfBirth(DateTime value) {
    _DateOfBirth = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  int get appointmentId => _appointmentId;

  set appointmentId(int value) {
    _appointmentId = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  set userName(String value) {
    _userName = value;
  }

  factory UserDetail.fromJson(Map<String, dynamic> parsedData) {
    userDetail.userName = parsedData['strusername'];
    userDetail.firstName = parsedData['strname'];
    userDetail.customerId = parsedData['strcustid'];
    userDetail.appointmentId = parsedData['intappointmentid'];
    userDetail.address = parsedData['strAddress'];
    userDetail.lastName = parsedData['strLastName'];
    userDetail.MobileNo = parsedData['strMobileNumber'];
    userDetail.statusCode = int.tryParse(parsedData['statusCode']);
    userDetail.Email = parsedData['strusername'];
    userDetail.UserId = parsedData['intchcustomerid'];
    return userDetail;
  }
}
