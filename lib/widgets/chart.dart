import 'package:flutter/cupertino.dart';

import '../models/transactions.dart';
import 'package:flutter/material.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for(int i = 0; i < recentTransactions.length; i++){
        if(recentTransactions[i].date.day == weekDay.day && recentTransactions[i].date.month == weekDay.month && recentTransactions[i].date.year == weekDay.year){
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }

      //print(weekDay.day.toString());
      //print(totalSum);

      return {'day': weekDay.day.toString(), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, item){
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedTransactionValues.map((e){
          return  Expanded(
            child: ChartBar(
                  e['day'],
                  e['amount'],
                  totalSpending == 0.0 ? 0.0 :(e['amount'] as double)/totalSpending),
          );
        }).toList(),

      ),
    );
  }
}
