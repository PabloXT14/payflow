<h1 align="center">
  <img
    src=".github/payflow-logo.png"
    title="PayFlow"
    alt="PayFlow"
    width="100px"
  />
</h1>

<p align="center">
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/pabloxt14/payflow">
  <img alt="GitHub Top Language" src="https://img.shields.io/github/languages/top/pabloxt14/payflow" />
  <img alt="Repository size" src="https://img.shields.io/github/repo-size/pabloxt14/payflow">
  <a href="https://github.com/pabloxt14/payflow/commits/master">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/pabloxt14/payflow">
  </a>
  <img alt="License" src="https://img.shields.io/badge/license-MIT-blue">
  <a href="https://github.com/pabloxt14/payflow/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/pabloxt14/payflow?style=social">
  </a>
</p>

<p>
  <img src=".github/cover.png" alt="Capa do projeto" />
</p>

<!-- <h4 align="center"> 
	🚀 Aplicação finalizada 🚀
</h4> -->

<p align="center">
 <a href="#-about">About</a> | 
 <a href="#-deploy">Deploy</a> | 
 <a href="#-layout">Layout</a> | 
 <a href="#-setup">Setup</a> | 
 <a href="#-technologies">Technologies</a> | 
 <a href="#-license">License</a>
</p>

## 💻 About

O **Payflow** é um aplicativo mobile feito em Flutter para o controle e organização de boletos e pagamentos, permitindo ao usuário cadastrar suas cobranças de forma simples e prática, podendo escanear o código de barras ou digitar manualmente. O objetivo é facilitar a organização financeira pessoal, ajudando a lembrar dos vencimentos e possibilitando o acompanhamento dos pagamentos realizados.

Principais recursos:
- Cadastro, remoção e visualização de boletos
- Leitura de código de barras com a câmera ou foto da galeria
- Organização de pagamentos (a pagar e pagos)
- Armazenamento local usando Shared Preferences
- Login Social com Google
- Interface moderna e intuitiva


## 🔗 Deploy

- Download do APK: [Android](https://github.com/PabloXT14/payflow/releases/download/v1.0.0-beta/payflow-v1.0.0-beta.apk)


## 🎨 Layout

Você pode visualizar o layout base do projeto no [Figma](https://www.figma.com/community/file/991337911070600335/payflow). É necessário ter uma conta no [Figma](https://www.figma.com/) para acessá-lo.

A seguir, uma demonstração das principais telas:

### Splash
<p align="center">
  <img src=".github/screens/splash.png" alt="Splash Screen" title="Splash Screen"/>
</p>

### Login
<p align="center">
  <img src=".github/screens/login.png" alt="Login Screen" title="Login Screen"/>
</p>

### Home
<p align="center">
  <img src=".github/screens/home.png" alt="Home Screen" title="Home Screen"/>
</p>

### Edit Boleto Modal
<p align="center">
  <img src=".github/screens/edit-boleto-modal.png" alt="Edit Boleto Screen" title="Edit Boleto Screen"/>
</p>

### Extract
<p align="center">
  <img src=".github/screens/extract.png" alt="Extract Screen" title="Extract Screen"/>
</p>

### Scan Bar Code
<p align="center">
  <img src=".github/screens/scan-barcode.png" alt="Scan Bar Code Screen" title="Scan Bar Code Screen"/>
</p>

### Scan Bar Code Try Again
<p align="center">
  <img src=".github/screens/scan-barcode-try-again.png" alt="Scan Bar Code Try Again Screen" title="Scan Bar Code Try Again Screen"/>
</p>

### Boleto Form (Empty)
<p align="center">
  <img src=".github/screens/boleto-form-empty.png" alt="Boleto Form Empty Screen" title="Boleto Form Empty Screen"/>
</p>

### Boleto Form (Filled)
<p align="center">
  <img src=".github/screens/boleto-form-filled.png" alt="Boleto Form Filled Screen" title="Boleto Form Filled Screen"/>
</p>


## ⚙ Setup

### 📝 Pré-requisitos

Antes de começar, você precisará ter as seguintes ferramentas instaladas:
- [Git](https://git-scm.com)
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)

E um editor para trabalhar com o código, como o [VSCode](https://code.visualstudio.com/).

### Clonando e Executando

```bash
# Clone este repositório
$ git clone git@github.com:pabloxt14/payflow.git

# Acesse a pasta do projeto
$ cd payflow

# Instale as dependências
$ flutter pub get

# Configurar projeto no Firebase de acordo com a seguinte documentação (https://firebase.google.com/docs/flutter/setup?hl=pt-br&platform=ios)

# Criar o seu arquivo .env com base no .env.example

# Rode o app (escolha o aparelho/emulador desejado)
$ flutter run --dart-define-from-file=.env
```

> Se necessário, consulte o guia oficial do Flutter para rodar o projeto em diferentes plataformas: [Flutter - Deploy](https://docs.flutter.dev/deployment)

## 🛠 Technologies

O projeto foi desenvolvido com as seguintes tecnologias principais:
- **[Flutter](https://flutter.dev/)**
- **[Dart](https://dart.dev/)**
- **[Firebase](https://firebase.google.com/docs/flutter/setup?hl=pt-br&platform=ios)**
- **[Google Sign In](https://pub.dev/packages/google_sign_in)**
- **[Google ML Kit](https://pub.dev/packages/google_mlkit_barcode_scanning)** (para leitura de boletos)
- **[Shared Preferences](https://pub.dev/packages/shared_preferences)**
- **[Google Fonts](https://pub.dev/packages/google_fonts)**
- **[Camera](https://pub.dev/packages/camera)**
- **[Image Picker](https://pub.dev/packages/image_picker)**
- **[Font Awesome](https://pub.dev/packages/font_awesome_flutter)**
- **[Signals](https://pub.dev/packages/signals)**
- **[Flutter Animate](https://pub.dev/packages/flutter_animate)**
- **[UUID](https://pub.dev/packages/uuid)**
- **[Toastfication](https://pub.dev/packages/toastification)**

> Para mais detalhes das dependências, confira o arquivo [pubspec.yaml](./pubspec.yaml)

## 📝 License

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](./LICENSE) para mais informações.

<p align="center">
  Feito com 💜 por Pablo Alan 👋🏽 <a href="https://www.linkedin.com/in/pabloalan/" target="_blank">Entre em contato!</a>  
</p>
