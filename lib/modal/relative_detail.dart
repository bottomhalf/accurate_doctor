class RelativeDetail {
  int _intCustid;
  String _strname;
  String _strgender;
  String _strage;
  String _stremail;
  String _strrelation;
  String _strGCMID;
  String _strdob;
  String _strlname;
  String _strglobalid;
  String _relation;
  String _mobile;
  bool _isUpdate = false;

  RelativeDetail();

  @override
  String toString() {
    return 'RelativeDetail{_intCustid: $_intCustid, _strname: $_strname, _strgender: $_strgender, _strage: $_strage, _stremail: $_stremail, _strrelation: $_strrelation, _strGCMID: $_strGCMID, _strdob: $_strdob, _strlname: $_strlname, _strglobalid: $_strglobalid, _relation: $_relation, _mobile: $_mobile}';
  }

  factory RelativeDetail.fromJson(Map<String, dynamic> data) {
    RelativeDetail relativeDetail = RelativeDetail();
    relativeDetail.intCustid = data['intCustid'];
    relativeDetail.strname = data['strname'];
    relativeDetail.strgender = data['strgender'];
    relativeDetail.strage = data['strage'];
    relativeDetail.stremail = data['stremail'];
    relativeDetail.strrelation = data['strrelation'];
    relativeDetail.strGCMID = data['strGCMID'];
    relativeDetail.strdob = data['strdob'];
    relativeDetail.strlname = data['strlname'];
    relativeDetail.strglobalid = data['strglobalid'];
    relativeDetail.relation = data['relation'];
    relativeDetail.isUpdate = true;
    return relativeDetail;
  }

  bool get isUpdate => _isUpdate;

  set isUpdate(bool value) {
    _isUpdate = value;
  }

  String get mobile => _mobile;

  set mobile(String value) {
    _mobile = value;
  }

  String get relation => _relation;

  set relation(String value) {
    _relation = value;
  }

  String get strglobalid => _strglobalid;

  set strglobalid(String value) {
    _strglobalid = value;
  }

  String get strlname => _strlname;

  set strlname(String value) {
    _strlname = value;
  }

  String get strdob => _strdob;

  set strdob(String value) {
    _strdob = value;
  }

  String get strGCMID => _strGCMID;

  set strGCMID(String value) {
    _strGCMID = value;
  }

  String get strrelation => _strrelation;

  set strrelation(String value) {
    _strrelation = value;
  }

  String get stremail => _stremail;

  set stremail(String value) {
    _stremail = value;
  }

  String get strage => _strage;

  set strage(String value) {
    _strage = value;
  }

  String get strgender => _strgender;

  set strgender(String value) {
    _strgender = value;
  }

  String get strname => _strname;

  set strname(String value) {
    _strname = value;
  }

  int get intCustid => _intCustid;

  set intCustid(int value) {
    _intCustid = value;
  }
}
