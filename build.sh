#!/usr/bin/env bash
# Requer: Node 20+, JDK 21 e Android SDK (ANDROID_HOME). No GitHub Actions tudo já vem pronto.
set -euo pipefail
npm install
[ -d android ] || npx cap add android
npx capacitor-assets generate --android
M=android/app/src/main/AndroidManifest.xml
grep -q screenOrientation "$M" || sed -i 's/<activity/<activity android:screenOrientation="portrait"/' "$M"
npx cap sync android
(cd android && ./gradlew assembleRelease bundleRelease)
mkdir -p output
KS=cloudynotes.keystore
[ -f "$KS" ] || keytool -genkeypair -keystore "$KS" -alias cloudy -keyalg RSA -keysize 2048 -validity 10000 \
  -storepass cloudynotes -keypass cloudynotes -dname "CN=Cloudy Notes, O=Cloudy Notes, C=BR"
BT=$(ls -d "$ANDROID_HOME"/build-tools/* | sort -V | tail -1)
"$BT/zipalign" -f -p 4 android/app/build/outputs/apk/release/app-release-unsigned.apk output/aligned.apk
"$BT/apksigner" sign --ks "$KS" --ks-pass pass:cloudynotes --key-pass pass:cloudynotes --out output/CloudyNotes.apk output/aligned.apk
rm -f output/aligned.apk output/*.idsig
cp android/app/build/outputs/bundle/release/app-release.aab output/CloudyNotes.aab
echo "Pronto: output/CloudyNotes.apk e output/CloudyNotes.aab"
