// import 'package:http/http.dart' as http;
// import 'package:whatsapp_using_api/models/chat_details.dart';
// import 'package:flutter/cupertino.dart';
//
// class HttpServices {
//
//   static Future<List<ChatDetails>> fetchDetails() async {
//
//     // var client = http.Client();
//     // var uri = 'https://itoons.free.beeceptor.com/my/api/chats';
//     // var url = Uri.parse(uri);
//     // var response = await client.get(url);
//
//     var response = await http.get(
//         Uri.parse("https://itoons.free.beeceptor.com/my/api/chats"),
//     );
//     debugPrint(response.body);
//
//
//     if (response.statusCode == 200) {
//       var data = response.body;
//       return chatDetailsFromJson(data);
//     }
//     else {
//       throw Exception('Failed to load album');
//     }
//   }
// }


import 'package:http/http.dart' as http;
import '../models/chat_details.dart';
class HttpService {
  // static var client = http.Client();
  static Future<List<ChatDetails>> fetchDetails() async {
    // debugPrint("response.body1");
    var response = await http.get(Uri.parse("https://itoons.free.beeceptor.com/my/api/chats"),

    );
    // debugPrint("response.body2");
    // debugPrint(response.body);

    if (response.statusCode == 200) {
      return chatDetailsFromJson(response.body);
    } else {
      throw Exception();
      // return chatDetailsFromJson(response.body);
    }
  }
}