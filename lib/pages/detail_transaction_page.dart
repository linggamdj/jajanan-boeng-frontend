import 'package:flutter/material.dart';
import 'package:jajanan_boeng/models/transaction_model.dart';
import 'package:jajanan_boeng/theme.dart';

class DetailTransactionPage extends StatefulWidget {
  late final TransactionModel transaction;
  DetailTransactionPage(this.transaction);

  @override
  State<DetailTransactionPage> createState() => _DetailTransactionPageState();
}

class _DetailTransactionPageState extends State<DetailTransactionPage> {
  @override
  Widget build(BuildContext context) {
    header() {
      return AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text("Detail Pesanan ${widget.transaction.id}"),
      );
    }

    Widget itemCard(int quantity, String name, int price) {
      return Container(
        margin: EdgeInsets.only(
          top: 12,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 12,
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
        child: Row(
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
                  Text(
                    name,
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Rp${price}',
                    style: priceTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              '${quantity} Items',
              style: orangeTextStyle,
            ),
          ],
        ),
      );
    }

    Widget detailCard() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: EdgeInsets.all(
          20,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pemesanan',
              style: orangeTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Waktu Pesan',
                  style: secondaryTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  '${(widget.transaction.createdAt).toString().substring(0, (widget.transaction.createdAt).toString().length - 8)}',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status Pemesanan',
                  style: secondaryTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  widget.transaction.status,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                    color: widget.transaction.status == 'SUCCESS'
                        ? successColor
                        : primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pengiriman',
                  style: secondaryTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  '(VIA Whatsapp)',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rekening',
                  style: secondaryTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  '7033087609 (BCA A.N. Farhan)',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 2,
              color: primaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: priceTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'Rp${widget.transaction.total_price}',
                  style: priceTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          // Detail Produk
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Produk yang Dipesan',
                  style: orangeTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Column(
                  children: widget.transaction.items
                      .map(
                        (item) => itemCard(item.quantity, item.product.name,
                            item.product.price),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          detailCard(),
          SizedBox(
            height: defaultMargin,
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor7,
      appBar: header(),
      body: content(),
    );
  }
}
