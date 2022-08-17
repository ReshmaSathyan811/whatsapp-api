// To parse this JSON data, do
//
//     final chatDetails = chatDetailsFromJson(jsonString);

import 'dart:convert';

List<ChatDetails> chatDetailsFromJson(String str) => List<ChatDetails>.from(json.decode(str).map((x) => ChatDetails.fromJson(x)));

String chatDetailsToJson(List<ChatDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatDetails {
  ChatDetails({
    this.name,
    this.message,
    this.time,
    this.image,
  });

  final String? name;
  final String? message;
  final String? time;
  final String? image;

  factory ChatDetails.fromJson(Map<String, dynamic> json) => ChatDetails(
    name: json["name"],
    message: json["message"],
    time: json["time"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "message": message,
    "time": time,
    "image": image,
  };
}
