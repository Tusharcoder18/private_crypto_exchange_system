import 'package:flutter/material.dart';

import '../Widgets/balance_card.dart';
import '../Widgets/operations_card.dart';
import '../Widgets/transactions_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: drawer(context),
      appBar: AppBar(
        title: const Text("WALLET"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications_active),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        children: [
          balanceCard(context),
          const OperationsCard(),
          transactionsCard(context),
        ],
      ),
    );
  }
}

Widget drawer(BuildContext context) {
  return Drawer(
    backgroundColor: const Color.fromRGBO(12, 12, 12, 1),
    child: ListView(
      children: [
        DrawerHeader(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffec9f05), Color(0xffff4e00)],
              ),
            ),
            child: Text(
              "Tushar Pulakala",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 30),
            )),
        ListTile(
          title: Text(
            "Send Address",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ListTile(
          title: Text(
            "Receive Address",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ListTile(
          title: Text(
            "Settings",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ListTile(
          title: Text(
            "Sign Out",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    ),
  );
}
