// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatService  {
//   final db = FirebaseFirestore.instance;

//   saveMessage(Map<String, dynamic> message, String chatRoomId) async {
//     try {
//       await db
//           .collection('chatRooms')
//           .doc(chatRoomId)
//           .collection('messages')
//           .add(message);
//     } catch (e) {
//       rethrow;
//     }
//   }

//     Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String chatRoomId)  {
//       return db
//           .collection('chatRooms')
//           .doc(chatRoomId)
//           .collection('messages')
//           .snapshots();
    
//   }
// }
