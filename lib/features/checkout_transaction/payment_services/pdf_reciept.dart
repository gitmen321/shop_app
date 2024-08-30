import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:shop_app/models/cart_items.dart';

Future<void> generatePdfReciept({
  required List<CartItem> cartItems,
  required double totalPrice,
  required String transactionId,
  required DateTime purchaseDate,
  required BuildContext context,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
          
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Company Name', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text('www.companywebsite.com'),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Divider(thickness: 1),

           
            pw.Center(
              child: pw.Text('Receipt', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue)),
            ),
            pw.SizedBox(height: 16),

            
            pw.Text('Transaction ID: $transactionId', style: pw.TextStyle(fontSize: 16)),
            pw.Text('Date of Purchase: ${purchaseDate.toLocal()}'),
            pw.SizedBox(height: 16),
            pw.Divider(thickness: 1),

           
            pw.Text('Products:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey),
              columnWidths: {
                0: pw.FlexColumnWidth(4),
                1: pw.FlexColumnWidth(2),
                2: pw.FlexColumnWidth(2),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Product', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Quantity', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
                ...cartItems.map((item) {
                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(item.title),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('x${item.quantity}'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('₹${item.price.toStringAsFixed(2)}'),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Divider(thickness: 1),

            
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total Amount', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text('₹${totalPrice.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              ],
            ),
            pw.SizedBox(height: 20),

            
            pw.Divider(thickness: 1),
            pw.Center(
              child: pw.Text('Thank you for your purchase!', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Text('For any queries, contact support@companywebsite.com'),
            ),
          ],
        );
      },
    ),
  );

  
  final outputDir = Directory('/storage/emulated/0/Download');
  if (!await outputDir.exists()) {
    await outputDir.create(recursive: true);
  }

  final file = File("${outputDir.path}/receipt.pdf");
  await file.writeAsBytes(await pdf.save());

  
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Receipt saved to Downloads'),
    ),
  );

  
  final xFile = XFile(file.path);
  Share.shareXFiles([xFile], text: 'Your Purchase Receipt');
}
