import 'package:bloc/bloc.dart';
import 'package:edu_ebook/source/entities/no_params.dart';
import 'package:edu_ebook/source/usecase/get_explores.dart';

import 'ebook_explores_event.dart';
import 'ebook_explores_state.dart';

class EbookExploresBloc extends Bloc<EbookExploresEvent, EbookExploresState>{

  final GetExplores getExplores;

  EbookExploresBloc({this.getExplores}) : super(EbookExploresStateInitial());

  @override
  Stream<EbookExploresState> mapEventToState(EbookExploresEvent event) async*{
    if (event is EbookExploresEventList) {
      yield EbookExploresStateLoading();
      final ebookEntity = await getExplores(NoParams());
      yield ebookEntity.fold((l) => EbookExploresStateError('any problem'), (ebookEntity)
      {
        return EbookExploresStateSuccess(ebookModel: ebookEntity);
      });
    }  
  }

}