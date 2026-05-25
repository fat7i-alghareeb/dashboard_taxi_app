import 'dart:convert';
import 'dart:io';

void main() {
  final langs = ["nl", "de", "pl", "uk", "fr", "es", "ro"];
  final keysToCopy = [
    "driverOnline",
    "driverOffline",
    "driverConnected",
    "driverReconnecting",
    "driverDisconnected",
    "earningsToday",
    "tripsCompletedToday",
    "activeStatus",
    "vehicleRequired",
    "needActiveVehicle"
  ];

  final enFile = File(r"c:\Users\Fat7i\myProject\fat7i\dashboardtaxi\assets\l10n\en.json");
  final l10nDir = Directory(r"c:\Users\Fat7i\myProject\fat7i\dashboardtaxi\assets\l10n");

  if (!enFile.existsSync()) {
    print("Error: en.json does not exist!");
    return;
  }

  final enContent = enFile.readAsStringSync();
  final Map<String, dynamic> enData = jsonDecode(enContent) as Map<String, dynamic>;

  for (final lang in langs) {
    final destFile = File("${l10nDir.path}/${lang}.json");
    if (!destFile.existsSync()) {
      print("Warning: ${destFile.path} does not exist. Skipping.");
      continue;
    }

    final destContent = destFile.readAsStringSync();
    final Map<String, dynamic> destData = jsonDecode(destContent) as Map<String, dynamic>;

    int copied = 0;
    for (final key in keysToCopy) {
      if (enData.containsKey(key)) {
        destData[key] = enData[key];
        copied++;
      }
    }

    final encoder = JsonEncoder.withIndent("  ");
    final updatedContent = encoder.convert(destData);
    destFile.writeAsStringSync(updatedContent);

    print("Copied $copied keys to ${lang}.json");
  }

  print("Done copying driver keys!");
}
