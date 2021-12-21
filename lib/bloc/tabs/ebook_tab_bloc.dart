import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/source/entities/errors.dart';
import 'package:edu_ebook/source/entities/no_params.dart';
import 'package:edu_ebook/source/usecase/get_coming_soon.dart';
import 'package:edu_ebook/source/usecase/get_popular.dart';
import 'package:edu_ebook/source/usecase/get_random.dart';
import 'package:flutter/cupertino.dart';

import 'ebook_tab_event.dart';
import 'ebook_tab_state.dart';

class EbookTabBloc extends Bloc<EbookTabEvent, EbookTabState>{

  final GetPopular getPopular;
  final GetRandom getPlayingLatest;
  final GetComingSoon getComingSoon;

  EbookTabBloc({@required this.getPopular, this.getPlayingLatest, this.getComingSoon}) : super(EbookTabInitial());

  @override
  Stream<EbookTabState> mapEventToState(EbookTabEvent event) async*{
    if (event is EbookTabChangedEvent) {
      yield EbookTabInitial();
      Either<Errors, List<EbookEntity>> ebook;
      switch(event.currentIndexTabs){
        case 0:
          ebook = await getPopular(NoParams());
          break;
        case 1:
          ebook = await getPlayingLatest(NoParams());
          break;
        case 2:
          ebook = await getComingSoon(NoParams());
          break;
      }
      yield ebook.fold(
          (l) => EbookTabErrorLoaded(currentIndexTabs: event.currentIndexTabs),
          (ebook){
            return EbookTabChanged(
              currentIndexTabs: event.currentIndexTabs,
              ebook: ebook
            );
          }
      );
    }  
  }

  

}