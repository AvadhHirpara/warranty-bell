import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splacescreen_event.dart';
part 'splacescreen_state.dart';

class SplacescreenBloc extends Bloc<SplacescreenEvent, SplacescreenState> {
  SplacescreenBloc() : super(SplacescreenInitial()) {
    on<SplacescreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
