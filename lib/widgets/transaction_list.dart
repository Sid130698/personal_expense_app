import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _usertransactions;
  final Function deleteTX;
  TransactionList(this._usertransactions, this.deleteTX);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _usertransactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No transaction added yet",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 70,
                  width: 100,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemCount: _usertransactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${_usertransactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      _usertransactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                        DateFormat.yMd().format(_usertransactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteTX(_usertransactions[index].id),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
