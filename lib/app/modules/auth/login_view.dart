import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_architecture_guide/app/modules/auth/login_controller.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.account_circle,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 32),
            Text(
              'Welcome Back',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to your account',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Obx(() => TextField(
              onChanged: controller.setEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: const OutlineInputBorder(),
                errorText: controller.errorMessage.isNotEmpty ? null : null,
              ),
              keyboardType: TextInputType.emailAddress,
            )),
            const SizedBox(height: 16),
            Obx(() => TextField(
              onChanged: controller.setPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                errorText: controller.errorMessage.isNotEmpty ? null : null,
              ),
              obscureText: true,
            )),
            const SizedBox(height: 8),
            Obx(() => controller.errorMessage.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      controller.errorMessage,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox()),
            const SizedBox(height: 24),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading ? null : controller.login,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: controller.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Login'),
            )),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navigate to register page
              },
              child: const Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
