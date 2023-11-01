// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    int? id;
    UserClass? user;
    String? phoneNumber;
    String? address;

    User({
        this.id,
        this.user,
        this.phoneNumber,
        this.address,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
        phoneNumber: json["phoneNumber"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "phoneNumber": phoneNumber,
        "address": address,
    };
}

class UserClass {
    int? id;
    dynamic lastLogin;
    bool? isSuperuser;
    String? username;
    String? firstName;
    String? lastName;
    String? email;
    bool? isStaff;
    bool? isActive;
    DateTime? dateJoined;
    List<dynamic>? groups;
    List<dynamic>? userPermissions;

    UserClass({
        this.id,
        this.lastLogin,
        this.isSuperuser,
        this.username,
        this.firstName,
        this.lastName,
        this.email,
        this.isStaff,
        this.isActive,
        this.dateJoined,
        this.groups,
        this.userPermissions,
    });

    factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        lastLogin: json["last_login"],
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: json["date_joined"] == null ? null : DateTime.parse(json["date_joined"]),
        groups: json["groups"] == null ? [] : List<dynamic>.from(json["groups"]!.map((x) => x)),
        userPermissions: json["user_permissions"] == null ? [] : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "last_login": lastLogin,
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined?.toIso8601String(),
        "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null ? [] : List<dynamic>.from(userPermissions!.map((x) => x)),
    };
}
