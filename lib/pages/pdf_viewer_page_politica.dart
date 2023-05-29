import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/pdf_api.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PDFViewerPagePolitica extends StatelessWidget {
  const PDFViewerPagePolitica({super.key});

  @override
  Widget build(BuildContext context) {
    final pdfApi = context.read<PDFApi>();

    if (pdfApi.politica == null) {
      return FutureBuilder(
        future: pdfApi.pickFilePolitica(AppLocalizations.of(context)!.language),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(title: Text('Política de privacidade')),
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
              appBar: AppBar(title: Text('Política de privacidade')),
              body: Center(
                child: Text(AppLocalizations.of(context)!.erroInesperado),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(title: Text('Política de privacidade')),
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
      appBar: AppBar(title: Text('Política de privacidade')),
      body: PDFView(
        filePath: pdfApi.politica!.path,
        pageSnap: false,
        pageFling: false,
      ),
    );
  }
}
