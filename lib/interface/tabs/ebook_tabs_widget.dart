import 'package:edu_ebook/bloc/tabs/ebook_tab_bloc.dart';
import 'package:edu_ebook/bloc/tabs/ebook_tab_event.dart';
import 'package:edu_ebook/bloc/tabs/ebook_tab_state.dart';
import 'package:edu_ebook/interface/tabs/tabs_constraint.dart';
import 'package:edu_ebook/interface/tabs/tabs_list_view_builder_data.dart';
import 'package:edu_ebook/interface/tabs/tabs_title_widget.dart';
import 'package:edu_ebook/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EbookTabsWidget extends StatefulWidget {
  @override
  _EbookTabsWidgetState createState() => _EbookTabsWidgetState();
}

class _EbookTabsWidgetState extends State<EbookTabsWidget> with SingleTickerProviderStateMixin {

  EbookTabBloc get ebookTabBloc => BlocProvider.of<EbookTabBloc>(context);

  int currentTabsIndwx = 0;

  @override
  void initState() {
    super.initState();
    ebookTabBloc.add(EbookTabChangedEvent(currentIndexTabs: currentTabsIndwx));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EbookTabBloc, EbookTabState>(
      builder: (context, state){
        return Padding(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for(var i = 0; i < TabsConstraint.ebookTabs.length; i++)
                      TabsTitleWidget(
                        title: TabsConstraint.ebookTabs[i].title,
                        onTap: () => _onTabs(i),
                        isSelected: TabsConstraint.ebookTabs[i].id == state.currentIndexTabs,
                      )
                  ],
                ),
              ),
              if (state is EbookTabInitial)
                // new Center(
                //   child: CircularProgressIndicator(
                //     valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                //     backgroundColor: Colors.blue[50],
                //     ),
                // ),
            HSWidget.linearProgressIndicator(),
            
              if (state is EbookTabChanged)
                Expanded(
                  child: TabsListViewBuilderData(ebook: state.ebook),
                ),
            ],
          ),
        );
      }
    );
  }

  _onTabs(int i){
    ebookTabBloc.add(EbookTabChangedEvent(currentIndexTabs: i));
  }
}
