// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:whatsapp_using_api/controllers/chat_controller.dart';
//
// import '../models/chat_details.dart';
//
//
// class HomePage extends StatelessWidget {
//   final ChatController chatController = Get.put(ChatController());
//   Widget divider = Divider(
//       height: 12,
//       thickness: 2,
//       indent: 95,
//       endIndent: 20,
//       color: Colors.grey[200]
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//         //home: Scaffold(
//         appBar: AppBar(
//         title: Text("WhatsApp"),
//             backgroundColor: Colors.teal[800],
//              actions: <Widget>[
//                IconButton(
//                  icon: (Icon(Icons.more_vert)),
//                    onPressed: () {},
//                     ),
//                      ],
//                    bottom: PreferredSize(
//                       preferredSize: Size(50, 50.0),
//                         child: const TabBar(
//                            tabs: [
//                             Tab(text: "CHAT"),
//                               Tab(text: "STATUS"),
//                                 Tab(text: "CALLS"),
//                                  ],
//                                  indicatorColor: Colors.white,
//                             ),
//                          ),
//                         ),
//           backgroundColor: Colors.white,
//           body:
//           ListView.builder(
//             itemCount: chatController.chatList.length,
//             itemBuilder: (context, index) => Column(
//               children: <Widget>[
//                 ListTile(
//                   leading: CircleAvatar(
//                     radius: 30,
//                     backgroundImage: AssetImage(
//                       chatController.chatList[index].image,
//                     ),
//                   ),
//                   title: Row(
//                     children: [
//                       Text(
//                         chatController.chatList[index].name.toString(),
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       Spacer(),
//                       Text(
//                         chatController.chatList[index].time.toString(),
//                         style: TextStyle(
//                             color: Colors.black45),
//                       ),
//                     ],
//                   ),
//                   subtitle: Padding(
//                     padding: EdgeInsets.only(top: 5),
//                     child: Text(
//                       chatController.chatList[index].message.toString(),
//                       style: TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                 ),
//                 divider,
//               ],
//             ),
//           ),
//           floatingActionButton: Padding(
//             padding: const EdgeInsets.only(bottom: 20, right: 10),
//             child: Container(
//               height: 70,
//               width: 70,
//               child: FloatingActionButton(
//                 onPressed: () {},
//                 backgroundColor: Colors.greenAccent[400],
//                 child: const Icon(Icons.message, size: 30,),
//               ),
//             ),
//           ),
//
//                          ),
//         ),
//
//                      );
//   }
//
// }


import 'package:flutter/material.dart';
import '../controllers/chat_controller.dart';
import '../models/chat_details.dart';
import '../services/http_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatDetails> chatList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchChats();
  }

  void fetchChats() {
    setState(() {
      isLoading = true; // To turn on the loader indicator
    });

    HttpService.fetchDetails().then((result) {
      // this block will execute after receive the result
      setState(() {
        isLoading = false;             // To turn off the loader indictor
        chatList.clear();              // Ensuring array is empty before adding new data
        chatList.addAll(result);       // Adding all items from remote array to local array
      });
    }).catchError((e) {
      // this block will execute after receive the error
      print("Error occured");          // Show error alert when execute error block
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
            backgroundColor: Color(0xff075E54),
            elevation: 5,
            title: const Text(
              "Whatsapp",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            bottom: const PreferredSize(
              preferredSize: Size(0, 25),
              child: TabBar(
                  tabs: [
                    Tab(text: "CHATS"),
                    Tab(text: "STATUS"),
                    Tab(text: "CALLS"),
                  ],
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  indicatorColor: Colors.white),
            ),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : TabBarView(
            children: [
              ListView.separated(
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        AssetImage(chatList[index].image.toString())),
                    title: Row(
                      children: [
                        Text(chatList[index].name.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20)),
                        Spacer(),
                        Text((chatList[index].time.toString()),
                            style: TextStyle(
                                color: Colors.black45, fontSize: 16)),
                      ],
                    ),
                    subtitle: Text((chatList[index].message.toString()),
                        style: TextStyle(color: Colors.black45)),
                  );
                },
                separatorBuilder: (BuildContext context, int position) {
                  return Divider(
                    indent: 90,
                    color: Color(0xffECE5DD),
                  );
                },
              ),
              Center(
                child: Text("STATUS"),
              ),
              Center(
                child: Text("CALLS"),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.chat),
            backgroundColor: Color(0xff25D366),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
