import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderClass extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}

class ProviderExample extends StatelessWidget {
  const ProviderExample({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderClass provider = Provider.of(context);
    int c = context.watch<ProviderClass>().count;
    return Scaffold(
      body: Center(
          child: Provider<ProviderClass>(
        create: (context) => ProviderClass(),
        child: Column(
          children: [
            Text(c.toString()),
            ElevatedButton(
                onPressed: () {
                  context.read<ProviderClass>().increment();
                },
                child: Text('Decrement'))
          ],
        ),
        // child: Text(context.watch<ProviderClass>().count.toString()),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.increment();
        },
      ),
    );
  }
}
