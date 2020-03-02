import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTx;

  TransactionList(this._userTransactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    // for listView or column with singleChildScrollView in the middle of app
    // the define height is required without this it collapse because it has
    // infinite amount of height. so Widget does not know how much space it use
    // use of ListView.builder() is more optimized it required itemBuilder
    // which give Build context  and index for use
    return _userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrain) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Transaction added Yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      height: constrain.maxHeight * 0.6,
                      child: Image.asset('images/waiting.png')),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    child: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '\$ ${_userTransactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.button.color,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_userTransactions[index].date),
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () =>
                              _deleteTx(_userTransactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              _deleteTx(_userTransactions[index].id),
                        ),
                ),
              );
            },
            itemCount: _userTransactions.length,
          );
  }
}
