import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';

import '../provider/localDb.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

class PersonalDetailModal {
  static const UserDetailTable = 'userdetail';

  int _intUserId;
  int _intAppointmentId;
  String _strFirstName;
  String _strLastName;
  String _strGender;
  String _strDOB;
  String _stringDOB;
  int _intAge;
  String _strMobileNo;
  String _strEmail;
  String _strMCINo;
  int _intConsultationFee;
  String _strExperience;
  String _strQualification;
  bool _bitEmailPreference;
  bool _bitchpanel;
  int _intSpecialityId;
  String _strSpecialityName;
  int _intLanguageId;
  String _strLanguages;
  int _intAccountActivationId;
  String _strSourceOne;
  String _strIpAddress;
  String _strLocations;
  int _intMpanel;
  String _strImagePath;
  String _Image;
  int _intCreatedBy;
  String _strCreatedOn;
  int _intModifiedBy;
  String _strModifiedOn;
  String _strUserName;
  String _strPassword;
  int _intRoleId;
  String _strRoleName;
  String _strMembership;
  String _strRecognition;
  String _strExpertise;
  bool _bitStatus;
  String _strReason;
  String _strTitle;
  String _strMiddleName;
  int _intLocationId;
  String _strAddress;
  String _strZipCode;
  int _intCityId;
  String _strPhoneNo;
  int _intMaritalStatus;
  int _intIdProofTypeId;
  String _strIdProofPath;
  int _intEmploymentTypeId;
  int _intEducation;
  String _strFullAddress;
  bool _boolNewImage;
  bool _boolNewDoc;
  String _strMRNumber;
  String _strNewPassword;
  String _strProfileImgPath;
  String _strLastLoggedIn;
  String _strMessage;
  String _strGlobalAssociateId;
  String _strURL;
  String _Status;
  String _associate_type;
  String _HealthyGx_Unique_ID;
  String _code;
  String _Globalid;
  String _intRelation;
  String _strName;
  String _strphone;
  String _strSubject;
  String _mailto;
  String _strmessage;
  String _strLocationName;
  String _strCityName;
  String _strStateName;
  String _strCountryName;
  String _strDocumentNumber;
  String _strDocumentPath;
  String _strDocumentType;
  String _ResponseFile;
  int _intStateId;
  int _intAddrId;
  bool _isDoctor;
  String _strOrganization;

  String get strOrganization => _strOrganization;

  set strOrganization(String value) {
    _strOrganization = value;
  }

  bool get isDoctor => _isDoctor;

  set isDoctor(bool value) {
    _isDoctor = value;
  }

  int get intUserId => _intUserId;

  set intUserId(int value) {
    _intUserId = value;
  }

  int get intAddrId => _intAddrId;

  set intAddrId(int value) {
    _intAddrId = value;
  }

  int get intStateId => _intStateId;

  set intStateId(int value) {
    _intStateId = value;
  }

