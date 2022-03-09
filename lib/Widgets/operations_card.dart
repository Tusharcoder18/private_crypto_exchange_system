import 'package:flutter/material.dart';
import 'package:hello_world_dapp/Contracts/contract_linking.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/contracts.dart';

class OperationsCard extends StatefulWidget {
  const OperationsCard({Key? key}) : super(key: key);

  @override
  State<OperationsCard> createState() => _OperationsCardState();
}

class _OperationsCardState extends State<OperationsCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                color: const Color.fromRGBO(12, 12, 12, 1),
                child: InkWell(
                  splashColor: Colors.orangeAccent,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogWidget(
                          operation: "BUY",
                          onTap: Provider.of<ContractLinking>(context).buyTPC,
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                      child: Text(
                        "Buy",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                color: const Color.fromRGBO(12, 12, 12, 1),
                child: InkWell(
                  splashColor: Colors.orangeAccent,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogWidget(
                          operation: "SELL",
                          onTap: Provider.of<ContractLinking>(context).sellTPC,
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                      child: Text(
                        "Sell",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                color: const Color.fromRGBO(12, 12, 12, 1),
                child: InkWell(
                  splashColor: Colors.orangeAccent,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                      child: Text(
                        "Send",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                color: const Color.fromRGBO(12, 12, 12, 1),
                child: InkWell(
                  splashColor: Colors.orangeAccent,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                      child: Text(
                        "Recieve",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DialogWidget extends StatefulWidget {
  final String? operation;
  final Function? onTap;
  const DialogWidget({Key? key, this.operation, this.onTap}) : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  double? amount = 0;

  BigInt get getAmount => BigInt.parse(amount!.toInt().toString());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${widget.operation} TPC',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter Amount',
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14),
          ),
          // const StatefulSlider(),
          Slider(
            value: amount!,
            onChanged: (newAmount) {
              setState(() => amount = newAmount);
            },
            label: "${amount?.toInt()}",
            min: 0,
            max: 100,
            divisions: 100,
            activeColor: Colors.orangeAccent,
            autofocus: true,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            BigInt _amount = getAmount;
            widget.onTap!(_amount);
            Navigator.of(context).pop();
          },
          child: Text(
            "${widget.operation}",
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
          ),
        ),
      ],
      backgroundColor: const Color.fromRGBO(12, 12, 12, 1),
    );
  }
}
