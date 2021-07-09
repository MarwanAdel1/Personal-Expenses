import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionsList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.1,
                  child: Text(
                    "No transactions added yet!",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  height: constraints.maxHeight * 0.9,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, position) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      transactions[position].amount.toStringAsFixed(2) + " L.E",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  title: Text(
                    transactions[position].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[position].date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  trailing: mediaQuery.size.width > 450
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text("Delete"),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[position].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[position].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
//children: [
//     Container(
//       margin: EdgeInsets.symmetric(
//         vertical: 10,
//         horizontal: 15,
//       ),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Theme.of(context).primaryColor,
//           width: 2,
//         ),
//       ),
//       padding: EdgeInsets.all(10),
//       child: Text(
//         transactions[position].amount.toStringAsFixed(2) +
//             " L.E",
//         style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Theme.of(context).primaryColor),
//       ),
//     ),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//    //   children: [
//         Text(
//           transactions[position].title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         Text(
//           DateFormat.yMMMd()
//               .format(transactions[position].date),
//           style: TextStyle(
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     ),
//     IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Theme.of(context).errorColor,))
//   ],
// ),
