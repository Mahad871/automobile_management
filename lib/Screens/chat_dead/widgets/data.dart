// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.authentication,
        this.prompt,
        this.userId,
    });

    String? authentication;
    String? prompt;
    String? userId;

    factory User.fromJson(Map<String, dynamic> json) => User(
        authentication: json["Authentication"],
        prompt: json["prompt"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "Authentication": authentication,
        "prompt": prompt,
        "user_id": userId,
    };
}

// {
//       {
//         "Authentication": "Bearer does-not-matter",
//         "prompt": "prompt",
//         "user_id": "3"
//       }
//     }