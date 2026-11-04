# Cloudy Notes — projeto Android (Capacitor)

App ID: com.cloudynotes.app · Nome: Cloudy Notes · Orientação: retrato · 100% offline
Dados salvos com Capacitor Preferences (armazenamento nativo do Android).

## Gerar o APK (sem instalar nada no PC)
1. Crie um repositório no GitHub e envie o conteúdo desta pasta (arraste os arquivos pelo site, incluindo a pasta `.github`).
2. Abra a aba **Actions** → **Build Cloudy Notes APK** → **Run workflow** (também roda sozinho a cada envio).
3. Quando terminar (~5–8 min), abra a execução e baixe o artefato **CloudyNotes** (zip com `CloudyNotes.apk` e `CloudyNotes.aab`).

## Gerar localmente (Linux/macOS)
Com Node 20+, JDK 21 e Android SDK: `./build.sh` → arquivos em `output/`.

## Instalar no celular
Envie o `CloudyNotes.apk` ao celular, abra-o e permita "Instalar apps desconhecidos" para o app que abriu o arquivo. Depois toque em Instalar.

Obs.: o APK é assinado com uma chave gerada pelo script. Guarde `cloudynotes.keystore` se for atualizar o app depois (no GitHub, cada build gera uma nova chave; para atualizar por cima, desinstale antes). O AAB não é assinado e serve apenas se for assinar depois para a Play Store.
