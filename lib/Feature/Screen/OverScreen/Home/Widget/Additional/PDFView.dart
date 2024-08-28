import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:share_plus/share_plus.dart';


class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            theme.getDarkTheme ? themeColor.darkTheme : themeColor.themeColor,
        title: const Text('PDF'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _sharePDF(context, url);
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _downloadPDF('$uri/post/getPdf?pdfUrl=$url',context);
            },
          ),
        ],
      ),
      body: const PDF().cachedFromUrl(
        '$uri/post/getPdf?pdfUrl=$url',
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }

  void _sharePDF(BuildContext context, String url) {
    // Implement sharing functionality here
    // Example:
    Share.shareWithResult('Check out this PDF: ${'$uri/post/getPdf?pdfUrl=$url'}');
  }

  Future<void> _downloadPDF(String url,BuildContext context) async {
    try {
      var request = await http.get(Uri.parse(url));
      var bytes = request.bodyBytes;
      String dir = (await getExternalStorageDirectory())!.path;
      File file = File("$dir/pdffile.pdf");
      await file.writeAsBytes(bytes);
      // Show a snackbar or a toast to indicate successful download
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF downloaded')),
      );
    } catch (e) {
      print(e);
      // Show a snackbar or a toast to indicate error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download PDF')),
      );
    }
  }
}
