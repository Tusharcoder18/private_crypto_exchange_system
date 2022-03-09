import 'package:flutter/material.dart';
import 'package:hello_world_dapp/Contracts/contract_linking.dart';
import 'package:provider/provider.dart';

Widget balanceCard(BuildContext context) {
  return Card(
    elevation: 30,
    shadowColor: const Color.fromRGBO(12, 12, 12, 1),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    color: const Color.fromRGBO(12, 12, 12, 1),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xffec9f05), Color(0xffff4e00)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "BALANCE",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 30),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/icon.png",
                  scale: 13,
                  color: Colors.white,
                ),
                Consumer<ContractLinking>(builder: ((context, value, child) {
                  int? balance = 0;
                  if (value.isLoading == false) {
                    balance = value.getCurrentBalance;
                  }
                  return Text(
                    "$balance TPC",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 30),
                  );
                }))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    ),
  );
}
