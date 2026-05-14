import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/settings_service.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController tokenController =
      TextEditingController();

  String recoveredToken = '';

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SwitchListTile(
              title: const Text('Modo Escuro'),
              value: settings.isDarkMode,
              onChanged: (value) {
                settings.toggleDarkMode(value);
              },
            ),

            SwitchListTile(
              title: const Text('Notificações'),
              value: settings.notificationsEnabled,
              onChanged: (value) {
                settings.toggleNotifications(value);
              },
            ),

            DropdownButtonFormField<String>(
              value: settings.language,
              decoration: const InputDecoration(
                labelText: 'Idioma',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Português',
                  child: Text('Português'),
                ),
                DropdownMenuItem(
                  value: 'English',
                  child: Text('English'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  settings.changeLanguage(value);
                }
              },
            ),

            const SizedBox(height: 30),

            const Divider(),

            const Text(
              'Token Seguro',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: tokenController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite um token fictício',
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () async {
                await StorageService.saveToken(
                  tokenController.text,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Token salvo com segurança',
                    ),
                  ),
                );
              },
              child: const Text('Salvar Token'),
            ),

            ElevatedButton(
              onPressed: () async {
                final token =
                    await StorageService.getToken();

                setState(() {
                  recoveredToken =
                      token ?? 'Nenhum token encontrado';
                });
              },
              child: const Text('Recuperar Token'),
            ),

            ElevatedButton(
              onPressed: () async {
                await StorageService.deleteToken();

                setState(() {
                  recoveredToken = 'Token removido';
                });
              },
              child: const Text('Deletar Token'),
            ),

            const SizedBox(height: 16),

            Text(recoveredToken),
          ],
        ),
      ),
    );
  }
}