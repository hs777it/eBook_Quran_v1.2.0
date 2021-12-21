import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/bloc/purchased/ebook_purchased_bloc.dart';
import 'package:edu_ebook/bloc/purchased/ebook_purchased_event.dart';
import 'package:edu_ebook/bloc/purchased/ebook_purchased_state.dart';
import 'package:edu_ebook/bloc/search/ebook_search_bloc.dart';
import 'package:edu_ebook/interface/pages/appbar/ebook_app_bar.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_detail.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/entities/ebook_entity.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:edu_ebook/widgets/screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class EbookPurchased extends StatefulWidget {

  @override
  _EbookViewCreditCardState createState() => _EbookViewCreditCardState();
}

class _EbookViewCreditCardState extends State<EbookPurchased> {

  EbookPurchasedBloc ebookPurchasedBloc;

  @override
  void initState() {
    super.initState();
    ebookPurchasedBloc = EbookPurchasedBloc();
    ebookPurchasedBloc.add(EbookPurchasedEventList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>SearchBloc(),
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil.statusBarHeight + 45,
              ),
              child: Container(
                child: BlocProvider(
                  create: (_)=>ebookPurchasedBloc,
                  child: BlocBuilder<EbookPurchasedBloc, EbookPurchasedState>(
                    bloc: ebookPurchasedBloc,
                    builder: (context, state){
                      if (state is EbookPurchasedStateInitial) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }  else if (state is EbookPurchasedStateLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }  else if (state is EbookPurchasedStateSuccess) {
                        return _ebookExploresSuccess(context, state.ebookPurchased);
                      } else if (state is EbookPurchasedStateError) {
                        return Center(
                            child: Text('Any problem with iError', style: TextStyle(fontSize: 16, color: Colors.white),)
                        );
                      } else {
                        return Center(
                            child: Text('Any problem with internal Server', style: TextStyle(fontSize: 16, color: Colors.white),)
                        );
                      }
                    }
                  ),
                ),
              ),
            ),
            EbookAppBar(),
          ],
        ),
      ),
    );
  }

  Widget _ebookExploresSuccess(BuildContext context, List<EbookEntity> entity){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return GridView.builder(
        itemCount: entity.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.8
        ),
        itemBuilder: (context, index){
          EbookEntity entities = entity[index];
          return GestureDetector(
            onTap: () => pushPage(context, EbookDetail(ebookModel: entities,
              id: entities.id,
              status: entities.statusNews,
              title: entities.title,
              photo: entities.photo,
              description: entities.description,
              pdf: entities.pdf,
              authorName: entities.authorName,
              publisherName: entities.publisherName,
              pages: entities.pages,
              language: entities.language,
              price: entities.price,
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: CachedNetworkImage(
                        imageUrl: entities.photo,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
                      child: Container(
                        child: Text(
                          entities.title,
                          maxLines: 3,
                          style: TextStyle(
                            color: ebookTheme.themeMode().textColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
                      child: Container(
                        child: Text(
                          entities.authorName,
                          maxLines: 2,
                          style: TextStyle(
                            color: ebookTheme.themeMode().textAppBar,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
                      child: Container(
                        child: Text(
                          entities.publisherName,
                          maxLines: 2,
                          style: TextStyle(
                            color: ebookTheme.themeMode().textAppBar,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: entities.rating.toDouble(),
                          unratedColor: ebookTheme.themeMode().ratingBar,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 16,
                          direction: Axis.horizontal,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.check_circle_outline,
                            color: ebookTheme.themeMode().checkList,
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        }
    );
  }
}
