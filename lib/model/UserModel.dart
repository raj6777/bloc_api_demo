import 'dart:convert';
import 'package:objectbox/objectbox.dart';

// Convert from/to JSON
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@Entity() // Mark as an entity for ObjectBox
class UserModel {
  @Id() // ObjectBox requires an ID field, defaulting to 0 for auto-increment
  int obxId;

  int page;
  int perPage;
  int total;
  int totalPages;

  // The relation with Datum
  @Backlink('userModel') // Backlink to manage reverse relationship
  final data = ToMany<Datum>();

  // The relation with Support
  final support = ToOne<Support>();

  UserModel({
    this.obxId = 0,
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
      )
        ..data.addAll(
            (json["data"] as List).map((x) => Datum.fromJson(x)).toList())
        ..support.target = Support.fromJson(json["support"]);

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": data.map((x) => x.toJson()).toList(),
        "support": support.target?.toJson(),
      };
}

@Entity() // Mark as an entity for ObjectBox
class Datum {
  @Id()
  int obxId;

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  // Backlink to the UserModel (for object relationships)
  final userModel = ToOne<UserModel>();

  Datum({
    this.obxId = 0,
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

@Entity() // Mark as an entity for ObjectBox
class Support {
  @Id()
  int obxId;

  String url;
  String text;

  // Backlink to the UserModel (for object relationships)
  final userModel = ToOne<UserModel>();

  Support({
    this.obxId = 0,
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}
