import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/screens/pdfview_page.dart';

class IconButtonPDF extends StatelessWidget {
  const IconButtonPDF({super.key});

  @override
  Widget build(BuildContext context) {
    // * Pegando o PDF no dispositivo
    Future<File?> pickFile() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result == null) return null;
      return File(result.paths.first ?? '');
    }

    // * Abrindo o PDF na pagina de vizualização
    void openPdf(File file, String url) => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PdfViewerPage(
              file: file,
              url: url,
            ),
          ),
        );
    return IconButton(
      onPressed: () async {
        String url = '';
        final file = await pickFile();
        if (file == null) return;
        openPdf(file, url);
      },
      icon: Row(
        children: const [
          Text('Abrir PDF'),
          Icon(Icons.picture_as_pdf),
        ],
      ),
    );
  }
}
