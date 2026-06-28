import 'dart:convert';
import 'dart:io';

/// One-shot helper: merges the customers / customer-filter translation keys into
/// every assets/l10n/<code>.json file (adding only missing keys, preserving
/// existing content). Run once, then run tool/generate_app_strings.dart.
///
///   dart run tool/add_customer_strings.dart
Future<void> main() async {
  const dir = 'assets/l10n';

  for (final entry in _translations.entries) {
    final code = entry.key;
    final additions = entry.value;
    final file = File('$dir/$code.json');
    if (!file.existsSync()) {
      stderr.writeln('Missing $dir/$code.json — skipped');
      continue;
    }

    final map = (json.decode(await file.readAsString()) as Map)
        .cast<String, dynamic>();

    var added = 0;
    additions.forEach((key, value) {
      if (!map.containsKey(key)) {
        map[key] = value;
        added++;
      }
    });

    const encoder = JsonEncoder.withIndent('  ');
    await file.writeAsString('${encoder.convert(map)}\n');
    stdout.writeln('[$code] +$added keys (total ${map.length})');
  }
  stdout.writeln('Done. Now run: dart run tool/generate_app_strings.dart');
}

/// langCode -> (key -> translation).
const Map<String, Map<String, String>> _translations = {
  'en': {
    'customersTitle': 'Customers',
    'customerSearchHint': 'Search by name, phone or email',
    'customersNone': 'No customers',
    'customerPickerTitle': 'Select customer',
    'customerFilterByCustomer': 'Filter by customer',
    'customerFilterLabel': 'Customer',
    'customerProfileTitle': 'Customer profile',
    'customerPhone': 'Phone',
    'customerEmail': 'Email',
    'customerHomeAddress': 'Home address',
    'customerJoined': 'Joined',
    'customerActive': 'Active',
    'customerSuspended': 'Suspended',
    'customerViewRecords': 'View records',
    'customerViewIncidents': 'View incidents',
    'customerSuspend': 'Suspend',
    'customerReactivate': 'Reactivate',
    'customerSuspendTitle': 'Suspend customer',
    'customerReactivateTitle': 'Reactivate customer',
    'customerSuspendConfirm':
        'This customer will no longer be able to sign in. Continue?',
    'customerReactivateConfirm': "Restore this customer's access?",
    'customerSuspendedDone': 'Customer suspended',
    'customerReactivatedDone': 'Customer reactivated',
  },
  'ar': {
    'customersTitle': 'العملاء',
    'customerSearchHint': 'ابحث بالاسم أو الهاتف أو البريد',
    'customersNone': 'لا يوجد عملاء',
    'customerPickerTitle': 'اختر عميلاً',
    'customerFilterByCustomer': 'تصفية حسب العميل',
    'customerFilterLabel': 'العميل',
    'customerProfileTitle': 'ملف العميل',
    'customerPhone': 'الهاتف',
    'customerEmail': 'البريد الإلكتروني',
    'customerHomeAddress': 'عنوان المنزل',
    'customerJoined': 'تاريخ الانضمام',
    'customerActive': 'نشط',
    'customerSuspended': 'موقوف',
    'customerViewRecords': 'عرض الرحلات',
    'customerViewIncidents': 'عرض الحوادث',
    'customerSuspend': 'إيقاف',
    'customerReactivate': 'إعادة تفعيل',
    'customerSuspendTitle': 'إيقاف العميل',
    'customerReactivateTitle': 'إعادة تفعيل العميل',
    'customerSuspendConfirm': 'لن يتمكن هذا العميل من تسجيل الدخول. هل تريد المتابعة؟',
    'customerReactivateConfirm': 'استعادة وصول هذا العميل؟',
    'customerSuspendedDone': 'تم إيقاف العميل',
    'customerReactivatedDone': 'تمت إعادة تفعيل العميل',
  },
  'nl': {
    'customersTitle': 'Klanten',
    'customerSearchHint': 'Zoek op naam, telefoon of e-mail',
    'customersNone': 'Geen klanten',
    'customerPickerTitle': 'Klant selecteren',
    'customerFilterByCustomer': 'Filteren op klant',
    'customerFilterLabel': 'Klant',
    'customerProfileTitle': 'Klantprofiel',
    'customerPhone': 'Telefoon',
    'customerEmail': 'E-mail',
    'customerHomeAddress': 'Thuisadres',
    'customerJoined': 'Lid sinds',
    'customerActive': 'Actief',
    'customerSuspended': 'Geschorst',
    'customerViewRecords': 'Ritten bekijken',
    'customerViewIncidents': 'Incidenten bekijken',
    'customerSuspend': 'Schorsen',
    'customerReactivate': 'Heractiveren',
    'customerSuspendTitle': 'Klant schorsen',
    'customerReactivateTitle': 'Klant heractiveren',
    'customerSuspendConfirm':
        'Deze klant kan niet meer inloggen. Doorgaan?',
    'customerReactivateConfirm': 'Toegang van deze klant herstellen?',
    'customerSuspendedDone': 'Klant geschorst',
    'customerReactivatedDone': 'Klant geheractiveerd',
  },
  'de': {
    'customersTitle': 'Kunden',
    'customerSearchHint': 'Suche nach Name, Telefon oder E-Mail',
    'customersNone': 'Keine Kunden',
    'customerPickerTitle': 'Kunde auswählen',
    'customerFilterByCustomer': 'Nach Kunde filtern',
    'customerFilterLabel': 'Kunde',
    'customerProfileTitle': 'Kundenprofil',
    'customerPhone': 'Telefon',
    'customerEmail': 'E-Mail',
    'customerHomeAddress': 'Privatadresse',
    'customerJoined': 'Beigetreten',
    'customerActive': 'Aktiv',
    'customerSuspended': 'Gesperrt',
    'customerViewRecords': 'Fahrten ansehen',
    'customerViewIncidents': 'Vorfälle ansehen',
    'customerSuspend': 'Sperren',
    'customerReactivate': 'Reaktivieren',
    'customerSuspendTitle': 'Kunde sperren',
    'customerReactivateTitle': 'Kunde reaktivieren',
    'customerSuspendConfirm':
        'Dieser Kunde kann sich nicht mehr anmelden. Fortfahren?',
    'customerReactivateConfirm': 'Zugang dieses Kunden wiederherstellen?',
    'customerSuspendedDone': 'Kunde gesperrt',
    'customerReactivatedDone': 'Kunde reaktiviert',
  },
  'pl': {
    'customersTitle': 'Klienci',
    'customerSearchHint': 'Szukaj po nazwisku, telefonie lub e-mailu',
    'customersNone': 'Brak klientów',
    'customerPickerTitle': 'Wybierz klienta',
    'customerFilterByCustomer': 'Filtruj wg klienta',
    'customerFilterLabel': 'Klient',
    'customerProfileTitle': 'Profil klienta',
    'customerPhone': 'Telefon',
    'customerEmail': 'E-mail',
    'customerHomeAddress': 'Adres domowy',
    'customerJoined': 'Dołączył',
    'customerActive': 'Aktywny',
    'customerSuspended': 'Zawieszony',
    'customerViewRecords': 'Zobacz przejazdy',
    'customerViewIncidents': 'Zobacz zgłoszenia',
    'customerSuspend': 'Zawieś',
    'customerReactivate': 'Przywróć',
    'customerSuspendTitle': 'Zawieś klienta',
    'customerReactivateTitle': 'Przywróć klienta',
    'customerSuspendConfirm':
        'Ten klient nie będzie mógł się zalogować. Kontynuować?',
    'customerReactivateConfirm': 'Przywrócić dostęp tego klienta?',
    'customerSuspendedDone': 'Klient zawieszony',
    'customerReactivatedDone': 'Klient przywrócony',
  },
  'uk': {
    'customersTitle': 'Клієнти',
    'customerSearchHint': 'Пошук за імʼям, телефоном або email',
    'customersNone': 'Немає клієнтів',
    'customerPickerTitle': 'Виберіть клієнта',
    'customerFilterByCustomer': 'Фільтр за клієнтом',
    'customerFilterLabel': 'Клієнт',
    'customerProfileTitle': 'Профіль клієнта',
    'customerPhone': 'Телефон',
    'customerEmail': 'Email',
    'customerHomeAddress': 'Домашня адреса',
    'customerJoined': 'Приєднався',
    'customerActive': 'Активний',
    'customerSuspended': 'Призупинено',
    'customerViewRecords': 'Переглянути поїздки',
    'customerViewIncidents': 'Переглянути інциденти',
    'customerSuspend': 'Призупинити',
    'customerReactivate': 'Відновити',
    'customerSuspendTitle': 'Призупинити клієнта',
    'customerReactivateTitle': 'Відновити клієнта',
    'customerSuspendConfirm':
        'Цей клієнт більше не зможе увійти. Продовжити?',
    'customerReactivateConfirm': 'Відновити доступ цього клієнта?',
    'customerSuspendedDone': 'Клієнта призупинено',
    'customerReactivatedDone': 'Клієнта відновлено',
  },
  'fr': {
    'customersTitle': 'Clients',
    'customerSearchHint': 'Rechercher par nom, téléphone ou e-mail',
    'customersNone': 'Aucun client',
    'customerPickerTitle': 'Sélectionner un client',
    'customerFilterByCustomer': 'Filtrer par client',
    'customerFilterLabel': 'Client',
    'customerProfileTitle': 'Profil du client',
    'customerPhone': 'Téléphone',
    'customerEmail': 'E-mail',
    'customerHomeAddress': 'Adresse du domicile',
    'customerJoined': 'Inscrit le',
    'customerActive': 'Actif',
    'customerSuspended': 'Suspendu',
    'customerViewRecords': 'Voir les trajets',
    'customerViewIncidents': 'Voir les incidents',
    'customerSuspend': 'Suspendre',
    'customerReactivate': 'Réactiver',
    'customerSuspendTitle': 'Suspendre le client',
    'customerReactivateTitle': 'Réactiver le client',
    'customerSuspendConfirm':
        'Ce client ne pourra plus se connecter. Continuer ?',
    'customerReactivateConfirm': "Rétablir l'accès de ce client ?",
    'customerSuspendedDone': 'Client suspendu',
    'customerReactivatedDone': 'Client réactivé',
  },
  'es': {
    'customersTitle': 'Clientes',
    'customerSearchHint': 'Buscar por nombre, teléfono o correo',
    'customersNone': 'Sin clientes',
    'customerPickerTitle': 'Seleccionar cliente',
    'customerFilterByCustomer': 'Filtrar por cliente',
    'customerFilterLabel': 'Cliente',
    'customerProfileTitle': 'Perfil del cliente',
    'customerPhone': 'Teléfono',
    'customerEmail': 'Correo',
    'customerHomeAddress': 'Dirección de casa',
    'customerJoined': 'Se unió',
    'customerActive': 'Activo',
    'customerSuspended': 'Suspendido',
    'customerViewRecords': 'Ver viajes',
    'customerViewIncidents': 'Ver incidencias',
    'customerSuspend': 'Suspender',
    'customerReactivate': 'Reactivar',
    'customerSuspendTitle': 'Suspender cliente',
    'customerReactivateTitle': 'Reactivar cliente',
    'customerSuspendConfirm':
        'Este cliente ya no podrá iniciar sesión. ¿Continuar?',
    'customerReactivateConfirm': '¿Restaurar el acceso de este cliente?',
    'customerSuspendedDone': 'Cliente suspendido',
    'customerReactivatedDone': 'Cliente reactivado',
  },
  'ro': {
    'customersTitle': 'Clienți',
    'customerSearchHint': 'Caută după nume, telefon sau e-mail',
    'customersNone': 'Niciun client',
    'customerPickerTitle': 'Selectează clientul',
    'customerFilterByCustomer': 'Filtrează după client',
    'customerFilterLabel': 'Client',
    'customerProfileTitle': 'Profil client',
    'customerPhone': 'Telefon',
    'customerEmail': 'E-mail',
    'customerHomeAddress': 'Adresă domiciliu',
    'customerJoined': 'Înscris',
    'customerActive': 'Activ',
    'customerSuspended': 'Suspendat',
    'customerViewRecords': 'Vezi cursele',
    'customerViewIncidents': 'Vezi incidentele',
    'customerSuspend': 'Suspendă',
    'customerReactivate': 'Reactivează',
    'customerSuspendTitle': 'Suspendă clientul',
    'customerReactivateTitle': 'Reactivează clientul',
    'customerSuspendConfirm':
        'Acest client nu se va mai putea autentifica. Continuați?',
    'customerReactivateConfirm': 'Restabiliți accesul acestui client?',
    'customerSuspendedDone': 'Client suspendat',
    'customerReactivatedDone': 'Client reactivat',
  },
};
