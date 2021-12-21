import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_ebook/downloads/utils/download_details.dart';
import 'package:edu_ebook/downloads/utils/favorite/ebook_favorite_notifier.dart';
import 'package:edu_ebook/interface/localization/demo_localizations.dart';
import 'package:edu_ebook/interface/pages_detials/ebook_detail.dart';
import 'package:edu_ebook/routers/ebook_routers.dart';
import 'package:edu_ebook/source/models/ebook_model.dart';
import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class EbookFavoritePage extends StatefulWidget {
  @override
  _EbookFavoritePageState createState() => _EbookFavoritePageState();
}

class _EbookFavoritePageState extends State<EbookFavoritePage> {

  EbookFavoriteNotifier notifier;

  @override
  void initState() {
    super.initState();
    getEbookFavorite();
  }

  @override
  void deactivate() {
    super.deactivate();
    getEbookFavorite();
  }

  getEbookFavorite(){
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<EbookFavoriteNotifier>(context, listen: false).getEbooksFavorites();
        Provider.of<DownloadDetails>(context, listen: false).checkFav(notifier.list.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Consumer<EbookFavoriteNotifier>(
      builder: (BuildContext context, EbookFavoriteNotifier favorite, Widget child){
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              color: ebookTheme.themeMode().textColor,
            ),
            backgroundColor: ebookTheme.themeMode().backgroundColor,
            title: Text(
              DemoLocalizations.of(context).translate('ebook_favorites'),
              style: TextStyle(
                color: ebookTheme.themeMode().textColor
              ),
            ),
          ),
          body: favorite.list.isNotEmpty ? _ebookGridView(favorite) : _ebookIsEmpty(),
        );
      }
    );
  }

  _ebookGridView(EbookFavoriteNotifier favorite){
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: favorite.list.length,
      itemBuilder: (BuildContext context, int index){
        EbookModel ebookModel = EbookModel.fromJson(favorite.list[index]['item']);
        return Padding(
          padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: ()=>pushPage(context, EbookDetail(ebookModel: ebookModel,
              id: ebookModel.id,
              status: ebookModel.statusNews,
              title: ebookModel.title,
              photo: ebookModel.photo,
              description: ebookModel.description,
              pdf: ebookModel.pdf,
              authorName: ebookModel.authorName,
              publisherName: ebookModel.publisherName,
              pages: ebookModel.pages,
              language: ebookModel.language,
              price: ebookModel.price,)),
            child: CachedNetworkImage(
              imageUrl: ebookModel.photo,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.count(
        2,
        2.5
      ),
    );
  }

  _ebookIsEmpty(){
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Center(
      child: Column(
        children: [
          Image.asset(
            '',
            width: 250,
            height: 250,
          ),
          Text(
            DemoLocalizations.of(context).translate('there_are_no_favorites'),
            style: TextStyle(
              fontSize: 16,
              color: ebookTheme.themeMode().textColor
            ),
          )
        ],
      ),
    );
  }
}