  @override
  String toString() {
    return 'PersonalDetail{_intUserId: $_intUserId, _intAppointmentId: $_intAppointmentId, _strFirstName: $_strFirstName, _strLastName: $_strLastName, _strGender: $_strGender, _strDOB: $_strDOB, _stringDOB: $_stringDOB, _intAge: $_intAge, _strMobileNo: $_strMobileNo, _strEmail: $_strEmail, _strMCINo: $_strMCINo, _intConsultationFee: $_intConsultationFee, _strExperience: $_strExperience, _strQualification: $_strQualification, _bitEmailPreference: $_bitEmailPreference, _bitchpanel: $_bitchpanel, _intSpecialityId: $_intSpecialityId, _strSpecialityName: $_strSpecialityName, _intLanguageId: $_intLanguageId, _strLanguages: $_strLanguages, _intAccountActivationId: $_intAccountActivationId, _strSourceOne: $_strSourceOne, _strIpAddress: $_strIpAddress, _strLocations: $_strLocations, _intMpanel: $_intMpanel, _strImagePath: $_strImagePath, _Image: $_Image, _intCreatedBy: $_intCreatedBy, _strCreatedOn: $_strCreatedOn, _intModifiedBy: $_intModifiedBy, _strModifiedOn: $_strModifiedOn, _strUserName: $_strUserName, _strPassword: $_strPassword, _intRoleId: $_intRoleId, _strRoleName: $_strRoleName, _strMembership: $_strMembership, _strRecognition: $_strRecognition, _strExpertise: $_strExpertise, _bitStatus: $_bitStatus, _strReason: $_strReason, _strTitle: $_strTitle, _strMiddleName: $_strMiddleName, _intLocationId: $_intLocationId, _strAddress: $_strAddress, _strZipCode: $_strZipCode, _intCityId: $_intCityId, _strPhoneNo: $_strPhoneNo, _intMaritalStatus: $_intMaritalStatus, _intIdProofTypeId: $_intIdProofTypeId, _strIdProofPath: $_strIdProofPath, _intEmploymentTypeId: $_intEmploymentTypeId, _intEducation: $_intEducation, _strFullAddress: $_strFullAddress, _boolNewImage: $_boolNewImage, _boolNewDoc: $_boolNewDoc, _strMRNumber: $_strMRNumber, _strNewPassword: $_strNewPassword, _strProfileImgPath: $_strProfileImgPath, _strLastLoggedIn: $_strLastLoggedIn, _strMessage: $_strMessage, _strGlobalAssociateId: $_strGlobalAssociateId, _strURL: $_strURL, _Status: $_Status, _associate_type: $_associate_type, _HealthyGx_Unique_ID: $_HealthyGx_Unique_ID, _code: $_code, _Globalid: $_Globalid, _intRelation: $_intRelation, _strName: $_strName, _strphone: $_strphone, _strSubject: $_strSubject, _mailto: $_mailto, _strmessage: $_strmessage, _strLocationName: $_strLocationName, _strCityName: $_strCityName, _strStateName: $_strStateName, _strCountryName: $_strCountryName, _strDocumentNumber: $_strDocumentNumber, _strDocumentPath: $_strDocumentPath, _strDocumentType: $_strDocumentType, _ResponseFile: $_ResponseFile}';
  }

  PersonalDetailModal();

  static void splitAddress(String addr, PersonalDetailModal personalDetail) {
    if (addr != null) {
      List<String> addresses = addr.split("\$");
      List<String> splittedAddress;
      if (addresses.length > 1)
        splittedAddress = addresses[0].split("\^");
      else
        splittedAddress = addr.split("\^");

      int index = 0;
      while (index < splittedAddress.length) {
        if (index == 0)
          personalDetail.intAddrId =
              int.parse(splittedAddress.elementAt(index));
        else if (index == 1)
          personalDetail.strAddress = splittedAddress.elementAt(index);
        else if (index == 5) {
          try {
            personalDetail.intCityId =
                int.tryParse(splittedAddress.elementAt(index));
          } catch (e) {
            personalDetail.intCityId = -1;
          }
        } else if (index == 7) {
          try {
            personalDetail.intStateId =
                int.tryParse(splittedAddress.elementAt(index));
          } catch (e) {
            personalDetail.intStateId = -1;
          }
        } else if (index == 8)
          personalDetail.strCountryName = splittedAddress.elementAt(index);
        else if (index == 10)
          personalDetail.strZipCode = splittedAddress.elementAt(index);
        index++;
      }
    }
  }

