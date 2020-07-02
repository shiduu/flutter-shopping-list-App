import 'dart:io';

import 'package:flutter/cupertino.dart';

import './models/transaction.dart';
import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/charts.dart';


void main(){
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 16,
            fontFamily: 'OpenSans')
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        )
      ),
      title: 'Expense App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> userTransactions = [ ];
  bool showchart = false;
 //chart
  List<Transaction> get  recentTransactions{
    return userTransactions.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
          ),
          );
    }).toList();
  }

  //adding new transaction
  void addNewTransaction(String txtitle, double txamount, DateTime choosenDate){
    final newTx = Transaction(
       title: txtitle,
       amount: txamount,
       date: choosenDate,
       id: DateTime.now().toString()
       );

       setState((){
          userTransactions.add(newTx);
        });

  }
 // showing the modal
  void startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx, 
      builder: (_){
      return GestureDetector(
        onTap: (){},
        child: NewTransaction(addNewTransaction),
        behavior: HitTestBehavior.opaque,
        );
        
    },
    );
  }

  //deleting the transaction
  void deleteTransaction(String id){
    setState((){
      userTransactions.removeWhere((tx)=> tx.id == id);
    });

  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final isLandscape = mediaquery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS 
      ? CupertinoNavigationBar(
        middle: Text('Personal Expense'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          GestureDetector(
            child:Icon(CupertinoIcons.add),
            onTap: ()=> startAddNewTransaction(context),
          )
        ],
      )
       )
      : AppBar(
        title: Text('Expense Saver'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
             onPressed: ()=> startAddNewTransaction(context),
          )
        ],
      );
    final txListWidget = Container(
             height: (mediaquery.size.height - 
             appBar.preferredSize.height - 
             mediaquery.padding.top)*0.7,
            child: TransactionList(userTransactions, deleteTransaction)
            );
    final pageBody = SafeArea(child: SingleChildScrollView(child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         if (isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text('show chart'),
            Switch.adaptive(value: showchart,
             onChanged: (val){
              setState((){
                showchart = val;
              });
            })

          ],
          ),

          
        if(!isLandscape) Container(
            height: (mediaquery.size.height -
             appBar.preferredSize.height -
             mediaquery.padding.top)*0.3,
            child: Chart(recentTransactions)
            ),
        if(!isLandscape) txListWidget,
        if(isLandscape) showchart ? Container(
            height: (mediaquery.size.height -
             appBar.preferredSize.height -
             mediaquery.padding.top)*0.7,
            child: Chart(recentTransactions)
            )

          : txListWidget,

      ],
      ),
    )
    );
    return Platform.isIOS ? CupertinoPageScaffold(child: pageBody,)
    :Scaffold(
      appBar: appBar,
      body: pageBody,
    floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
    floatingActionButton: Platform.isIOS
    ? Container()
     : FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: ()=> startAddNewTransaction(context),
    ),
    );
  }
}



