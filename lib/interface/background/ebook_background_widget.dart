import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/bloc/background/ebook_background_bloc.dart';
import 'package:edu_ebook/bloc/background/ebook_background_state.dart';
import 'package:edu_ebook/widgets/screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EbookBackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0)
        ),
        child: Stack(
          children: [
            FractionallySizedBox(
              heightFactor: 0.7,
              widthFactor: 1,
              child: BlocBuilder<EbookBackgroundBloc, EbookBackgroundState>(
                  builder: (context, state){
                    if (state is EbookBackgroundChanged) {
                      return CachedNetworkImage(
                        imageUrl: '${state.ebook.photo}',
                        fit: BoxFit.cover,
                      );
                    }
                    return SizedBox.shrink();
                  }
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: ScreenUtil.screenWidth,
                height: 0.9,
                color: Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
