// // livestream_bloc.dart
// part of 'livestream_bloc.dart';
//
// abstract class LivestreamEvent {}
// class LoadLivestreams extends LivestreamEvent {}
// class StartLivestream extends LivestreamEvent {
//   final String title;
//   final String thumbnailUrl;
//   StartLivestream(this.title, this.thumbnailUrl);
// }
//
// abstract class LivestreamState {}
// class LivestreamLoading extends LivestreamState {}
// class LivestreamLoaded extends LivestreamState {
//   final List<Livestream> streams;
//   LivestreamLoaded(this.streams);
// }
//
// class LivestreamBloc extends Bloc<LivestreamEvent, LivestreamState> {
//   LivestreamBloc() : super(LivestreamLoading()) {
//     on<LoadLivestreams>(_onLoadLivestreams);
//   }
//
//   Future<void> _onLoadLivestreams(
//       LoadLivestreams event,
//       Emitter<LivestreamState> emit,
//       ) async {
//     try {
//       final streams = await LivestreamRepository().getActiveStreams();
//       emit(LivestreamLoaded(streams));
//     } catch (e) {
//       // Xử lý lỗi
//     }
//   }
// }