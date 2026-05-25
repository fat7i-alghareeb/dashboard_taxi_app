import 'dart:convert';
import 'dart:io';

void main() {
  final langs = ["en", "ar", "nl", "de", "pl", "uk", "fr", "es", "ro"];
  final keysToCopy = [
    "loginLandingTagline",
    "loginLandingDiscountTitle",
    "loginLandingDiscountSubtitle",
    "loginLandingDiscountFooter",
    "loginLandingRegister",
    "loginLandingLogin",
    "loginLandingFooter",
    "login"
  ];

  final srcDir = Directory(r"c:\Users\Fat7i\myProject\fat7i\customertaxi\assets\l10n");
  final destDir = Directory(r"c:\Users\Fat7i\myProject\fat7i\dashboardtaxi\assets\l10n");

  print("Starting to copy landing localization keys via Dart...");

  for (final lang in langs) {
    final srcFile = File("${srcDir.path}/${lang}.json");
    final destFile = File("${destDir.path}/${lang}.json");

    if (!srcFile.existsSync()) {
      print("Warning: Source file ${srcFile.path} does not exist. Skipping.");
      continue;
    }
    if (!destFile.existsSync()) {
      print("Warning: Destination file ${destFile.path} does not exist. Skipping.");
      continue;
    }

    final srcContent = srcFile.readAsStringSync();
    final destContent = destFile.readAsStringSync();

    final Map<String, dynamic> srcData = jsonDecode(srcContent) as Map<String, dynamic>;
    final Map<String, dynamic> destData = jsonDecode(destContent) as Map<String, dynamic>;

    int copied = 0;
    for (final key in keysToCopy) {
      if (srcData.containsKey(key)) {
        destData[key] = srcData[key];
        copied++;
      } else {
        print("Warning: Key $key not found in source ${lang}.json");
      }
    }

    final encoder = JsonEncoder.withIndent("  ");
    final updatedContent = encoder.convert(destData);
    destFile.writeAsStringSync(updatedContent);

    print("Successfully copied $copied keys to ${lang}.json");
  }

  print("Finished!");
}
