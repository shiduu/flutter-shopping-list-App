import 'package:flutter/material.dart';

import '../models/transaction.dart';

import "../widgets/transaction_item.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraint){
            return Column(
              children: <Widget>[
                Text(
                  'There is no transaction ',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: constraint.maxHeight * 0.6,
                    child: Center(
                        child: Image.asset(
                  'assets/images/nolist.png',
                  fit: BoxFit.cover,
                )))
              ],
            );

          })
          
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
               
              },
              itemCount: transactions.length,
           
    );
  }
}


