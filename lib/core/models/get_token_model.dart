class GetTokenModel {
  String? token;
  Profile? profile;

  GetTokenModel({this.token, this.profile});

  GetTokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? createdAt;
  bool? active;
  String? profileType;
  List<String>? phones;

  Profile(
      {this.id,
        this.createdAt,
        this.active,
        this.profileType,
        this.phones});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    active = json['active'];
    profileType = json['profile_type'];
    phones = json['phones'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['active'] = active;
    data['profile_type'] = profileType;
    data['phones'] = phones;
    return data;
  }
}
