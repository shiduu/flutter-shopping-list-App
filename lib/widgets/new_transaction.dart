import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTx(
      titleController.text,
      double.parse(amountController.text),
      selectedDate
      );

    Navigator.of(context).pop();
  }

  void presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now()
      ).then((pickedDate){
        if(pickedDate == null){
          return;
        }

        setState((){
           selectedDate = pickedDate;
        });

      });
      print('....');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top:10,
            left:10,
            right:10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10
            ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: new TextStyle(height: 0.7),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                  decoration: InputDecoration(
                    labelText: 'title',
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                  ),
                  // onChanged: (val){
                  //   titleInput = val;
                  // },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: new TextStyle(
                    height: 0.7,
                  ),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                  decoration: InputDecoration(
                    labelText: 'amount',
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                  ),
                  // onChanged: (val){
                  //   amountInput = val;

                  // },
                ),
              ),
              Container(
                height: 70,
                padding: EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                    child: Text(
                        selectedDate == null 
                        ? 'No date selected' 
                        : 'picked Date: ${DateFormat.yMd().format(selectedDate)}',),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      onPressed: presentDatePicker,

                    )
                  ]
                ),
              ),
              FlatButton(
                  //color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.teal)),
                  child: Text(
                    'Add Transaction',
                    style: Theme.of(context).textTheme.title,
                  ),
                  textColor: Colors.white,
                  onPressed: submitData
                  )
            ],
          ),
        ),
      ),
    );
  }
}
