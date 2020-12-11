var providerDetailRaw = {
  "intUserId": 0,
  "intAssociateId": 0,
  "strFirstName": "",
  "strLastName": null,
  "strGender": null,
  "strDOB": "0001-01-01T00:00:00",
  "stringDOB": null,
  "intAge": 0,
  "strMobileNo": null,
  "strEmail": "",
  "strorgimage": null,
  "strMCINo": null,
  "intConsultationFee": 0,
  "strExperience": null,
  "strQualification": null,
  "bitEmailPreference": false,
  "bitchpanel": false,
  "intSpecialityId": 0,
  "strSpecialityName": "",
  "intLanguageId": 0,
  "strLanguages": null,
  "intAccountActivationId": 0,
  "strSourceOne": null,
  "strIpAddress": null,
  "strLocations": null,
  "intMpanel": 0,
  "strImagePath": "",
  "Image": null,
  "intCreatedBy": 0,
  "strCreatedOn": "0001-01-01T00:00:00",
  "intModifiedBy": 0,
  "strModifiedOn": "0001-01-01T00:00:00",
  "strUserName": "",
  "strPassword": "",
  "intRoleId": 0,
  "intCategoryId": 0,
  "strRoleName": null,
  "strMembership": null,
  "strRecognition": null,
  "strExpertise": null,
  "bitStatus": false,
  "strReason": null,
  "strTitle": null,
  "strMiddleName": null,
  "intLocationId": 0,
  "strAddress": null,
  "strZipCode": null,
  "intCityId": 0,
  "strPhoneNo": null,
  "intBloodGroup": 0,
  "intMaritalStatus": 0,
  "intIdProofTypeId": 0,
  "strIdProofPath": null,
  "intEmploymentTypeId": 0,
  "intEducation": 0,
  "strFullAddress": null,
  "boolNewImage": false,
  "boolNewDoc": false,
  "strMRNNO": null,
  "strNewPassword": null,
  "strProfileImgPath": null,
  "strLastLoggedIn": null,
  "strMessage": null,
  "strGlobalAssociateId": null,
  "strURL": null,
  "Status": null,
  "associate_type": "",
  "CH_Unique_ID": null,
  "strGlobalAssId": "0",
  "strAccountName": "",
  "intBusinessCategoryId": 0,
  "intEmailPreference": 0,
  "intIsActive": 0,
  "strsummary": null,
  "intOrgId": null,
  "intOrgCityId": null,
  "intOrgLocationId": null,
  "strBusinessName": null,
  "strAcceredations": null,
  "strOrgAddress": null,
  "strOrgPin": null,
  "strOrgMobileNo": null,
  "strOrgEmail": null,
  "strOrgFax": null,
  "strGlobalOrgId": null,
  "strOrgLatitude": null,
  "strOrgImagePath": null,
  "strOrgLongitude": null,
  "strOrganization": "0",
  "strDIDNo": null,
  "strExtension": null,
  "bitGlobalRegistration": false,
  "intGlobalRegistration": 0,
  "strUserAddress": null,
  "intParentId": 0,
  "bitVideoConsultation": false,
  "strVideoConsultationFee": null,
  "bitFacetoFaceConsultation": false,
  "strTimeStamp": null
};

class ProviderDetail {
  int _intUserId;
  int _intAssociateId;
  String _strFirstName;
  String _strLastName;
  String _strGender;
  String _strDOB;
  String _stringDOB;
  int _intAge;
  String _strMobileNo;
  String _strEmail;
  String _strorgimage;
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
  int _intCategoryId;
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
  int _intBloodGroup;
  int _intMaritalStatus;
  int _intIdProofTypeId;
  String _strIdProofPath;
  int _intEmploymentTypeId;
  int _intEducation;
  String _strFullAddress;
  bool _boolNewImage;
  bool _boolNewDoc;
  String _strMRNNO;
  String _strNewPassword;
  String _strProfileImgPath;
  String _strLastLoggedIn;
  String _strMessage;
  String _strGlobalAssociateId;
  String _strURL;
  String _Status;
  String _associate_type;
  String _CH_Unique_ID;
  String _strGlobalAssId;
  String _strAccountName;
  int _intBusinessCategoryId;
  int _intEmailPreference;
  int _intIsActive;
  String _strsummary;
  int _intOrgId;
  int _intOrgCityId;
  int _intOrgLocationId;
  String _strBusinessName;
  String _strAcceredations;
  String _strOrgAddress;
  String _strOrgPin;
  String _strOrgMobileNo;
  String _strOrgEmail;
  String _strOrgFax;
  String _strGlobalOrgId;
  String _strOrgLatitude;
  String _strOrgImagePath;
  String _strOrgLongitude;
  String _strOrganization;
  String _strDIDNo;
  String _strExtension;
  bool _bitGlobalRegistration;
  int _intGlobalRegistration;
  String _strUserAddress;
  int _intParentId;
  bool _bitVideoConsultation;
  String _strVideoConsultationFee;
  bool _bitFacetoFaceConsultation;
  String _strTimeStamp;

  ProviderDetail();

  factory ProviderDetail.fromJson(Map<String, dynamic> providerData) {
    ProviderDetail providerDetail = ProviderDetail();
    for (var elem in providerDetailRaw.keys) {
      providerDetail[elem] = "";
    }
    return providerDetail;
  }
}
