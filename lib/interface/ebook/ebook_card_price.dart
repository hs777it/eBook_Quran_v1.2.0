import 'package:edu_ebook/bloc/background/ebook_background_bloc.dart';
import 'package:edu_ebook/bloc/background/ebook_background_state.dart';
import 'package:edu_ebook/source/core/global_payments.dart';
import 'package:edu_ebook/source/entities/ebook_payments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EbookCardPrice extends StatefulWidget {
  @override
  _EbookCardPriceState createState() => _EbookCardPriceState();
}

class _EbookCardPriceState extends State<EbookCardPrice> {
  String idGoogle;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EbookBackgroundBloc, EbookBackgroundState>(
        builder: (context, state){
          if (state is EbookBackgroundChanged) {
            return Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.all(1),
              child: _itemPurchase(state),
            );
          }
          return const SizedBox.shrink();
        }
    );
  }

  Widget _itemPurchase(EbookBackgroundChanged states){
    if (idGoogle != null) {
      return FutureBuilder(
          future: GlobalPayments().ebookEntity(states.ebook.id.toString()),
          builder: (BuildContext context, AsyncSnapshot<List<EbookPayments>> snapshot){
            var idProduct = snapshot.data[0].idProduct;
            var idUser = snapshot.data[0].idUser;
            if (states.ebook.id.toString() == idProduct && idUser == idGoogle) {
              return Padding(
                padding: EdgeInsets.only(top: 2, bottom: 2, left: 18, right: 18),
                child: Text(
                    'Purchased',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 17,
                    )
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(top: 2, bottom: 2, left: 18, right: 18),
                child: Text(
                    "fm.output.symbolOnLeft",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 17,
                    )
                ),
              );
            }
          }
      );
    }  else {
      return GestureDetector(
        onTap: (){
          Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('You must login first'),
                duration: new Duration(milliseconds: 1300),
              )
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("fmf.output.symbolOnLeft",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),)
              ],
          ),
        ),
      );
    }
  }
}


