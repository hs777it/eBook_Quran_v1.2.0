import 'package:bloc/bloc.dart';
import 'package:edu_ebook/bloc/background/ebook_background_bloc.dart';
import 'package:edu_ebook/bloc/background/ebook_background_event.dart';
import 'package:edu_ebook/source/entities/no_params.dart';
import 'package:edu_ebook/source/usecase/get_trending.dart';
import 'package:flutter/cupertino.dart';

import 'ebook_carousel_event.dart';
import 'ebook_carousel_state.dart';

class EbookCarouselBloc extends Bloc<EbookCarouselEvent, EbookCarouselState>{

  final GetTrending getTrending;
  final EbookBackgroundBloc ebookBackgroundBloc;

  EbookCarouselBloc({@required this.getTrending, this.ebookBackgroundBloc}) : super(EbookCarouselInitial());

  @override
  Stream<EbookCarouselState> mapEventToState(
      EbookCarouselEvent event) async*{
    if (event is CarouselLoadEvent) {
      final ebook = await getTrending(NoParams());
      yield ebook.fold((l) => EbookCarouselError(),
              (ebook) {
        ebookBackgroundBloc.add(EbookBackgroundChangeEvent(ebook[event.defaultIndex]));
        return EbookCarouselLoaded(
          ebook: ebook,
          defaultIndex: event.defaultIndex,
        );
      }
      );
    }  
  }

}