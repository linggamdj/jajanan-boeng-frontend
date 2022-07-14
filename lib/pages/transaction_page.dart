import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jajanan_boeng/providers/transaction_provider.dart';
import 'package:jajanan_boeng/theme.dart';
import 'package:jajanan_boeng/widgets/transaction_card.dart';
import 'package:jajanan_boeng/providers/page_provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    header() {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            pageProvider.currentIndex == 0
                ? Navigator.pushNamed(context, '/home')
                : Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Pesanan Anda',
        ),
        elevation: 0,
      );
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/new_icon/cart-icon.png',
              width: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Anda Belum Pernah Melakukan Transaksi',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
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
        children: transactionProvider.transactions
            .map(
              (transaction) => TransactionCard(transaction),
            )
            .toList(),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor7,
        appBar: header(),
        body: transactionProvider.transactions.length == 0
            ? emptyCart()
            : content(),
      ),
    );
  }
}
