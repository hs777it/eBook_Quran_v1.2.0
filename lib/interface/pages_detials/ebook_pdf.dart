import 'package:edu_ebook/themes/ebook_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

class PdfPage extends StatefulWidget {
  final String path;
  final String title;

  const PdfPage({Key key, this.path, this.title}) : super(key: key);

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  int totalpages = 0;
  bool pdfready = false;
  PDFViewController pdfviewController;
  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final ebookTheme = Provider.of<EbookTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            swipeHorizontal: false,
            onRender: (_pages) {
              setState(() {
                totalpages = _pages;
                pdfready = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              pdfviewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {
                _currentPage = page;
                totalpages = total;
              });
            },
          ),
          !pdfready? Center(
            child: CircularProgressIndicator(),
          )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        children: <Widget>[
          _currentPage > 0? FloatingActionButton.extended(
            onPressed: () {
              _currentPage -= 1;
              pdfviewController.setPage(_currentPage);
            },
            label: Text("Go to ${_currentPage - 1}", style: TextStyle(color: Colors.blue[800]),),
            backgroundColor: ebookTheme.themeMode().textColor,
          )
              : Offstage(),
          _currentPage < totalpages - 1
              ? FloatingActionButton.extended(
            onPressed: () {
              _currentPage += 1;
              pdfviewController.setPage(_currentPage);
            },
            label: Text("Go to ${_currentPage + 1}", style: TextStyle(color: Colors.blue[800]),),
            backgroundColor: ebookTheme.themeMode().textColor,
          )
              : Offstage(),
        ],
      ),
    );
  }
}
