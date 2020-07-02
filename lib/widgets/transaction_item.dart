import "package:flutter/material.dart";
import "../models/transaction.dart";
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}'
                ),
          )),
        ),
        title: Text(transaction.title,
            style: Theme.of(context).textTheme.title),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360
        ? FlatButton.icon(
           icon: Icon(Icons.delete),
           label: Text('Delete'),
           textColor: Theme.of(context).errorColor,
           onPressed: ()=>deleteTx(transaction.id),
           )
        : IconButton(
          icon: Icon(Icons.delete),
           color: Theme.of(context).errorColor,
           onPressed: ()=>deleteTx(transaction.id),
           ),

      ),
    );
  }
}