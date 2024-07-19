class UserModel {
  List<UserData>? results;

  UserModel({required this.results});

  UserModel.fromJson(dynamic json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((user) => results?.add(UserData.fromJson(user)));
    }
  }
}

class UserData {
  UserData({this.name, this.email, this.picture});

  Name? name;
  Picture? picture;
  String? email;

  factory UserData.fromJson(dynamic json) {
    final email = json['email'] as String? ?? '';
    final name = json['name'] != null ? Name.fromJson(json['name']) : null;
    final picture =
        json['picture'] != null ? Picture.fromJson(json['picture']) : null;
    return UserData(email: email, name: name, picture: picture);
  }
}

class Name {
  Name({this.title, this.first, this.last});

  String? title;
  String? first;
  String? last;

  factory Name.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as String? ?? '';
    final first = json['first'] as String? ?? '';
    final last = json['last'] as String? ?? '';

    return Name(title: title, first: first, last: last);
  }
}

class Picture {
  String? thumbnail;
  Picture({this.thumbnail});
  factory Picture.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'] as String? ?? '';
    return Picture(thumbnail: thumbnail);
  }
}
