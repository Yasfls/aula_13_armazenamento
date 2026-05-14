# LocalVault

## Yasmin F. L. da Silva

# Descrição do Aplicativo

Aplicativo Flutter desenvolvido para demonstrar diferentes formas de armazenamento local de dados em dispositivos móveis utilizando:

- SharedPreferences
- Hive
- flutter_secure_storage

O aplicativo permite:

- Alterar configurações do aplicativo
- Salvar preferências do usuário
- Persistir dados localmente
- Armazenar informações sensíveis de forma segura
- Simular boas práticas relacionadas à LGPD

# Por que foi escolhido SharedPreferences para configurações?

O SharedPreferences foi escolhido porque ele é ideal para armazenar dados simples em formato chave-valor, como:

- Tema do aplicativo
- Idioma
- Preferências de notificações

# Por que foi escolhido Hive para o perfil do usuário?

O Hive foi escolhido porque ele oferece:

- Alta performance
- Armazenamento local estruturado
- Facilidade para salvar objetos complexos
- Banco NoSQL leve e rápido

# Por que foi escolhido flutter_secure_storage para o token?

O flutter_secure_storage foi escolhido porque o token representa um dado sensível.

Esse pacote utiliza:

- Keychain no iOS
- Keystore no Android

# Como Rodar o Projeto

1. Clonar o repositório
git clone LINK_DO_REPOSITORIO

2. Entrar na pasta
cd localvault

3. Instalar dependências
flutter pub get

4. Gerar arquivos do Hive
flutter packages pub run build_runner build

5. Rodar o projeto
flutter run

# Se este aplicativo fosse publicado na Play Store, ele estaria coletando e armazenando:

Nome do usuário
E-mail
Preferências do aplicativo
Token de autenticação fictício

# Para garantir conformidade com a LGPD, o aplicativo:

armazenaria apenas dados necessários
informaria claramente quais dados são salvos
solicitaria consentimento do usuário
permitiria exclusão completa dos dados
utilizaria armazenamento seguro para informações sensíveis