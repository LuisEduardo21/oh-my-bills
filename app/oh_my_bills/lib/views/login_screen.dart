import 'package:flutter/material.dart';
import 'package:oh_my_bills/views_model/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: Center(
            child:
                viewModel.isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (viewModel.errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              viewModel.errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () async {
                            final success = await viewModel.login();
                            if (success) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          child: const Text('Começar'),
                        ),
                      ],
                    ),
          ),
        );
      },
    );
  }
}
