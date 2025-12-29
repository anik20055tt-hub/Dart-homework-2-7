import 'package:flutter/material.dart';

void main() =>
  runApp(const DialogDemoApp());


class DialogDemoApp extends StatelessWidget {
  const DialogDemoApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dialoog Demo',
      theme:  ThemeData(
        useMaterial3: true,
        colorSchemeSeed:  Colors.purpleAccent,
      ),
      home:HomePage() ,

    );
  }

}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void showConfirmdialog(BuildContext context){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Падтверждение '),
          content: const Text('Вы уверены?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context) , 
            child: Text('Отмена'),
          ),
            ElevatedButton(
              onPressed:  ()  {
                Navigator.pop (context);
                ScaffoldMessenger.of(
                  context
                ).showSnackBar(
                  SnackBar(content: Text('Вы нажали ОК'),
                  ),
                );

              },
               child: Text('Ok'),
               ),
          ],
        );
      });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Пример'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () => showConfirmdialog(context),
         child: Text('Показать диалог')),

      ),
    );
    
  }
}