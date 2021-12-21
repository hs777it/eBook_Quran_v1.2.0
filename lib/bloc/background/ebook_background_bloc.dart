import 'package:bloc/bloc.dart';

import 'ebook_background_event.dart';
import 'ebook_background_state.dart';

class EbookBackgroundBloc extends Bloc<EbookBackgroundEvent, EbookBackgroundState>{

  EbookBackgroundBloc() : super(EbookBackgroundInitial());

  @override
  Stream<EbookBackgroundState> mapEventToState(
      EbookBackgroundEvent event) async*{
    yield EbookBackgroundChanged((event as EbookBackgroundChangeEvent).ebook);
  }
  
}