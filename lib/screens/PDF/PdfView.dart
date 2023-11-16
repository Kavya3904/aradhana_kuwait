import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:aradhana/Constants/Constants.dart';
import 'package:flutter/material.dart';

class pdfView extends StatefulWidget {
  static String routeName = "/pdfView";

  const pdfView({Key key}) : super(key: key);

  @override
  State<pdfView> createState() => _pdfViewState();
}

class _pdfViewState extends State<pdfView> {
  bool _isLoading = true;
  PDFDocument _pdf;

  void _loadFile() async {
    // Load the pdf file from the internet
    _pdf = await PDFDocument.fromAsset("assets/Promoters.pdf");

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Promoters',
          style: appBarTxtStyl,
        ),
      ),
      body: Center(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PDFViewer(document: _pdf)),
    );
  }
}
