import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/pdf_api.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PDFViewerPageTermos extends StatelessWidget {
  const PDFViewerPageTermos({super.key});

  @override
  Widget build(BuildContext context) {
    final pdfApi = context.read<PDFApi>();

    if (pdfApi.termos == null) {
      return FutureBuilder(
        future: pdfApi.pickFileTermos(AppLocalizations.of(context)!.language),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(title: Text('Termos de uso')),
              body: Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text('Termos de uso')),
              body: Center(
                child: Text(AppLocalizations.of(context)!.erroInesperado),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(title: Text('Termos de uso')),
            body: PDFView(
              filePath: (snapshot.data as File).path,
              pageSnap: false,
              pageFling: false,
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Termos de uso')),
      body: PDFView(
        filePath: pdfApi.termos!.path,
        pageSnap: false,
        pageFling: false,
      ),
    );
  }
}
