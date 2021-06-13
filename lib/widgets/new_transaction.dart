import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addit;
  NewTransaction(this.addit);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0||_selectedDate==null) {
      return;
    }
    widget.addit(enteredTitle, enteredAmount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }setState(() {
        _selectedDate = pickedDate;
        
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              autocorrect: true,
              enabled: true,
              decoration: InputDecoration(labelText: "Title"),
              onSubmitted: (_) => submitData(),
            ),
            TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: InputDecoration(labelText: "Enter Amount")),
            Container(
              height: 70,
              child: Row(children: [
                Text(_selectedDate == null
                    ? "No Date Chosen"
                    : "Date chosen: " +
                        DateFormat.yMd().format(_selectedDate)),
                FlatButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).primaryColor,
                )
              ]),
            ),
            RaisedButton(
              onPressed: submitData,
              child: Text(
                "Add Transaction",
              ),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    ));
  }
}
