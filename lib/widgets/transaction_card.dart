import 'package:flutter/material.dart';
import 'package:jajanan_boeng/pages/detail_transaction_page.dart';
import 'package:jajanan_boeng/models/transaction_model.dart';
import 'package:jajanan_boeng/theme.dart';

class TransactionCard extends StatelessWidget {
  late final TransactionModel transaction;
  TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailTransactionPage(transaction),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 15,
          bottom: 10,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: backgroundColor7,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: new DecorationImage(
                      image: new AssetImage('assets/foto-produk.jpeg'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Text(
                              'Nomor Transaksi: ',
                              style: primaryTextStyle,
                            ),
                            Text(
                              '${transaction.id}',
                              style: primaryTextStyle.copyWith(
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Status Saat Ini: ',
                            style: primaryTextStyle,
                          ),
                          Text(
                            '${transaction.status}',
                            style: primaryTextStyle.copyWith(
                              fontWeight: semiBold,
                              color: transaction.status == 'SUCCESS'
                                  ? successColor
                                  : primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Harga Total: ',
                            style: primaryTextStyle,
                          ),
                          Text(
                            'Rp${transaction.total_price}',
                            style: priceTextStyle.copyWith(
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