  static Future<bool> userExists() async {
    bool flag = false;
    LocalDb local = LocalDb.internal();
    Database db = local.db;
    bool status = await local.isTableExists(UserDetailTable);
    if (status) {
      var data = await db.rawQuery("select * from ${UserDetailTable}");
      if (data.length > 0) {
        dynamic userResult = data[0];
        UserDetail userDetail = UserDetail.instance;
        userDetail.UserId = userResult['UserId'];
        userDetail.firstName = userResult['strFirstName'];
        userDetail.lastName = userResult['strLastName'];
        userDetail.Gender = userResult['strGender'];
        userDetail.DateOfBirth =
            userResult['strDOB'] != null ? DateTime.now() : null;
        userDetail.MobileNo = userResult['strMobileNo'];
        userDetail.Email = userResult['strEmail'];
        userDetail.exerience = userResult['strExperience'];
        userDetail.imagePath = userResult['strImagePath'];
        userDetail.userName = userResult['strUserName'];
        userDetail.roleId = userResult['intRoleId'];
        userDetail.title = userResult['strTitle'];
        userDetail.middleName = userResult['strMiddleName'];
        userDetail.address = userResult['strAddress'];
        userDetail.Pincode = userResult['strZipCode'];
        userDetail.uniqueId = userResult['HealthyGx_Unique_ID'];
        userDetail.isDoctor = userResult['isDoctor'] == 1 ? true : false;
        Configuration.isDoctor = userDetail.isDoctor;
        userDetail.customerId = userDetail.uniqueId;
        userDetail.customerId = userDetail.uniqueId;
        //userDetail.strOrganization = userResult['strOrganization'];
        //print('Data: ${userDetail.toString()}');
        flag = true;
      }
    }
    return flag;
  }

  Future<bool> insertValue(String insertData, int userId) async {
    LocalDb local = LocalDb.internal();
    Database db = local.db;
    bool state = await local.isTableExists(UserDetailTable);
    if (state) {
      var data = await db
          .rawQuery("select * from ${UserDetailTable} where UserId = $userId");
      if (data.length > 0) {
        var status = await db
            .rawDelete("delete from ${UserDetailTable} where UserId = $userId");
        print('Record delete state: $status');
      }

      int insertState =
          await db.rawInsert('''Insert into ${UserDetailTable} $insertData ''');
      if (insertState > 0) {
        print('Status: $insertState');
        return true;
      } else {
        return false;
      }
    } else {
      print('Creating...');
      local.onCreate(db, 1);
      int insertState =
          await db.rawInsert('''Insert into ${UserDetailTable} $insertData ''');
      if (insertState > 0) {
        print('Status: $insertState');
        return true;
      } else {
        return false;
      }
    }
  }

