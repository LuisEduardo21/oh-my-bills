import 'package:flutter/material.dart';
import 'package:oh_my_bills/services/transaction_service.dart';
import 'package:oh_my_bills/views/home_screen.dart';
import 'package:oh_my_bills/views/login_screen.dart';
import 'package:oh_my_bills/views_model/bank_card_view_model.dart';
import 'package:oh_my_bills/views_model/login_view_model.dart';
import 'package:oh_my_bills/views_model/transaction_view_model.dart';
import 'package:provider/provider.dart';

abstract class BankCardService {
  Future<List<dynamic>> getBankCards();
}

class MockBankCardService implements BankCardService {
  @override
  Future<List<dynamic>> getBankCards() async {
    return [];
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final transactionService = MockTransactionService();
  final bankCardService = MockBankCardService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionViewModel(transactionService),
        ),
        ChangeNotifierProvider(
          create: (_) => BankCardViewModel(bankCardService),
        ),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: const FinanceApp(),
    ),
  );
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Provider.of<LoginViewModel>(context, listen: false).hasToken(),
      builder: (context, snapshot) {
        String initialRoute =
            snapshot.hasData && snapshot.data == true ? '/home' : '/login';

        return MaterialApp(
          title: 'Controle de Finanças',
          theme: ThemeData(
            primaryColor: Colors.greenAccent,
            scaffoldBackgroundColor: Colors.white,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.greenAccent,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.greenAccent,
              titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: initialRoute,
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}
