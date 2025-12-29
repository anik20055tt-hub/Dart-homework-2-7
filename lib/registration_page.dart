import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'result_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  final List<TextInputFormatter> nameInputFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я]')),
  ];
  final List<TextInputFormatter> surnameInputFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я]')),
  ];
  final List<TextInputFormatter> phoneInputFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
  ];
  final List<TextInputFormatter> loginInputFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
  ];
  final List<TextInputFormatter> passwordInputFormatters = [
    FilteringTextInputFormatter.deny(RegExp(r'\s')),
  ];

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    loginController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Подтверждение'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Имя: ${nameController.text}'),
              Text('Фамилия: ${surnameController.text}'),
              Text('Телефон: ${phoneController.text}'),
              Text('Email: ${emailController.text}'),
              Text('Логин: ${loginController.text}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultPage(
                      name: nameController.text,
                      surname: surnameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      login: loginController.text,
                    ),
                  ),
                );
              },
              child: const Text('ОК'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextField(
                controller: nameController,
                label: 'Имя',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите имя';
                  return null;
                },
                inputFormatters: nameInputFormatters,
              ),
              buildTextField(
                controller: surnameController,
                label: 'Фамилия',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите фамилию';
                  return null;
                },
                inputFormatters: surnameInputFormatters,
              ),
              buildTextField(
                controller: phoneController,
                label: 'Телефон',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите телефон';
                  if (value.length < 10) return 'Телефон должен быть не меньше 10 символов';
                  return null;
                },
                inputFormatters: phoneInputFormatters,
              ),
              buildTextField(
                controller: emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите email';
                  if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value)) {
                    return 'Введите корректный email';
                  }
                  return null;
                },
              ),
              buildTextField(
                controller: loginController,
                label: 'Логин',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите логин';
                  return null;
                },
                inputFormatters: loginInputFormatters,
              ),
              buildTextField(
                controller: passwordController,
                label: 'Пароль',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите пароль';
                  if (value.length < 6) return 'Минимум 6 символов';
                  return null;
                },
                inputFormatters: passwordInputFormatters,
              ),
              buildTextField(
                controller: repeatPasswordController,
                label: 'Повторите пароль',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Повторите пароль';
                  if (value != passwordController.text) return 'Пароли не совпадают';
                  return null;
                },
                inputFormatters: passwordInputFormatters,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Зарегистрироваться'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
