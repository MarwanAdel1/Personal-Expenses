import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalDaySum = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalDaySum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalDaySum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionsValue.fold(0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValue);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Flexible(
        fit: FlexFit.tight,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsValue.map((values) {
              return ChartBar(
                  values['day'],
                  values['amount'],
                  maxSpending == 0
                      ? 0
                      : ((values['amount'] as double) / maxSpending));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