  factory PersonalDetailModal.fromJson(Map<String, dynamic> data) {
    PersonalDetailModal personalDetail = PersonalDetailModal();
    personalDetail.intUserId = data['intUserId'];
    personalDetail.intAppointmentId = data['intAppointmentId'];
    personalDetail.strFirstName =
        Configuration.replaceToNotNull(data['strFirstName']);
    personalDetail.strLastName =
        Configuration.getStringValue(data['strLastName']);
    personalDetail.strGender = data['strGender'];
    personalDetail.strDOB = data['strDOB'];
    personalDetail.stringDOB = data['stringDOB'];
    personalDetail.intAge = data['intAge'];
    personalDetail.strMobileNo = data['strMobileNo'];
    personalDetail.strEmail = Configuration.replaceToNotNull(data['strEmail']);
    personalDetail.strMCINo = data['strMCINo'];
    personalDetail.intConsultationFee = data['intConsultationFee'];
    personalDetail.strExperience = data['strExperience'];
    personalDetail.strQualification = data['strQualification'];
    personalDetail.bitEmailPreference = data['bitEmailPreference'];
    personalDetail.bitchpanel = data['bitchpanel'];
    personalDetail.intSpecialityId = data['intSpecialityId'];
    personalDetail.strSpecialityName = data['strSpecialityName'];
    personalDetail.intLanguageId = data['intLanguageId'];
    personalDetail.strLanguages = data['strLanguages'];
    personalDetail.intAccountActivationId = data['intAccountActivationId'];
    personalDetail.strSourceOne = data['strSourceOne'];
    personalDetail.strIpAddress = data['strIpAddress'];
    personalDetail.strLocations = data['strLocations'];
    personalDetail.intMpanel = data['intMpanel'];
    personalDetail.strImagePath = data['strImagePath'];
    personalDetail.Image = data['Image'];
    personalDetail.intCreatedBy = data['intCreatedBy'];
    personalDetail.strCreatedOn = data['strCreatedOn'];
    personalDetail.intModifiedBy = data['intModifiedBy'];
    personalDetail.strModifiedOn = data['strModifiedOn'];
    personalDetail.strUserName = data['strUserName'];
    personalDetail.strPassword = data['strPassword'];
    personalDetail.intRoleId = data['intRoleId'];
    personalDetail.strRoleName = data['strRoleName'];
    personalDetail.strMembership = data['strMembership'];
    personalDetail.strRecognition = data['strRecognition'];
    personalDetail.strExpertise = data['strExpertise'];
    personalDetail.bitStatus = data['bitStatus'];
    personalDetail.strReason = data['strReason'];
    personalDetail.strTitle = data['strTitle'];
    personalDetail.strMiddleName = data['strMiddleName'];
    personalDetail.intLocationId = data['intLocationId'];
    personalDetail.strAddress = data['strAddress'];
    personalDetail.strZipCode = data['strZipCode'];
    personalDetail.intCityId = data['intCityId'];
    personalDetail.strPhoneNo = data['strPhoneNo'];
    personalDetail.intMaritalStatus = data['intMaritalStatus'];
    personalDetail.intIdProofTypeId = data['intIdProofTypeId'];
    personalDetail.strIdProofPath = data['strIdProofPath'];
    personalDetail.intEmploymentTypeId = data['intEmploymentTypeId'];
    personalDetail.intEducation = data['intEducation'];
    personalDetail.strFullAddress = data['strFullAddress'];
    personalDetail.boolNewImage = data['boolNewImage'];
    personalDetail.boolNewDoc = data['boolNewDoc'];
    personalDetail.strMRNumber = data['strMRNumber'];
    personalDetail.strNewPassword = data['strNewPassword'];
    personalDetail.strProfileImgPath = data['strProfileImgPath'];
    personalDetail.strLastLoggedIn = data['strLastLoggedIn'];
    personalDetail.strMessage = data['strMessage'];
    personalDetail.strGlobalAssociateId = data['strGlobalAssociateId'];
    personalDetail.strURL = data['strURL'];
    personalDetail.Status = data['Status'];
    personalDetail.associate_type = data['associate_type'];
    personalDetail.HealthyGx_Unique_ID = data['HealthyGx_Unique_ID'];
    personalDetail.code = data['code'];
    personalDetail.Globalid = data['Globalid'];
    personalDetail.intRelation = data['intRelation'];
    personalDetail.strName = data['strName'];
    personalDetail.strphone = data['strphone'];
    personalDetail.strSubject = data['strSubject'];
    personalDetail.mailto = data['mailto'];
    personalDetail.strmessage = data['strmessage'];
    personalDetail.strLocationName = data['strLocationName'];
    personalDetail.strCityName = data['strCityName'];
    personalDetail.strStateName = data['strStateName'];
    personalDetail.strCountryName = data['strCountryName'];
    personalDetail.strDocumentNumber = data['strDocumentNumber'];
    personalDetail.strDocumentPath = data['strDocumentPath'];
    personalDetail.strDocumentType = data['strDocumentType'];
    personalDetail.ResponseFile = data['ResponseFile'];
    personalDetail.strOrganization = data['strOrganization'];
    splitAddress(data['strFullAddress'], personalDetail);
    return personalDetail;
  }

  int get intAppointmentId => _intAppointmentId;

  String get ResponseFile => _ResponseFile;

  set ResponseFile(String value) {
    _ResponseFile = value;
  }

  String get strDocumentType => _strDocumentType;

  set strDocumentType(String value) {
    _strDocumentType = value;
  }

  String get strDocumentPath => _strDocumentPath;

  set strDocumentPath(String value) {
    _strDocumentPath = value;
  }

  String get strDocumentNumber => _strDocumentNumber;

  set strDocumentNumber(String value) {
    _strDocumentNumber = value;
  }

  String get strCountryName => _strCountryName;

  set strCountryName(String value) {
    _strCountryName = value;
  }

  String get strStateName => _strStateName;

  set strStateName(String value) {
    _strStateName = value;
  }

  String get strCityName => _strCityName;

  set strCityName(String value) {
    _strCityName = value;
  }

  String get strLocationName => _strLocationName;

  set strLocationName(String value) {
    _strLocationName = value;
  }

  String get strmessage => _strmessage;

