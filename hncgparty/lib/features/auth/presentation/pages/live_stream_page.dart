// // live_stream_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hncgparty/features/auth/presentation/blocs/livestream_bloc.dart';
//
// class LiveStreamPage extends StatelessWidget {
//   const LiveStreamPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LivestreamBloc()..add(LoadLivestreams()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Live Streams'),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.add),
//               onPressed: () => _startNewStream(context),
//             ),
//           ],
//         ),
//         body: BlocBuilder<LivestreamBloc, LivestreamState>(
//           builder: (context, state) {
//             if (state is LivestreamLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (state is LivestreamLoaded) {
//               return ListView.builder(
//                 itemCount: state.streams.length,
//                 itemBuilder: (context, index) {
//                   final stream = state.streams[index];
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(stream.thumbnailUrl),
//                     ),
//                     title: Text(stream.title),
//                     subtitle: Text('${stream.viewerCount} viewers'),
//                     trailing: Icon(
//                       stream.isLive ? Icons.live_tv : Icons.offline_bolt,
//                       color: stream.isLive ? Colors.red : Colors.grey,
//                     ),
//                     onTap: () => _joinStream(context, stream),
//                   );
//                 },
//               );
//             }
//             return const Center(child: Text('Error loading streams'));
//           },
//         ),
//       ),
//     );
//   }
//
//   void _startNewStream(BuildContext context) {
//     // Logic khởi tạo stream mới
//   }
//
//   void _joinStream(BuildContext context, Livestream stream) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LiveStreamViewerScreen(stream: stream),
//       ),
//     );
//   }
// }