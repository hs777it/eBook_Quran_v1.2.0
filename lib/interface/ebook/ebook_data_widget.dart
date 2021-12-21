import 'package:edu_ebook/bloc/background/ebook_background_bloc.dart';
import 'package:edu_ebook/bloc/background/ebook_background_state.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class EbookDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return BlocBuilder<EbookBackgroundBloc, EbookBackgroundState>(
      builder: (context, state){
        if (state is EbookBackgroundChanged) {
          return Text(
            state.ebook.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: ebookTheme.themeMode().textColor,
              fontSize: 18,
            )
          );
        }  
        return const SizedBox.shrink();
      }
    );
  }
}