  set strmessage(String value) {
    _strmessage = value;
  }

  String get mailto => _mailto;

  set mailto(String value) {
    _mailto = value;
  }

  String get strSubject => _strSubject;

  set strSubject(String value) {
    _strSubject = value;
  }

  String get strphone => _strphone;

  set strphone(String value) {
    _strphone = value;
  }

  String get strName => _strName;

  set strName(String value) {
    _strName = value;
  }

  String get intRelation => _intRelation;

  set intRelation(String value) {
    _intRelation = value;
  }

  String get Globalid => _Globalid;

  set Globalid(String value) {
    _Globalid = value;
  }

  String get code => _code;

  set code(String value) {
    _code = value;
  }

  String get HealthyGx_Unique_ID => _HealthyGx_Unique_ID;

  set HealthyGx_Unique_ID(String value) {
    _HealthyGx_Unique_ID = value;
  }

  String get associate_type => _associate_type;

  set associate_type(String value) {
    _associate_type = value;
  }

  String get Status => _Status;

  set Status(String value) {
    _Status = value;
  }

  String get strURL => _strURL;

  set strURL(String value) {
    _strURL = value;
  }

  String get strGlobalAssociateId => _strGlobalAssociateId;

  set strGlobalAssociateId(String value) {
    _strGlobalAssociateId = value;
  }

  String get strMessage => _strMessage;

  set strMessage(String value) {
    _strMessage = value;
  }

  String get strLastLoggedIn => _strLastLoggedIn;

  set strLastLoggedIn(String value) {
    _strLastLoggedIn = value;
  }

  String get strProfileImgPath => _strProfileImgPath;

  set strProfileImgPath(String value) {
    _strProfileImgPath = value;
  }

  String get strNewPassword => _strNewPassword;

  set strNewPassword(String value) {
    _strNewPassword = value;
  }

  String get strMRNumber => _strMRNumber;

  set strMRNumber(String value) {
    _strMRNumber = value;
  }

  bool get boolNewDoc => _boolNewDoc;

  set boolNewDoc(bool value) {
    _boolNewDoc = value;
  }

  bool get boolNewImage => _boolNewImage;

  set boolNewImage(bool value) {
    _boolNewImage = value;
  }

  String get strFullAddress => _strFullAddress;

  set strFullAddress(String value) {
    _strFullAddress = value;
  }

  int get intEducation => _intEducation;

  set intEducation(int value) {
    _intEducation = value;
  }

  int get intEmploymentTypeId => _intEmploymentTypeId;

  set intEmploymentTypeId(int value) {
    _intEmploymentTypeId = value;
  }

  String get strIdProofPath => _strIdProofPath;

  set strIdProofPath(String value) {
    _strIdProofPath = value;
  }

  int get intIdProofTypeId => _intIdProofTypeId;

  set intIdProofTypeId(int value) {
    _intIdProofTypeId = value;
  }

  int get intMaritalStatus => _intMaritalStatus;

  set intMaritalStatus(int value) {
    _intMaritalStatus = value;
  }

  String get strPhoneNo => _strPhoneNo;

  set strPhoneNo(String value) {
    _strPhoneNo = value;
  }

  int get intCityId => _intCityId;

  set intCityId(int value) {
    _intCityId = value;
  }

  String get strZipCode => _strZipCode;

  set strZipCode(String value) {
    _strZipCode = value;
  }

  String get strAddress => _strAddress;

  set strAddress(String value) {
    _strAddress = value;
  }

  int get intLocationId => _intLocationId;

  set intLocationId(int value) {
    _intLocationId = value;
  }

  String get strMiddleName => _strMiddleName;

  set strMiddleName(String value) {
    _strMiddleName = value;
  }

  String get strTitle => _strTitle;

  set strTitle(String value) {
    _strTitle = value;
  }

  String get strReason => _strReason;

  set strReason(String value) {
    _strReason = value;
  }

  bool get bitStatus => _bitStatus;

  set bitStatus(bool value) {
    _bitStatus = value;
  }

  String get strExpertise => _strExpertise;

