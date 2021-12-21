import 'package:bloc/bloc.dart';
import 'package:edu_ebook/source/entities/no_params.dart';
import 'package:edu_ebook/source/usecase/get_related.dart';

import 'ebook_related_event.dart';
import 'ebook_related_state.dart';

class EbookRelatedBloc extends Bloc<EbookRelatedEvent, EbookRelatedState>{

  final GetRelated getRelated;

  EbookRelatedBloc({this.getRelated}) : super(EbookRelatedStateLoading());

  @override
  Stream<EbookRelatedState> mapEventToState(EbookRelatedEvent event) async*{
    if (event is EbookRelatedEventList) {
      yield EbookRelatedStateLoading();
      final relatedEbook = await getRelated(NoParams());
      yield relatedEbook.fold((l) => EbookRelatedStateError('Any error related ebook'),
              (success) {
        return EbookRelatedStateSuccess(ebook: success);
              });
    }
  }
}