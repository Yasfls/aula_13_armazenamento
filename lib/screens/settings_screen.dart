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

    final bool isEnglish = settings.language == 'English';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isEnglish
              ? 'Settings'
              : 'Configurações',
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          Text(
            isEnglish
                ? 'Application Preferences'
                : 'Preferências do Aplicativo',

            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 3,
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode),

              title: Text(
                isEnglish
                    ? 'Dark Mode'
                    : 'Modo Escuro',
              ),

              subtitle: Text(
                isEnglish
                    ? 'Enable dark theme'
                    : 'Ativar tema escuro',
              ),

              value: settings.isDarkMode,

              onChanged: (value) {
                settings.toggleDarkMode(value);
              },
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 3,
            child: SwitchListTile(
              secondary: const Icon(Icons.notifications),

              title: Text(
                isEnglish
                    ? 'Notifications'
                    : 'Notificações',
              ),

              subtitle: Text(
                isEnglish
                    ? 'Receive app notifications'
                    : 'Receber notificações do app',
              ),

              value: settings.notificationsEnabled,

              onChanged: (value) {
                settings.toggleNotifications(value);
              },
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [

                      const Icon(Icons.language),

                      const SizedBox(width: 10),

                      Text(
                        isEnglish
                            ? 'Language'
                            : 'Idioma',

                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(

                    value: settings.language,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
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
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          Text(
            isEnglish
                ? 'Secure Storage'
                : 'Armazenamento Seguro',

            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Card(
            elevation: 3,

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,

                children: [

                  TextField(
                    controller: tokenController,

                    decoration: InputDecoration(

                      labelText: isEnglish
                          ? 'Authentication Token'
                          : 'Token de Autenticação',

                      hintText: isEnglish
                          ? 'Enter a fake token'
                          : 'Digite um token fictício',

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),

                      prefixIcon:
                          const Icon(Icons.lock),
                    ),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton.icon(

                    icon: const Icon(Icons.save),

                    label: Text(
                      isEnglish
                          ? 'Save Token'
                          : 'Salvar Token',
                    ),

                    onPressed: () async {

                      await StorageService.saveToken(
                        tokenController.text,
                      );

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        SnackBar(
                          content: Text(
                            isEnglish
                                ? 'Token saved successfully'
                                : 'Token salvo com segurança',
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(

                    icon: const Icon(Icons.search),

                    label: Text(
                      isEnglish
                          ? 'Retrieve Token'
                          : 'Recuperar Token',
                    ),

                    onPressed: () async {

                      final token =
                          await StorageService.getToken();

                      setState(() {

                        recoveredToken = token ??
                            (isEnglish
                                ? 'No token found'
                                : 'Nenhum token encontrado');
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(

                    icon: const Icon(Icons.delete),

                    label: Text(
                      isEnglish
                          ? 'Delete Token'
                          : 'Deletar Token',
                    ),

                    onPressed: () async {

                      await StorageService.deleteToken();

                      setState(() {

                        recoveredToken = isEnglish
                            ? 'Token deleted'
                            : 'Token removido';
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  Container(

                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(12),

                      color: Colors.grey.shade200,
                    ),

                    child: Text(

                      recoveredToken.isEmpty
                          ? (isEnglish
                              ? 'No token loaded'
                              : 'Nenhum token carregado')
                          : recoveredToken,

                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          Card(
            color: Colors.blue.shade50,

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Text(

                isEnglish
                    ? 'This app stores only necessary local data, following privacy and LGPD principles.'
                    : 'Este aplicativo armazena apenas dados locais necessários, seguindo os princípios de privacidade e LGPD.',

                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}