  set strExpertise(String value) {
    _strExpertise = value;
  }

  String get strRecognition => _strRecognition;

  set strRecognition(String value) {
    _strRecognition = value;
  }

  String get strMembership => _strMembership;

  set strMembership(String value) {
    _strMembership = value;
  }

  String get strRoleName => _strRoleName;

  set strRoleName(String value) {
    _strRoleName = value;
  }

  int get intRoleId => _intRoleId;

  set intRoleId(int value) {
    _intRoleId = value;
  }

  String get strPassword => _strPassword;

  set strPassword(String value) {
    _strPassword = value;
  }

  String get strUserName => _strUserName;

  set strUserName(String value) {
    _strUserName = value;
  }

  String get strModifiedOn => _strModifiedOn;

  set strModifiedOn(String value) {
    _strModifiedOn = value;
  }

  int get intModifiedBy => _intModifiedBy;

  set intModifiedBy(int value) {
    _intModifiedBy = value;
  }

  String get strCreatedOn => _strCreatedOn;

  set strCreatedOn(String value) {
    _strCreatedOn = value;
  }

  int get intCreatedBy => _intCreatedBy;

  set intCreatedBy(int value) {
    _intCreatedBy = value;
  }

  String get Image => _Image;

  set Image(String value) {
    _Image = value;
  }

  String get strImagePath => _strImagePath;

  set strImagePath(String value) {
    _strImagePath = value;
  }

  int get intMpanel => _intMpanel;

  set intMpanel(int value) {
    _intMpanel = value;
  }

  String get strLocations => _strLocations;

  set strLocations(String value) {
    _strLocations = value;
  }

  String get strIpAddress => _strIpAddress;

  set strIpAddress(String value) {
    _strIpAddress = value;
  }

  String get strSourceOne => _strSourceOne;

  set strSourceOne(String value) {
    _strSourceOne = value;
  }

  int get intAccountActivationId => _intAccountActivationId;

  set intAccountActivationId(int value) {
    _intAccountActivationId = value;
  }

  String get strLanguages => _strLanguages;

  set strLanguages(String value) {
    _strLanguages = value;
  }

  int get intLanguageId => _intLanguageId;

  set intLanguageId(int value) {
    _intLanguageId = value;
  }

  String get strSpecialityName => _strSpecialityName;

  set strSpecialityName(String value) {
    _strSpecialityName = value;
  }

  int get intSpecialityId => _intSpecialityId;

  set intSpecialityId(int value) {
    _intSpecialityId = value;
  }

  bool get bitchpanel => _bitchpanel;

  set bitchpanel(bool value) {
    _bitchpanel = value;
  }

  bool get bitEmailPreference => _bitEmailPreference;

  set bitEmailPreference(bool value) {
    _bitEmailPreference = value;
  }

  String get strQualification => _strQualification;

  set strQualification(String value) {
    _strQualification = value;
  }

  String get strExperience => _strExperience;

  set strExperience(String value) {
    _strExperience = value;
  }

  int get intConsultationFee => _intConsultationFee;

  set intConsultationFee(int value) {
    _intConsultationFee = value;
  }

  String get strMCINo => _strMCINo;

  set strMCINo(String value) {
    _strMCINo = value;
  }

  String get strEmail => _strEmail;

  set strEmail(String value) {
    _strEmail = value;
  }

  String get strMobileNo => _strMobileNo;

  set strMobileNo(String value) {
    _strMobileNo = value;
  }

  int get intAge => _intAge;

  set intAge(int value) {
    _intAge = value;
  }

  String get stringDOB => _stringDOB;

  set stringDOB(String value) {
    _stringDOB = value;
  }

  String get strDOB => _strDOB;

  set strDOB(String value) {
    _strDOB = value;
  }

  String get strGender => _strGender;

  set strGender(String value) {
    _strGender = value;
  }

  String get strLastName => _strLastName;

  set strLastName(String value) {
    _strLastName = value;
  }

  String get strFirstName => _strFirstName;

  set strFirstName(String value) {
    _strFirstName = value;
  }

  set intAppointmentId(int value) {
    _intAppointmentId = value;
  }
}
