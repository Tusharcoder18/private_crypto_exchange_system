import 'package:flutter/material.dart';
import 'package:hello_world_dapp/Contracts/contract_linking.dart';
import 'package:provider/provider.dart';

import 'Wallet Pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContractLinking()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "Calibri",
              ),
            )),
        home: const HomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _name = "Dummy";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello World DApp"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.cyan,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text(
                  "Hello ",
                  style: TextStyle(fontSize: 50, color: Colors.white),
                ),
                Consumer<ContractLinking>(
                  builder: (context, value, child) {
                    if (value.isLoading == false) {
                      // _name = value.deployedName;
                    }
                    return Text(
                      _name!,
                      style: const TextStyle(
                          fontSize: 50, color: Colors.amberAccent),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Name',
              ),
              onChanged: (String name) {
                _name = name;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                // context.read<ContractLinking>().setName(_name!);
              },
              color: Colors.green,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Text(
                "Update Name",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
