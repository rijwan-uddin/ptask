class UserList {
  UserList({
      this.id, 
      this.roleId, 
      this.locale, 
      this.address, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.phone, 
      this.emailVerifiedAt, 
      this.photoPath, 
      this.createdAt, 
      this.updatedAt, 
      this.teamleadId, 
      this.teamlead, 
      this.position, 
      this.reportingId, 
      this.name,});

  UserList.fromJson(dynamic json) {
    id = json['id'];
    roleId = json['role_id'];
    locale = json['locale'];
    address = json['address'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    photoPath = json['photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teamleadId = json['teamlead_id'];
    teamlead = json['teamlead'];
    position = json['position'];
    reportingId = json['reporting_id'];
    name = json['name'];
  }
  num? id;
  num? roleId;
  String? locale;
  dynamic address;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  dynamic emailVerifiedAt;
  String? photoPath;
  String? createdAt;
  String? updatedAt;
  num? teamleadId;
  String? teamlead;
  dynamic position;
  dynamic reportingId;
  String? name;
UserList copyWith({  num? id,
  num? roleId,
  String? locale,
  dynamic address,
  String? firstName,
  String? lastName,
  String? email,
  String? phone,
  dynamic emailVerifiedAt,
  String? photoPath,
  String? createdAt,
  String? updatedAt,
  num? teamleadId,
  String? teamlead,
  dynamic position,
  dynamic reportingId,
  String? name,
}) => UserList(  id: id ?? this.id,
  roleId: roleId ?? this.roleId,
  locale: locale ?? this.locale,
  address: address ?? this.address,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  email: email ?? this.email,
  phone: phone ?? this.phone,
  emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
  photoPath: photoPath ?? this.photoPath,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  teamleadId: teamleadId ?? this.teamleadId,
  teamlead: teamlead ?? this.teamlead,
  position: position ?? this.position,
  reportingId: reportingId ?? this.reportingId,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['role_id'] = roleId;
    map['locale'] = locale;
    map['address'] = address;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['email_verified_at'] = emailVerifiedAt;
    map['photo_path'] = photoPath;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['teamlead_id'] = teamleadId;
    map['teamlead'] = teamlead;
    map['position'] = position;
    map['reporting_id'] = reportingId;
    map['name'] = name;
    return map;
  }

}