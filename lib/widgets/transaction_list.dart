import 'package:expense_app/models/transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList({this.transactions, this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(25),
                    child: Text(
                      'No transaction added yet!',
                      style: Theme.of(context).textTheme.headline6,
                    )),
                Container(
                    child: Image.asset(
                      'assets/images/waiting.png',
                    ),
                    height: 200,
                    margin: EdgeInsets.all(20)),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          margin: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor),
                          padding: EdgeInsets.all(8),
                          child: FittedBox(
                            child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              transactions[index].title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              transactions[index].date.day.toString() +
                                  '-' +
                                  transactions[index].date.month.toString() +
                                  '-' +
                                  transactions[index].date.year.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.all(15),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Theme.of(context).errorColor,
                                    onPressed: () =>
                                        deleteTx(transactions[index].id),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
