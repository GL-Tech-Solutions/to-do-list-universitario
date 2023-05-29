import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PDFApi {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  File? termos;
  File? politica;

  Future<File> _storeFile(String url, Uint8List bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<File> pickFileTermos(String languageCode) async {
    try {
      final refPDF =
          _storage.ref('/termos').child('Termos_de_Uso - $languageCode.pdf');
      log(refPDF.fullPath);
      final bytes = await refPDF.getData();
      final selectedTermos = await _storeFile(languageCode, bytes!);
      termos = selectedTermos;
      return selectedTermos;
    } on FirebaseException catch (e, s) {
      log(e.message ?? 'Erro desconhecido', error: e, stackTrace: s);
      throw Exception();
    }
  }

  Future<File> pickFilePolitica(String languageCode) async {
    try {
      final refPDF =
          _storage.ref().child('politicas/Privacy_Policy - $languageCode.pdf');
      final bytes = await refPDF.getData();
      final selectedPolitica = await _storeFile(languageCode, bytes!);
      politica = selectedPolitica;
      return selectedPolitica;
    } on FirebaseException catch (e, s) {
      log(e.message ?? 'Erro desconhecido', error: e, stackTrace: s);
      throw Exception();
    }
  }
}
