// // chat_room_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hncgparty/features/chat/presentation/blocs/chat_bloc.dart';
//
// class ChatRoomScreen extends StatelessWidget {
//   final ChatRoom room;
//
//   const ChatRoomScreen({super.key, required this.room});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ChatBloc()..add(LoadChatMessages(room.id)),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(room.roomName),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: BlocBuilder<ChatBloc, ChatState>(
//                 builder: (context, state) {
//                   if (state is ChatMessagesLoaded) {
//                     return ListView.builder(
//                       reverse: true,
//                       itemCount: state.messages.length,
//                       itemBuilder: (context, index) {
//                         final message = state.messages[index];
//                         return ChatMessageBubble(message: message);
//                       },
//                     );
//                   }
//                   return const Center(child: CircularProgressIndicator());
//                 },
//               ),
//             ),
//             _buildMessageInput(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMessageInput(BuildContext context) {
//     final textController = TextEditingController();
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: textController,
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0),
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send),
//             onPressed: () {
//               context.read<ChatBloc>().add(
//                 SendMessage(
//                   room.id,
//                   textController.text,
//                   MessageType.text,
//                 ),
//               );
//               textController.clear();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }