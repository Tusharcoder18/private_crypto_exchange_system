import 'package:flutter/material.dart';

Widget transactionsCard(BuildContext context) {
  return Card(
    elevation: 30,
    shadowColor: const Color.fromRGBO(12, 12, 12, 1),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    color: const Color.fromRGBO(12, 12, 12, 1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Transaction History",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("More"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        "John Doe",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 15),
                      ),
                    ),
                    Text(
                      "4.07 TPC",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              );
            }),
      ],
    ),
  );
}
